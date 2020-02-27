package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TMenu;
import com.duheng.atcrowdfunding.mapper.TMenuMapper;
import com.duheng.atcrowdfunding.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/*************************
 Author: 杜衡
 Date: 2020/2/25
 Describe:
 *************************/
@Service
public class MenuServiceImpl implements IMenuService {
    @Autowired
    private TMenuMapper tMenuMapper;

    @Override
    public List<TMenu> getMenu() {
        return tMenuMapper.selectByExample(null);
    }

    @Override
    public int save(TMenu menu) {
        return tMenuMapper.insertSelective(menu);
    }

    @Override
    public TMenu getMenuById(Integer id) {

        return tMenuMapper.selectByPrimaryKey(id);
    }

    @Override
    public int modifyMenu(TMenu menu) {
        return tMenuMapper.updateByPrimaryKeySelective(menu);
    }

    @Override
    public int removeMenu(Integer id) {

        return tMenuMapper.deleteByPrimaryKey(id);
    }
}
