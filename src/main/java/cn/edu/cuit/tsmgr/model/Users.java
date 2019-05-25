package cn.edu.cuit.tsmgr.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;


public class Users implements Serializable {
        
        private static final long serialVersionUID = 1L;
		/**
         * 督导组用户
         */
        public static final int USER_TSMEMBER = 1;
        /**
         * 教师用户
         */
        public static final int USER_TEACHER = 2;
        /**
         * 管理员
         */
        public static final int USER_ADMIN = 3;

        public static final String PLEASE_SET_NAME = "*请设置姓名*";

        /**登录名*/
        private String username;
        
        private String sgmname;
        
        private String teachername;

        private String name;
        
        private String password;
        
        private Date registedate;

        private String etime;
        /**3，管理员；1，督导员；2，老师*/
        private Integer type;
        
        public String getUsername() {
            return this.username;
        }
        
        public void setUsername(String username) {
            this.username = username;
        }
        
        public String getSgmname() {
            return this.sgmname;
        }
        
        public void setSgmname(String sgmname) {
            this.sgmname = sgmname;
        }
        
        public String getTeachername() {
            return this.teachername;
        }
        
        public void setTeachername(String teachername) {
            this.teachername = teachername;
        }
        
        public String getPassword() {
            return this.password;
        }
        
        public void setPassword(String password) {
            this.password = password;
        }
        
        public Date getRegistedate() {
            return this.registedate;
        }

        public String getName() {
            return this.name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public void setRegistedate(Date registedate) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            this.etime = sdf.format(registedate);
            this.registedate = registedate;
        }

        public String getEtime() {
            return etime;
        }

        public void setEtime(String etime) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                this.registedate = sdf.parse(etime);
            } catch (ParseException e) {
                e.printStackTrace();
            }
            this.etime = etime;
        }
        
        public Integer getType() {
            return this.type;
        }
        
        public void setType(Integer type) {
            this.type = type;
        }
    
}