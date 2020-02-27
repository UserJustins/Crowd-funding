package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TRole;
import com.duheng.atcrowdfunding.mapper.TRoleMapper;
import com.duheng.atcrowdfunding.service.IRoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/*************************
 Author: 杜衡
 Date: 2020/2/25
 Describe:
 *************************/
@Service
public class RoleServiceImpl implements IRoleService {

    @Autowired
    private TRoleMapper tRoleMapper;

    /**
     * 保存操作
     * @param role
     * @return
     */
    @Override
    public int saveRole(TRole role) {
        return tRoleMapper.insertSelective(role);
    }

    /**
     * 根据关键字的分页查询
     * @param pageSize
     * @param pageNum
     * @param keyword
     * @return
     */
    @Override
    public PageInfo<TRole> getRoleByKeyword(Integer pageSize, Integer pageNum, String keyword) {
        //1.调用PageHelper的工具方法，开启分页功能
        PageHelper.startPage(pageNum, pageSize);
        //2.执行分页的查询
        List<TRole> list = tRoleMapper.selectAdminByKeyword(keyword);
        //3.将list封装到PageHelper对象中，直接使用构造器就可以了
        return new PageInfo<TRole>(list);
    }

    /**
     * 修改操作
     * @param role
     * @return
     */
    @Override
    public int updateRoleByRole(TRole role) {
        return tRoleMapper.updateByPrimaryKeySelective(role);
    }


    @Override
    public int remove(Integer[] ids) {
        return tRoleMapper.batchRemoveById(ids);
    }
}
