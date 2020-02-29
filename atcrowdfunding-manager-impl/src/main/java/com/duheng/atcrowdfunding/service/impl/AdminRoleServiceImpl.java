package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TAdminRole;
import com.duheng.atcrowdfunding.bean.TAdminRoleExample;
import com.duheng.atcrowdfunding.mapper.TAdminRoleMapper;
import com.duheng.atcrowdfunding.service.IAdminRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/*************************
 Author: 杜衡
 Date: 2020/2/28
 Describe:
 *************************/
@Service
public class AdminRoleServiceImpl implements IAdminRoleService {

    @Autowired
    private TAdminRoleMapper adminRoleMapper;


    @Override
    public int addRoles(Integer[] ids) {
        int num = 0;
        int length = ids.length - 1;
        for (int i = 0; i < length; i++) {
            TAdminRole ar = new TAdminRole();
            ar.setAdminid(ids[length]);
            ar.setRoleid(ids[i]);
            adminRoleMapper.insertSelective(ar);
            num++ ;
        }
        return num;
    }

    @Override
    public int deleteRoles(Integer[] ids) {
        int num = 0;
        int length = ids.length - 1;
        for (int i = 0; i < length; i++) {
            TAdminRoleExample example = new TAdminRoleExample();
            TAdminRoleExample.Criteria c =example.createCriteria();
            c.andAdminidEqualTo(ids[length]);
            c.andRoleidEqualTo(ids[i]);
            adminRoleMapper.deleteByExample(example);
            num++;
        }
        return num;
    }
}
