package com.duheng.atcrowdfunding.controller;

import com.duheng.atcrowdfunding.bean.TMenu;
import com.duheng.atcrowdfunding.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {
	@Autowired
	private IMenuService menuService;

	@RequestMapping("/tree1")
	@ResponseBody
	public List<TMenu> tree1(){
		return menuService.getMenuTree_1();
	}

	@RequestMapping("/tree2")
	@ResponseBody
	public List<TMenu> tree2(){
		return  menuService.getMenuTree_2();
	}

	/*
	 * 删除
	 */
	@RequestMapping("/remove")
	@ResponseBody
	public String remove(@RequestParam("id")Integer id){
		int num =  menuService.removeMenu(id);
		if(num<0){
			return "fail";
		}
		return "success";
	}
	/*
	 * 更新
	 */
	@RequestMapping("/modify")
	@ResponseBody
	public String modify(TMenu menu){
		int num =  menuService.modifyMenu(menu);
		if(num<0){
			return "fail";
		}
		return "success";
	}
	/*
	 * 查询菜单数据回显
	 */
	@RequestMapping("/get")
	@ResponseBody
	public TMenu get(@RequestParam("id")Integer id){

		return menuService.getMenuById(id);
	}

	/**
	 * 菜单的数据表结构是一对多的自关联
	 *  后台不需要封装成树形结构，直接查出来，前台的zTree会自行封装
	 * @return
	 */
	@RequestMapping("/search")
	@ResponseBody
	public List<TMenu> search(){
		return menuService.getMenu();
	}
	/*
	 * 查询出所有的菜单项，并且已经在业务层封装成了树形结构
	 */
	@RequestMapping("/save")
	@ResponseBody
	public String save(TMenu menu){
		int num = menuService.save(menu);
		if(num<0){
			return "faild";
		}
		return "success";
	}
}
