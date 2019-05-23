package cn.edu.cuit.tsmgr.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;


public class Tasks implements Serializable {
        
        private static final long serialVersionUID = 1L;
        
        private Integer id;
        
        private String taskexecuter;
        
        private String teachername;
        
        private String coursename;
        
        private String roomlocation;
        
        private String lessontype;
        
        private Date time;

        private String etime;
        
        private String lessonno;
        /**备注*/
        private String comment;
        /**0,1实验课*/
        private Integer classtype;
        
        private Integer finished;
        
        private Integer ntid;
        
        private Integer ltid;
        
        public Integer getId() {
            return this.id;
        }
        
        public void setId(Integer id) {
            this.id = id;
        }
        
        public String getTaskexecuter() {
            return this.taskexecuter;
        }
        
        public void setTaskexecuter(String taskexecuter) {
            this.taskexecuter = taskexecuter;
        }
        
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
        
        public String getComment() {
            return this.comment;
        }
        
        public void setComment(String comment) {
            this.comment = comment;
        }
        
        public Integer getClasstype() {
            return this.classtype;
        }
        
        public void setClasstype(Integer classtype) {
            this.classtype = classtype;
        }
        
        public Integer getFinished() {
            return this.finished;
        }
        
        public void setFinished(Integer finished) {
            this.finished = finished;
        }
        
        public Integer getNtid() {
            return this.ntid;
        }
        
        public void setNtid(Integer ntid) {
            this.ntid = ntid;
        }
        
        public Integer getLtid() {
            return this.ltid;
        }
        
        public void setLtid(Integer ltid) {
            this.ltid = ltid;
        }
    
}