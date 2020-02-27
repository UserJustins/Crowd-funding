package com.duheng.atcrowdfunding.service;

import com.duheng.atcrowdfunding.bean.TPermission;

import java.util.List;

public interface IPermissionService {
    /**
     * 查询所有的权限菜单
     * @return
     */
    List<TPermission> getPermissions();

    int savePermission(TPermission permission);

    TPermission get(Integer id);

    int removePermission(Integer id);

    int updatePermission(TPermission per);
}
