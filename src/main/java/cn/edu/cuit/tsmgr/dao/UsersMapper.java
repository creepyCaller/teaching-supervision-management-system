package cn.edu.cuit.tsmgr.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import cn.edu.cuit.tsmgr.model.Users;
import org.springframework.stereotype.Repository;

@Repository
public interface UsersMapper {
    int deleteByPrimaryKey(@Param("username") String username);

    int deleteByPrimaryKeys(@Param("primaryKeys") String[] primaryKeys);

    int insert(Users record);

    int insertSelective(Users record);

    Users selectByPrimaryKey(@Param("username") String username);

    int updateByPrimaryKeySelective(Users record);

    int updateByPrimaryKey(Users record);

    List<Users> loadModels(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    List<Map<String, Object>> loadMaps(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    long count(@Param("parameters") String parameters, @Param("condition") String condition, @Param("isDistinct") boolean isDistinct);

    Users findModel(@Param("username") String username, @Param("parameters") String parameters);

    Map<String, Object> findMap(@Param("username") String username, @Param("parameters") String parameters);
}
