package cn.edu.cuit.tsmgr.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import cn.edu.cuit.tsmgr.model.Normalclassevaluatetables;

public interface NormalclassevaluatetablesMapper {
    int deleteByPrimaryKey(@Param("id") Integer id);

    int deleteByPrimaryKeys(@Param("primaryKeys") Integer[] primaryKeys);

    int insert(Normalclassevaluatetables record);

    int insertSelective(Normalclassevaluatetables record);

    Normalclassevaluatetables selectByPrimaryKey(@Param("id") Integer id);

    int updateByPrimaryKeySelective(Normalclassevaluatetables record);

    int updateByPrimaryKey(Normalclassevaluatetables record);

    List<Normalclassevaluatetables> loadModels(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    List<Map<String, Object>> loadMaps(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    long count(@Param("parameters") String parameters, @Param("condition") String condition, @Param("isDistinct") boolean isDistinct);

    Normalclassevaluatetables findModel(@Param("id") Integer id, @Param("parameters") String parameters);

    Map<String, Object> findMap(@Param("id") Integer id, @Param("parameters") String parameters);
}
