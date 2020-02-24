package com.duheng.atcrowdfunding.service;

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
	 * @param name
	 */
	int saveRole(String name);

}
