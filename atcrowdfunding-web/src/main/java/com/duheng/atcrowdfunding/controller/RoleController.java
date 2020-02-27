package com.duheng.atcrowdfunding.controller;

import com.duheng.atcrowdfunding.bean.TRole;
import com.duheng.atcrowdfunding.service.IRoleService;
import com.duheng.crowdfunding.utils.Const;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	private IRoleService roleService;
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
