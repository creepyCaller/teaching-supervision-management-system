package cn.edu.cuit.tsmgr.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;


public class Addnor implements Serializable {

    private static final long serialVersionUID = 1L;

    private String id;

    private String taskexecuter;

    private String teachername;

    private String coursename;

    private String classname;

    private String roomlocation;
    /**编辑者*/
    private String compiler;

    private Date time;

    private String etime;
    /**第几节课，1-2，7-8，这种,因为一般都是两节课连在一起*/
    private String lessonno;

    private String theme;
    /**教学内容和目标明确，符合教学大纲要求*/
    private Integer t1;
    /**教学内容娴熟，问题阐述收放自如*/
    private Integer t2;
    /**讲述条理清晰，概念准确，重点突出*/
    private Integer t3;

    private Integer t4;

    private Integer t5;
    /**有先进的教学理念、实用的教学方法，教学设计精心、课堂效果好*/
    private Integer t6;
    /**能启发引导学生积极、主动思考*/
    private Integer t7;
    /**与学生交流互动好，课堂氛围活跃*/
    private Integer t8;
    /**学生注意力集中，课堂纪律好*/
    private Integer t9;
    /**通过本节课的教学内容，学生能掌握本节课的教学内容，感觉受启发，收获大*/
    private Integer t10;
    /**总评*/
    private Integer generallevel;
    /**1，提前进教室准备；2，迟到；3，早退*/
    private Integer teachercondition;
    /**课堂氛围*/
    private Integer classatomspere;
    /**学生情况*/
    private Integer studentscondition;

    private Integer playphone;
    /**教材情况*/
    private Integer bookcondition;
    /**抬头情况*/
    private Integer lookupcondition;
    /**就坐情况*/
    private Integer sitecondition;
    /**授课形式*/
    private Integer teachingshape;
    /**非同行检查性听课的人员可以不对“教学内容”模块第1—2项作出评价，其评价总分按第4—8项得分总和的1.49倍计算得出。*/
    private Integer iscolleage;
    /**总体评价*/
    private String generalcomment;
    /**其他*/
    private String other;

    public String getTeachername() {
        return this.teachername;
    }

    public void setTeachername(String teachername) {
        this.teachername = teachername;
    }

    public String getCoursename() {
        return this.coursename;
    }

    public void setCoursename(String coursename) {
        this.coursename = coursename;
    }

    public String getClassname() {
        return this.classname;
    }

    public void setClassname(String classname) {
        this.classname = classname;
    }

    public String getRoomlocation() {
        return this.roomlocation;
    }

    public void setRoomlocation(String roomlocation) {
        this.roomlocation = roomlocation;
    }

    public String getCompiler() {
        return this.compiler;
    }

    public void setCompiler(String compiler) {
        this.compiler = compiler;
    }

    public Date getTime() {
        return this.time;
    }

    public void setTime(Date time) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        this.etime = sdf.format(time);
        this.time = time;
    }

    public String getEtime() {
        return etime;
    }

    public void setEtime(String etime) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            this.time = sdf.parse(etime);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        this.etime = etime;
    }

    public String getLessonno() {
        return this.lessonno;
    }

    public void setLessonno(String lessonno) {
        this.lessonno = lessonno;
    }

    public String getTheme() {
        return this.theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public Integer getT1() {
        return this.t1;
    }

    public void setT1(Integer t1) {
        this.t1 = t1;
    }

    public Integer getT2() {
        return this.t2;
    }

    public void setT2(Integer t2) {
        this.t2 = t2;
    }

    public Integer getT3() {
        return this.t3;
    }

    public void setT3(Integer t3) {
        this.t3 = t3;
    }

    public Integer getT4() {
        return this.t4;
    }

    public void setT4(Integer t4) {
        this.t4 = t4;
    }

    public Integer getT5() {
        return this.t5;
    }

    public void setT5(Integer t5) {
        this.t5 = t5;
    }

    public Integer getT6() {
        return this.t6;
    }

    public void setT6(Integer t6) {
        this.t6 = t6;
    }

    public Integer getT7() {
        return this.t7;
    }

    public void setT7(Integer t7) {
        this.t7 = t7;
    }

    public Integer getT8() {
        return this.t8;
    }

    public void setT8(Integer t8) {
        this.t8 = t8;
    }

    public Integer getT9() {
        return this.t9;
    }

    public void setT9(Integer t9) {
        this.t9 = t9;
    }

    public Integer getT10() {
        return this.t10;
    }

    public void setT10(Integer t10) {
        this.t10 = t10;
    }

    public Integer getGenerallevel() {
        return this.generallevel;
    }

    public void setGenerallevel(Integer generallevel) {
        this.generallevel = generallevel;
    }

    public Integer getTeachercondition() {
        return this.teachercondition;
    }

    public void setTeachercondition(Integer teachercondition) {
        this.teachercondition = teachercondition;
    }

    public Integer getClassatomspere() {
        return this.classatomspere;
    }

    public void setClassatomspere(Integer classatomspere) {
        this.classatomspere = classatomspere;
    }

    public Integer getStudentscondition() {
        return this.studentscondition;
    }

    public void setStudentscondition(Integer studentscondition) {
        this.studentscondition = studentscondition;
    }

    public Integer getBookcondition() {
        return this.bookcondition;
    }

    public void setBookcondition(Integer bookcondition) {
        this.bookcondition = bookcondition;
    }

    public Integer getLookupcondition() {
        return this.lookupcondition;
    }

    public void setLookupcondition(Integer lookupcondition) {
        this.lookupcondition = lookupcondition;
    }

    public Integer getSitecondition() {
        return this.sitecondition;
    }

    public void setSitecondition(Integer sitecondition) {
        this.sitecondition = sitecondition;
    }

    public Integer getTeachingshape() {
        return this.teachingshape;
    }

    public void setTeachingshape(Integer teachingshape) {
        this.teachingshape = teachingshape;
    }

    public Integer getIscolleage() {
        return this.iscolleage;
    }

    public void setIscolleage(Integer iscolleage) {
        this.iscolleage = iscolleage;
    }

    public String getGeneralcomment() {
        return this.generalcomment;
    }

    public void setGeneralcomment(String generalcomment) {
        this.generalcomment = generalcomment;
    }

    public String getOther() {
        return this.other;
    }

    public void setOther(String other) {
        this.other = other;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTaskexecuter() {
        return taskexecuter;
    }

    public void setTaskexecuter(String taskexecuter) {
        this.taskexecuter = taskexecuter;
    }

    public Integer getPlayphone() {
        return playphone;
    }

    public void setPlayphone(Integer playphone) {
        this.playphone = playphone;
    }
}