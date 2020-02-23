package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TAdmin;
import com.duheng.atcrowdfunding.mapper.TAdminMapper;
import com.duheng.atcrowdfunding.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/*************************
 Author: 杜衡
 Date: 2020/2/23
 Describe:
 *************************/
@Service
public class AdminServiceImpl implements IAdminService {

    @Autowired
    private TAdminMapper tAdminMapper;
    @Override
    public List<TAdmin> queryAdmins() {
        return tAdminMapper.selectByExample(null);
    }
}
