package com.duheng.atcrowdfunding.service;

import com.duheng.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

public interface IRoleService {

	/**
	 * 查询所有的角色，并封装成PageInfo对象
	 * @param pageSize
	 * @param pageNum
	 * @param keyword
	 * @return
	 */
	//PageInfo<TRole> getRoleByKeyword(Integer pageSize, Integer pageNum, String keyword);
	/**
	 * 新增角色
	 * @param role
	 */
	int saveRole(TRole role);

	/**
	 * 关键字分页查询
	 * @param pageSize
	 * @param pageNum
	 * @param keyword
	 * @return
	 */
	PageInfo<TRole> getRoleByKeyword(Integer pageSize, Integer pageNum, String keyword);

	int updateRoleByRole(TRole role);

	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	int remove(Integer[] ids);
}
