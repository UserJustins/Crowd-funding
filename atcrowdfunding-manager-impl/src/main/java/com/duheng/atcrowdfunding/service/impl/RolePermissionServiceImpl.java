package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TRolePermission;
import com.duheng.atcrowdfunding.bean.TRolePermissionExample;
import com.duheng.atcrowdfunding.mapper.TRolePermissionMapper;
import com.duheng.atcrowdfunding.service.IRolePermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/*************************
 Author: 杜衡
 Date: 2020/2/29
 Describe:
 *************************/
@Service
public class RolePermissionServiceImpl implements IRolePermissionService {

    @Autowired
    private TRolePermissionMapper rolePermissionMapper;
    @Override
    public List<TRolePermission> getByRoleId(Integer id) {
        TRolePermissionExample example = new TRolePermissionExample();
        example.createCriteria().andRoleidEqualTo(id);
        return rolePermissionMapper.selectByExample(example);
    }

    @Override
    public int  addRolePermission(Integer[] id) {
        int falg = 0 ;
        //拿出来roleID
        int length = id.length - 1;
        Integer roleId = id[length];
        //先删除掉roleId的权限
        TRolePermissionExample example = new TRolePermissionExample();
        example.createCriteria().andRoleidEqualTo(roleId);
        rolePermissionMapper.deleteByExample(example);
        //再添加
        for (int i = 0; i < length; i++) {
            TRolePermission obj = new TRolePermission();
            obj.setRoleid(roleId);
            obj.setPermissionid(id[i]);
            rolePermissionMapper.insertSelective(obj);
            falg ++;
        }
        return falg;
    }
}
