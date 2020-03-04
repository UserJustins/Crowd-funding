package com.duheng.atcrowdfunding.mapper;

import com.duheng.atcrowdfunding.bean.TMenu;
import com.duheng.atcrowdfunding.bean.TMenuExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TMenuMapper {

    List<TMenu> selectWithChildrenTree();

    long countByExample(TMenuExample example);

    int deleteByExample(TMenuExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TMenu record);

    int insertSelective(TMenu record);

    List<TMenu> selectByExample(TMenuExample example);

    TMenu selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TMenu record, @Param("example") TMenuExample example);

    int updateByExample(@Param("record") TMenu record, @Param("example") TMenuExample example);

    int updateByPrimaryKeySelective(TMenu record);

    int updateByPrimaryKey(TMenu record);


}