package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.RoomDao;
import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Rooms;
import cn.edu.cuit.tsmgr.service.BaseServiceInter;
import cn.edu.cuit.tsmgr.util.MysqlTool;
import cn.edu.cuit.tsmgr.util.StringTool;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

@Service
public class RoomService implements BaseServiceInter {

    private RoomDao dao;

    public RoomService(){
        dao = new RoomDao();
    }

    public String getRoomList(Page page) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM rooms ");
        //参数
        List<Object> param = new LinkedList<>();
        //添加排序
        sb.append("ORDER BY roomlocation DESC ");
        //分页
        if(page != null){
            param.add(page.getStart());
            param.add(page.getSize());
            sb.append("limit ?,?");
        }
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        //获取数据
        List<Rooms> list = dao.getRoomList(sql, param);
        //获取总记录数
        long total = getCount();
        //定义Map
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        //total键 存放总记录数，必须的
        jsonMap.put("total", total);
        //rows键 存放每页记录 list
        jsonMap.put("rows", list);
        //格式化Map,以json格式返回数据
        //返回
        return JSONObject.fromObject(jsonMap).toString();
    }

    private long getCount() {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT COUNT(*) FROM rooms ");
        //参数
        List<Object> param = new LinkedList<>();
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        long count = dao.count(sql, param).intValue();
        return count;
    }

    public void editRoom(Rooms room, String eroomlocation) {
        //修改表名
        dao.update("UPDATE rooms SET roomlocation=?,roomusage=?,roomtype=? WHERE roomlocation=?",
                new Object[]{
                        room.getRoomlocation(),room.getRoomusage(),room.getRoomtype(),eroomlocation
                });
    }

    public void deleteRoom(String[] roomlocations) throws SQLException {
        String mark = StringTool.getMark(roomlocations.length);
        Connection conn = MysqlTool.getConnection();
        //开启事务
        MysqlTool.startTransaction();
        try {
            //删除教室
            dao.deleteTransaction(conn, "DELETE FROM rooms WHERE roomlocation IN("+mark+")", roomlocations);
            //提交事务
            MysqlTool.commit();
        } catch (Exception e) {
            //回滚事务
            MysqlTool.rollback();
            e.printStackTrace();
            throw e;
        } finally {
            MysqlTool.closeConnection();
        }
    }

    public void addRoom(Rooms room) {
        //添加记录
        dao.insert("INSERT INTO rooms(roomlocation,roomusage,roomtype) value(?,?,?)",
                new Object[]{
                        room.getRoomlocation(),room.getRoomusage(),room.getRoomtype()
                });
    }
}
