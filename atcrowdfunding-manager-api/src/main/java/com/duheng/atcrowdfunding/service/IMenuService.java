package com.duheng.atcrowdfunding.service;

import com.duheng.atcrowdfunding.bean.TMenu;

public interface IMenuService {
	/**
	 * 获取封装成树形的menu
	 */
	TMenu getMenu();
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
