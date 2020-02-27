package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TPermission;
import com.duheng.atcrowdfunding.mapper.TPermissionMapper;
import com.duheng.atcrowdfunding.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/*************************
 Author: 杜衡
 Date: 2020/2/26
 Describe:
 *************************/
@Service
public class PermissionServiceImpl implements IPermissionService {


    @Autowired
    private TPermissionMapper permissionMapper;

    @Override
    public List<TPermission> getPermissions() {
        return permissionMapper.selectByExample(null);
    }

    @Override
    public int savePermission(TPermission permission) {
        return permissionMapper.insertSelective(permission);
    }

    @Override
    public TPermission get(Integer id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public int removePermission(Integer id) {
        return permissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public int updatePermission(TPermission per) {
        return permissionMapper.updateByPrimaryKeySelective(per);
    }
}
