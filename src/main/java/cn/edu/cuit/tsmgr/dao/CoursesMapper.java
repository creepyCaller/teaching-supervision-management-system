package cn.edu.cuit.tsmgr.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import cn.edu.cuit.tsmgr.model.Courses;
import org.springframework.stereotype.Repository;

@Repository
public interface CoursesMapper {
    int deleteByPrimaryKey(@Param("coursename") String coursename);

    int deleteByPrimaryKeys(@Param("primaryKeys") String[] primaryKeys);

    int insert(Courses record);

    int insertSelective(Courses record);

    Courses selectByPrimaryKey(@Param("coursename") String coursename);

    int updateByPrimaryKeySelective(Courses record);

    int updateByPrimaryKey(Courses record);

    List<Courses> loadModels(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    List<Map<String, Object>> loadMaps(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    long count(@Param("parameters") String parameters, @Param("condition") String condition, @Param("isDistinct") boolean isDistinct);

    Courses findModel(@Param("coursename") String coursename, @Param("parameters") String parameters);

    Map<String, Object> findMap(@Param("coursename") String coursename, @Param("parameters") String parameters);
}
