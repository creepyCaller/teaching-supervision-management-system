package cn.edu.cuit.tsmgr.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import cn.edu.cuit.tsmgr.model.Systemimformation;
import org.springframework.stereotype.Repository;

@Repository
public interface SystemimformationMapper {
    int deleteByPrimaryKey(@Param("id") Integer id);

    int deleteByPrimaryKeys(@Param("primaryKeys") Integer[] primaryKeys);

    int insert(Systemimformation record);

    int insertSelective(Systemimformation record);

    Systemimformation selectByPrimaryKey(@Param("id") Integer id);

    int updateByPrimaryKeySelective(Systemimformation record);

    int updateByPrimaryKey(Systemimformation record);

    List<Systemimformation> loadModels(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    List<Map<String, Object>> loadMaps(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    long count(@Param("parameters") String parameters, @Param("condition") String condition, @Param("isDistinct") boolean isDistinct);

    Systemimformation findModel(@Param("id") Integer id, @Param("parameters") String parameters);

    Map<String, Object> findMap(@Param("id") Integer id, @Param("parameters") String parameters);
}
