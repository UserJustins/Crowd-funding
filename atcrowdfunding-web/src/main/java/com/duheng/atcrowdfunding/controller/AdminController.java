package com.duheng.atcrowdfunding.controller;


import com.duheng.atcrowdfunding.bean.TAdmin;
import com.duheng.atcrowdfunding.bean.TMenu;
import com.duheng.atcrowdfunding.bean.TRole;
import com.duheng.atcrowdfunding.service.IAdminRoleService;
import com.duheng.atcrowdfunding.service.IAdminService;
import com.duheng.atcrowdfunding.service.IMenuService;
import com.duheng.atcrowdfunding.service.IRoleService;
import com.duheng.crowdfunding.utils.Const;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private IAdminService adminService;

	@Autowired
	private IRoleService roleService;

	@Autowired
	private IAdminRoleService adminRoleService;
	@Autowired
	private IMenuService menuService;
	/**
	 * 添加用户分配的角色
	 * @param ids roleID+adminID，最后一个元素是adminID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/assignRole")
	public String assign(@RequestParam(value = "ids[]")Integer[] ids){
		int num = adminRoleService.addRoles(ids);
		if (num > 0) {
			return "success";

		}
		return "fail";
	}
	/**
	 * 撤销用户分配的角色
	 * @param ids roleID+adminID，最后一个元素是adminID
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/delAssignRole")
	public String delAssignRole(@RequestParam(value = "ids[]")Integer[] ids){
		int num = adminRoleService.deleteRoles(ids);
		if (num > 0) {
			return "success";

		}
		return "fail";
	}


	@RequestMapping("/toAssign")
	public String toAssign(Integer id,Model model) {
		//1.根据用户id查询用户已经分配的角色
		List<TRole> isAssList = roleService.getAssignRole(id);
		//2.根据用户id查询用户未分配的角色
		List<TRole> notAssList = roleService.getNotAssignRole(id);

		model.addAttribute(Const.ADMIN_IS_ASSIGN_ROLE, isAssList);
		model.addAttribute(Const.ADMIN_NOT_ASSIGN_ROLE, notAssList);

		return "admin-roleAssign";
	}
	/*
	 * 执行修改的操作
	 */
	@RequestMapping("/doEdit")
	public String doEdit(@RequestParam("pageNum")String pageNum,TAdmin admin) {
		adminService.modifyAdmin(admin);
		return "redirect:/admin/keySearch?pageNum="+pageNum;
	}
	/*
	 * 表单编辑需要数据回显管理员
	 */
	@RequestMapping("/edit")
	public String edit(@RequestParam("id")String id,Model model) {
		TAdmin admin = adminService.getAdminById(id);
		model.addAttribute("admin", admin);
		return "admin-edit";
	}
	/*
	 * 表单新增管理员
	 */
	@RequestMapping("/doAdd")
	public String doAdd(TAdmin admin) {
		adminService.addAdmin(admin);
		return "redirect:/admin/keySearch";
	}

	
	/*
	 * 批量删除和单个删除使用的是同一个方法 的操作 SpringMVC接受前台传过来的数组
	 */
	@RequestMapping("/remove")
	@ResponseBody
	public String batchRemove(@RequestParam(value = "ids[]") String[] ids) {
		System.out.println(Arrays.toString(ids));

		int num = adminService.removeById(ids);
		if(num < 0){
			return "false";
		}
		return "true";
	}

	/*
	 * 关键字的分页查询以及查询全部一起做
	 */
	@RequestMapping("/keySearch")
	//@ResponseBody
	public String /*PageInfo<TAdmin>*/ keySearch(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
			@RequestParam(value = "pageSize", defaultValue = "5") Integer pageSize,
			@RequestParam(value = "keyword", defaultValue = "") String keyword, Model model) {
		PageInfo<TAdmin> adminPageInfo = adminService.getAdminByKeyWord(pageNum, pageSize, keyword);
		model.addAttribute(Const.PAGE_INFO_KEY, adminPageInfo);
		return "admin-page";
		//return adminPageInfo;
	}

	/*
	 * 退出系统
	 */
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/index";
	}

	
	 /* 登录到主页面 登录成功后要是用重定向到主页面，但是主页面在WEB-INF下，只能使用请求转发
	 * 因此需要一个Handler方法来辅助它跳转，可是这里的没有是因为使用的XML的配置方式
	 */
	@RequestMapping("/doLogin")
	public String doLogin(String loginAcct, String userpswd, Model model, HttpSession session) {
		TAdmin admin = adminService.login(loginAcct, userpswd);
		if (admin == null) {// 如果输入的账号不存在或密码不正确
			// 反馈信息并且跳回登录页面
			model.addAttribute(Const.ARRT_NAME_MESSAGE, Const.MESSAGE_LOGIN_FAILED);
			return "admin-login";
		}
		// 将返回的对象放到session中。重定向到主页面
		session.setAttribute(Const.ARRT_NAME_IN_SESSION, admin);
		List<TMenu> menuTree_2 = menuService.getMenuTree_2();
		session.setAttribute(Const.ARRT_MENU_IN_SESSION, menuTree_2);

		return "redirect:/admin/main";
	}
	
}
