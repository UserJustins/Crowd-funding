package com.duheng.atcrowdfunding.service.impl;

import com.duheng.atcrowdfunding.bean.TMenu;
import com.duheng.atcrowdfunding.mapper.TMenuMapper;
import com.duheng.atcrowdfunding.service.IMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/*************************
 Author: 杜衡
 Date: 2020/2/25
 Describe:
 *************************/
@Service
public class MenuServiceImpl implements IMenuService {
    @Autowired
    private TMenuMapper tMenuMapper;

    /**
     * 查询出所有菜单项，封装成树形菜单,结合Mapper中的配置一起使用
     * 540条数据量测了测两种方式
     * 注意：使用该方式时：需在Mapper中打开注释
     * @return 900多
     */
    @Override
    public List<TMenu> getMenuTree_1() {
        long start = new Date().getTime();
        List<TMenu> list = tMenuMapper.selectWithChildrenTree();
        System.out.println("getMenuTree_1方法=======>"+(new Date().getTime()-start));
        return list;
    }

    /**
     * 查询出所有菜单项，封装成树形菜单
     * 效率很高
     *  1.查询出所有
     *  2.自行封装
     * @return 20左右
     */
    @Override
    public List<TMenu> getMenuTree_2() {
        long start = new Date().getTime();
        List<TMenu> list = new ArrayList();//所有的父节点及children
        Map<Integer, TMenu> cache = new HashMap<>();//只有父节点，children都为空
        //1.查所有
        List<TMenu> menuList = tMenuMapper.selectByExample(null);
        //2.找到所有的父节点
        Iterator<TMenu> iterator = menuList.iterator();
        while (iterator.hasNext()){
            TMenu menu = iterator.next();
            //2.1、找到父节点
            if (menu.getPid() == 0) {
                //2.2、添加进集合
                list.add(menu);
                //3.2、方便children找到父节点
                cache.put(menu.getId(), menu);
                //2.3、删除父节点，确保集合全是子节点，省的步骤3作判断
                iterator.remove();
            }
        }
        //3.给所有的父节点的children属性赋值
        for (TMenu menu : menuList) {//3.1、此时的集合没有任何父节点
            //3.2、根据children的Pid属性找到该节点的父节点
            //根据parentId找父节点又需要遍历list集合，麻烦！使用map
            Integer parentId = menu.getPid();
            TMenu parentNode = cache.get(parentId);
            //3.3、把当前子节点赋值给对应父节点的children属性上
            parentNode.getChildren().add(menu);

        }
        System.out.println("getMenuTree_2方法=======>"+(new Date().getTime()-start));
        return list;
    }

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
