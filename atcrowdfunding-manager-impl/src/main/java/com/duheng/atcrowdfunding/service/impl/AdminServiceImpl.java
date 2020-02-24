package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TAdmin;
import com.duheng.atcrowdfunding.bean.TAdminExample;
import com.duheng.atcrowdfunding.mapper.TAdminMapper;
import com.duheng.atcrowdfunding.service.IAdminService;
import com.duheng.crowdfunding.utils.MD5Util;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/*************************
 Author: 杜衡
 Date: 2020/2/24
 Describe:
 *************************/
@Service
public class AdminServiceImpl implements IAdminService {

    @Autowired
    private TAdminMapper tAdminMapper;

    /**
     * 根据账号查TAdmin实体对象
     * @param loginAcct 管理员登录的账号
     * @param userPswd
     * @return
     */
    @Override
    public TAdmin login(String loginAcct, String userPswd) {
        TAdminExample tAdminExample = new TAdminExample();
        //根据账号进行查询
        tAdminExample.createCriteria().andLoginacctEqualTo(loginAcct);
        TAdmin admin = tAdminMapper.selectByExample(tAdminExample).get(0);
        if (Objects.equals(admin.getUserpswd(),MD5Util.digest(userPswd))) {
            return admin;
        }
        return null;
    }

    /**
     * Admin根据关键字分页查询
     * @param pageNum 当前是第几页
     * @param pageSize 一页显示多少
     * @param keyword 关键字
     * @return
     */
    @Override
    public PageInfo<TAdmin> getAdminByKeyWord(Integer pageNum, Integer pageSize, String keyword) {
        //1.调用PageHelper的工具方法，开启分页功能
        PageHelper.startPage(pageNum, pageSize);
        //2.执行分页的查询
        List<TAdmin> list = tAdminMapper.selectAdminByKeyword(keyword);
        //3.将list封装到PageHelper对象中，直接使用构造器就可以了
        return new PageInfo<TAdmin>(list);
    }

    @Override
    public int removeById(String[] ids) {
        Integer[] arr = new Integer[ids.length];
        for (int i = 0; i < arr.length; i++) {
            arr[i] = Integer.valueOf(ids[i]);
        }
        return tAdminMapper.deleteAdmin(arr);
    }

    /**
     * insert操作
     * @param admin
     * @return
     */
    @Override
    public int addAdmin(TAdmin admin) {
        admin.setUserpswd(MD5Util.digest("123456"));
        String createTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        admin.setCreatetime(createTime);
        return tAdminMapper.insertSelective(admin);
    }

    /**
     * 根据id进行查询
     * @param id
     * @return
     */
    @Override
    public TAdmin getAdminById(String id) {
        return tAdminMapper.selectByPrimaryKey(Integer.valueOf(id));
    }

    /**
     * 更新操作
     * @param admin
     * @return
     */
    @Override
    public int modifyAdmin(TAdmin admin) {
        return tAdminMapper.updateByPrimaryKeySelective(admin);
    }
}
