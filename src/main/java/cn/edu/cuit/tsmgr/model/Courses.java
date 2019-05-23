package cn.edu.cuit.tsmgr.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;


public class Courses implements Serializable {
        
        private static final long serialVersionUID = 1L;

        private Integer id;
        /**课程名称*/
        private String coursename;
        /**开设学院*/
        private String school;
        
        private String teachername;
        /**上课地点*/
        private String roomlocation;
        /**课程类型：实验课，公共课、基础课、专业基础课、必修课、选修课、专业选修课*/
        private String lessontype;
        
        private Date time;
        private String etime;
        /**第几节课，1-2，7-8，这种,因为一般都是两节课连在一起*/
        private String lessonno;
        
        public String getCoursename() {
            return this.coursename;
        }
        
        public void setCoursename(String coursename) {
            this.coursename = coursename;
        }
        
        public String getSchool() {
            return this.school;
        }
        
        public void setSchool(String school) {
            this.school = school;
        }
        
        public String getTeachername() {
            return this.teachername;
        }
        
        public void setTeachername(String teachername) {
            this.teachername = teachername;
        }
        
        public String getRoomlocation() {
            return this.roomlocation;
        }
        
        public void setRoomlocation(String roomlocation) {
            this.roomlocation = roomlocation;
        }
        
        public String getLessontype() {
            return this.lessontype;
        }
        
        public void setLessontype(String lessontype) {
            this.lessontype = lessontype;
        }
        
        public Date getTime() {
            return this.time;
        }

        
        public String getLessonno() {
            return this.lessonno;
        }
        
        public void setLessonno(String lessonno) {
            this.lessonno = lessonno;
        }

        public Integer getId() {
            return id;
        }

        public void setId(Integer id) {
            this.id = id;
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
}