package com.duheng.atcrowdfunding.service;

import com.duheng.atcrowdfunding.bean.TAdmin;
import com.github.pagehelper.PageInfo;

public interface IAdminService {
	/**
	 * 根据账户信息查询管理员
	 * @param loginAcct 管理员登录的账号
	 * @param userPswd 
	 * @return
	 */
	TAdmin login(String loginAcct, String userPswd);
	/**
	 * 根据关键词来进行查询,因为需要进行分页，因此封装成PageInfo
	 * @param pageNum 当前是第几页
	 * @param pageSize 一页显示多少
	 * @param keyword 关键字
	 * @return
	 */
	PageInfo<TAdmin> getAdminByKeyWord(Integer pageNum, Integer pageSize, String keyword);
	/**
	 * 删除操作
	 * @param ids Admin的ID值，前台传来数组类型
	 * @return
	 */
	int removeById(String[] ids);
	/**
	 * 增加管理员
	 * @param admin
	 * @return
	 */
	int addAdmin(TAdmin admin);
	/**
	 * 根据ID查询管理员
	 * @param id
	 * @return
	 */
	TAdmin getAdminById(String id);
	/**
	 * 修改Admin
	 * @param admin
	 * @return
	 */
	int modifyAdmin(TAdmin admin);

}
