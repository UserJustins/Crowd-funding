package com.duheng.atcrowdfunding.service;

import com.duheng.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface IRoleService {

	/**
	 * 新增角色
	 * @param role
	 */
	int saveRole(TRole role);

	/**
	 * 查询所有的角色，并封装成PageInfo对象
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

	/**
	 * 获取用户已分配的角色
	 * @param id
	 * @return
	 */
    List<TRole> getAssignRole(Integer id);

	/**
	 * 获取用户未分配角色
	 * @param id
	 * @return
	 */
	List<TRole> getNotAssignRole(Integer id);
}
