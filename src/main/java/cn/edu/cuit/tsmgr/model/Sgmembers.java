package cn.edu.cuit.tsmgr.model;

import java.io.Serializable;


public class Sgmembers implements Serializable {
        
        private static final long serialVersionUID = 1L;
        /**用户账户id*/
        private Integer id;
        
        private String sgmname;
        
        public Integer getId() {
            return this.id;
        }
        
        public void setId(Integer id) {
            this.id = id;
        }
        
        public String getSgmname() {
            return this.sgmname;
        }
        
        public void setSgmname(String sgmname) {
            this.sgmname = sgmname;
        }
    
}