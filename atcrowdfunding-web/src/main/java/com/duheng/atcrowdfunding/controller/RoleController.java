package com.duheng.atcrowdfunding.controller;

import com.duheng.atcrowdfunding.bean.TRole;
import com.duheng.atcrowdfunding.bean.TRolePermission;
import com.duheng.atcrowdfunding.service.IRolePermissionService;
import com.duheng.atcrowdfunding.service.IRoleService;
import com.duheng.crowdfunding.utils.Const;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;

	@Autowired
	private IRolePermissionService rolePermissionService;

	/**
	 * 根据角色的ID查询权限的id
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/getPermission")
	public List<TRolePermission> getPermission(@RequestParam(value = "id")Integer id){
		return rolePermissionService.getByRoleId(id);
	}
	/**
	 * 根据角色的ID查询权限的id
	 * @param id
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/assignPermission")
	public String  assignPermission(@RequestParam(value = "ids[]")Integer[] id){
		int num = rolePermissionService.addRolePermission(id);
		if (num > 0) {
			return "ok";
		}
		return "fail";
	}
	@ResponseBody
	@RequestMapping("/remove")
	public String remove(@RequestParam(value = "ids[]")Integer[] ids){
		int num = roleService.remove(ids);
		if (num > 0) {
			return "success";

		}
		return "fail";
	}

	/**
	 * 修改操作
	 * @param role
	 * @return
	 */
	@RequestMapping("/doEdit")
	@ResponseBody
	public String doEdit(TRole role){
		int num = roleService.updateRoleByRole(role);
		if (num>0) {
			return "success";
		}
		return "fail";
	}
	/**
	 * 保存
	 * @param role
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	public String save(TRole role){
		int result = roleService.saveRole(role);
		if(result > 0){
			return "success";
		}
		return "fail";
	}
	@RequestMapping("/keySearch")
	public String search(@RequestParam(value="pageSize",defaultValue="5")Integer pageSize,
						@RequestParam(value="pageNum", defaultValue="1")Integer pageNum,
						@RequestParam(value="keyword",defaultValue="")String keyword,Model model){
		PageInfo<TRole> pageInfo = roleService.getRoleByKeyword(pageSize,pageNum,keyword);
		model.addAttribute(Const.PAGE_INFO_KEY, pageInfo);
		System.out.println(pageInfo);
		return "role-page";
	}
	
}
