package cn.edu.cuit.tsmgr.model;

import java.io.Serializable;



public class Classes implements Serializable {
        
        private static final long serialVersionUID = 1L;
        /**班级名：专业简称；（方向）；级；班别，计算机（应用）163*/
        private String classname;
        /**专业*/
        private String major;
        /**学院*/
        private String school;
        
        public String getClassname() {
            return this.classname;
        }
        
        public void setClassname(String classname) {
            this.classname = classname;
        }
        
        public String getMajor() {
            return this.major;
        }
        
        public void setMajor(String major) {
            this.major = major;
        }
        
        public String getSchool() {
            return this.school;
        }
        
        public void setSchool(String school) {
            this.school = school;
        }
    
}