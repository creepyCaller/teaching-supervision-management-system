package cn.edu.cuit.tsmgr.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import cn.edu.cuit.tsmgr.model.Classes;
import org.springframework.stereotype.Repository;

@Repository
public interface ClassesMapper {
    int deleteByPrimaryKey(@Param("classname") String classname);

    int deleteByPrimaryKeys(@Param("primaryKeys") String[] primaryKeys);

    int insert(Classes record);

    int insertSelective(Classes record);

    Classes selectByPrimaryKey(@Param("classname") String classname);

    int updateByPrimaryKeySelective(Classes record);

    int updateByPrimaryKey(Classes record);

    List<Classes> loadModels(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    List<Map<String, Object>> loadMaps(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    long count(@Param("parameters") String parameters, @Param("condition") String condition, @Param("isDistinct") boolean isDistinct);

    Classes findModel(@Param("classname") String classname, @Param("parameters") String parameters);

    Map<String, Object> findMap(@Param("classname") String classname, @Param("parameters") String parameters);
}
