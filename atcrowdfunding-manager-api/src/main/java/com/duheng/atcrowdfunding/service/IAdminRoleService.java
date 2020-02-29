package com.duheng.atcrowdfunding.service;

public interface IAdminRoleService {
    /**
     * 给用户添加角色
     * @param ids roleID+adminID，最后一个元素是adminID
     * @return
     */
    int addRoles(Integer[] ids);

    /**
     * 撤销用户的角色
     * @param ids roleID+adminID，最后一个元素是adminID
     * @return
     */
    int deleteRoles(Integer[] ids);
}
