package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.dao.jdbc.AddLabCommentDao;
import cn.edu.cuit.tsmgr.model.Addlab;
import cn.edu.cuit.tsmgr.service.BaseServiceInter;
import org.springframework.stereotype.Service;

@Service
public class LabClassCommentService implements BaseServiceInter {

    private AddLabCommentDao dao;

    public LabClassCommentService() {
        dao = new AddLabCommentDao();
    }

    public void commitComment(Addlab al) {
        //添加记录
        dao.insert("INSERT INTO labclassevaluatetables(teachername,coursename,classname,roomlocation,compiler,time,lessonno,theme,t1,t2,t3,t4,t5,t6,t7,t8,generallevel,generalcomment,labmgrlevel) value(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
                new Object[]{
                        al.getTeachername(),al.getCoursename(),al.getClassname(),al.getRoomlocation(),al.getTaskexecuter(),al.getTime(),al.getLessonno(),al.getTheme(),al.getT1(),al.getT2(),al.getT3(),al.getT4(),al.getT5(),al.getT6(),al.getT7(),al.getT8(),al.getGenerallevel(),al.getGeneralcomment(),al.getLabmgrlevel()
                });
        dao.update("UPDATE tasks SET finished=1,ntid=(SELECT max(id) FROM labclassevaluatetables) WHERE id=?",
                new Object[]{
                        al.getId()
                });
    }
}
