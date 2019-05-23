package cn.edu.cuit.tsmgr.model;

import java.io.Serializable;


public class Teachers implements Serializable {
        
        private static final long serialVersionUID = 1L;
        /**用户账户id*/
        private Integer id;
        
        private String teachername;
        
        public Integer getId() {
            return this.id;
        }
        
        public void setId(Integer id) {
            this.id = id;
        }
        
        public String getTeachername() {
            return this.teachername;
        }
        
        public void setTeachername(String teachername) {
            this.teachername = teachername;
        }
    
}