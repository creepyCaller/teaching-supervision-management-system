package cn.edu.cuit.tsmgr.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import cn.edu.cuit.tsmgr.model.Tasks;
import org.springframework.stereotype.Repository;

@Repository
public interface TasksMapper {
    int deleteByPrimaryKey(@Param("id") Integer id);

    int deleteByPrimaryKeys(@Param("primaryKeys") Integer[] primaryKeys);

    int insert(Tasks record);

    int insertSelective(Tasks record);

    Tasks selectByPrimaryKey(@Param("id") Integer id);

    int updateByPrimaryKeySelective(Tasks record);

    int updateByPrimaryKey(Tasks record);

    List<Tasks> loadModels(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    List<Map<String, Object>> loadMaps(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    long count(@Param("parameters") String parameters, @Param("condition") String condition, @Param("isDistinct") boolean isDistinct);

    Tasks findModel(@Param("id") Integer id, @Param("parameters") String parameters);

    Map<String, Object> findMap(@Param("id") Integer id, @Param("parameters") String parameters);
}
