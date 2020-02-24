package com.duheng.atcrowdfunding.mapper;

import com.duheng.atcrowdfunding.bean.TAdmin;
import com.duheng.atcrowdfunding.bean.TAdminExample;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TAdminMapper {
    long countByExample(TAdminExample example);

    int deleteByExample(TAdminExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(TAdmin record);

    int insertSelective(TAdmin record);

    List<TAdmin> selectByExample(TAdminExample example);

    TAdmin selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") TAdmin record, @Param("example") TAdminExample example);

    int updateByExample(@Param("record") TAdmin record, @Param("example") TAdminExample example);

    int updateByPrimaryKeySelective(TAdmin record);

    int updateByPrimaryKey(TAdmin record);

    List<TAdmin> selectAdminByKeyword(String keyword);

    /**
     * 删除操作，可实现批量删除，使用动态SQL
     * @param ids
     * @return
     */
    int deleteAdmin(@Param("ids") Integer[] ids);
}