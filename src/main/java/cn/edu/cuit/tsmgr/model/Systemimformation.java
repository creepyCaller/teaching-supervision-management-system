package cn.edu.cuit.tsmgr.model;

import java.io.Serializable;


public class Systemimformation implements Serializable {
        
        private static final long serialVersionUID = 1L;
        
        private Integer id;
        
        private String collegename;
        
        private String schoolname;
        /**0都允许1禁止登录;2禁止注册;3禁止登录和注册.*/
        private Byte forbidteacher;
        
        private Byte forbidtsmember;
        
        private String noticeteacher;
        
        private String noticetsmember;
        
        public Integer getId() {
            return this.id;
        }
        
        public void setId(Integer id) {
            this.id = id;
        }
        
        public String getCollegename() {
            return this.collegename;
        }
        
        public void setCollegename(String collegename) {
            this.collegename = collegename;
        }
        
        public String getSchoolname() {
            return this.schoolname;
        }
        
        public void setSchoolname(String schoolname) {
            this.schoolname = schoolname;
        }
        
        public Byte getForbidteacher() {
            return this.forbidteacher;
        }
        
        public void setForbidteacher(Byte forbidteacher) {
            this.forbidteacher = forbidteacher;
        }
        
        public Byte getForbidtsmember() {
            return this.forbidtsmember;
        }
        
        public void setForbidtsmember(Byte forbidtsmember) {
            this.forbidtsmember = forbidtsmember;
        }
        
        public String getNoticeteacher() {
            return this.noticeteacher;
        }
        
        public void setNoticeteacher(String noticeteacher) {
            this.noticeteacher = noticeteacher;
        }
        
        public String getNoticetsmember() {
            return this.noticetsmember;
        }
        
        public void setNoticetsmember(String noticetsmember) {
            this.noticetsmember = noticetsmember;
        }
    
}