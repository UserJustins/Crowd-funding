package com.duheng.atcrowdfunding.service;

import com.duheng.atcrowdfunding.bean.TMenu;

import java.util.List;

public interface IMenuService {

	/**
	 * 查询所有的menu
	 */
	List<TMenu> getMenuTree_1();
	/**
	 * 查询所有的menu
	 */
	List<TMenu> getMenuTree_2();
	/**
	 * 查询所有的menu
	 */
	List<TMenu> getMenu();
	/**
	 * 保存菜单
	 * @return
	 */
	int save(TMenu menu);
	/**
	 * 根据ID查Menu
	 * @param id
	 * @return
	 */
	TMenu getMenuById(Integer id);
	/**
	 * 更新菜单信息
	 * @param menu
	 * @return
	 */
	int modifyMenu(TMenu menu);
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	int removeMenu(Integer id);

	
}
