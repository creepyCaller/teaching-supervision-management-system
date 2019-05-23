package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.TSMemberDao;
import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Sgmembers;
import cn.edu.cuit.tsmgr.service.BaseServiceInter;
import cn.edu.cuit.tsmgr.util.MysqlTool;
import cn.edu.cuit.tsmgr.util.StringTool;
import net.sf.json.JSONObject;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

public class TSMemberService implements BaseServiceInter {

    private TSMemberDao dao;

    public TSMemberService(){
        dao = new TSMemberDao();
    }

    /**
     * 获取记录数
     * @return 记录数
     */
    private long getCount(){
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT COUNT(*) FROM sgmembers ");
        //参数
        List<Object> param = new LinkedList<>();
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        return (long) dao.count(sql, param).intValue();
    }

    public String getTSMemberList(Page page) {
        //sql语句
        StringBuffer sb = new StringBuffer("SELECT * FROM sgmembers ");
        //参数
        List<Object> param = new LinkedList<>();
        //添加排序
        sb.append("ORDER BY id DESC ");
        //分页
        if(page != null){
            param.add(page.getStart());
            param.add(page.getSize());
            sb.append("limit ?,?");
        }
        String sql = sb.toString().replaceFirst("AND", "WHERE");
        //获取数据
        List<Sgmembers> list = dao.getTSMemberList(sql, param);
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

    public void deleteTSMember(String[] ids) throws SQLException {
        String mark = StringTool.getMark(ids.length);
        Integer[] sid = new Integer[ids.length];
        for(int i =0 ;i < ids.length;i++){
            sid[i] = Integer.parseInt(ids[i]);
        }
        //获取连接
        Connection conn = MysqlTool.getConnection();
        //开启事务
        MysqlTool.startTransaction();
        try {
            //删除教师
            dao.deleteTransaction(conn, "DELETE FROM sgmembers WHERE id IN("+mark+")", sid);
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

    public void addTSMember(Sgmembers sgmembers) {
        //添加记录
        dao.insert("INSERT INTO sgmembers(id,sgmname) value(?,?)",
                new Object[]{
                        String.valueOf(sgmembers.getId()),sgmembers.getSgmname()
                });
    }

    public void editTSMember(Sgmembers sgmembers, String eid) {
        //修改
        dao.update("UPDATE sgmembers SET id=?,sgmname=? WHERE id=?",
                new Object[]{
                        String.valueOf(sgmembers.getId()),sgmembers.getSgmname(),eid
                });
    }

}
