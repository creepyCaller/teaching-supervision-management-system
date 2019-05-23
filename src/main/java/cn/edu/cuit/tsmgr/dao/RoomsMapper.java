package cn.edu.cuit.tsmgr.dao;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

import cn.edu.cuit.tsmgr.model.Rooms;
import org.springframework.stereotype.Repository;

@Repository
public interface RoomsMapper {
    int deleteByPrimaryKey(@Param("roomlocation") String roomlocation);

    int deleteByPrimaryKeys(@Param("primaryKeys") String[] primaryKeys);

    int insert(Rooms record);

    int insertSelective(Rooms record);

    Rooms selectByPrimaryKey(@Param("roomlocation") String roomlocation);

    int updateByPrimaryKeySelective(Rooms record);

    int updateByPrimaryKey(Rooms record);

    List<Rooms> loadModels(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    List<Map<String, Object>> loadMaps(@Param("parameters") String parameters, @Param("condition") String condition, @Param("order") String order, @Param("sort") String sort, @Param("offset") int offset, @Param("limit") int limit);

    long count(@Param("parameters") String parameters, @Param("condition") String condition, @Param("isDistinct") boolean isDistinct);

    Rooms findModel(@Param("roomlocation") String roomlocation, @Param("parameters") String parameters);

    Map<String, Object> findMap(@Param("roomlocation") String roomlocation, @Param("parameters") String parameters);
}
