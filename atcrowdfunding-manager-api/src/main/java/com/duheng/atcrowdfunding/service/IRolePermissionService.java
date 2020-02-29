package com.duheng.atcrowdfunding.service;

import com.duheng.atcrowdfunding.bean.TRolePermission;

import java.util.List;

public interface IRolePermissionService {

    List<TRolePermission> getByRoleId(Integer id);

    int addRolePermission(Integer[] id);
}
