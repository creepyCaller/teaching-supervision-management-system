package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.AddNorCommentDao;
import cn.edu.cuit.tsmgr.model.Addnor;
import cn.edu.cuit.tsmgr.service.BaseServiceInter;

public class NormalClassCommentService implements BaseServiceInter {

    AddNorCommentDao dao;

    public NormalClassCommentService() {
        this.dao = new AddNorCommentDao();
    }

    public void commitComment(Addnor an) {
        //添加记录
        dao.insert("INSERT INTO normalclassevaluatetables(teachername,coursename,classname,roomlocation,compiler,time,lessonno,theme,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,generallevel,teachercondition,classatomspere,studentscondition,playphone,bookcondition,lookupcondition,sitecondition,teachingshape,generalcomment,other) value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                new Object[]{
                        an.getTeachername(),an.getCoursename(),an.getClassname(),an.getRoomlocation(),an.getTaskexecuter(),an.getTime(),an.getLessonno(),an.getTheme(),an.getT1(),an.getT2(),an.getT3(),an.getT4(),an.getT5(),an.getT6(),an.getT7(),an.getT8(),an.getT9(),an.getT10(),an.getGenerallevel(),an.getTeachercondition(),an.getClassatomspere(),an.getStudentscondition(),an.getPlayphone(),an.getBookcondition(),an.getLookupcondition(),an.getSitecondition(),an.getTeachercondition(),an.getGeneralcomment(),an.getOther()
                });
        dao.update("UPDATE tasks SET finished=1,ntid=(SELECT max(id) FROM normalclassevaluatetables) WHERE id=?",
                new Object[]{
                        an.getId()
                });
    }
}
