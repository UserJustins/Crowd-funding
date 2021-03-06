package com.duheng.atcrowdfunding.mapper;

import com.duheng.atcrowdfunding.bean.TRole;
import com.duheng.atcrowdfunding.bean.TRoleExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TRoleMapper {
    long countByExample(TRoleExample example);

    int deleteByExample(TRoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TRole record);

    int insertSelective(TRole record);

    List<TRole> selectByExample(TRoleExample example);

    TRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TRole record, @Param("example") TRoleExample example);

    int updateByExample(@Param("record") TRole record, @Param("example") TRoleExample example);

    int updateByPrimaryKeySelective(TRole record);

    int updateByPrimaryKey(TRole record);

    /**
     * 关键字的分页查询
     * @param keyword
     * @return
     */
    List<TRole> selectAdminByKeyword(String keyword);

    int batchRemoveById(@Param("ids") Integer[] ids);

    List<TRole> queryAssignRole(Integer id);

    List<TRole> queryNotAssignRole(Integer id);
}