package cn.edu.cuit.tsmgr.model;

import java.io.Serializable;


public class Rooms implements Serializable {
        
        private static final long serialVersionUID = 1L;
        /**教室位置：校区，H——航空港，L——龙泉，R——人南；（用途）；第i教学楼；楼层里各教室的编号*/
        private String roomlocation;
        /**教室昵称，用于对教室备注，比如，H5301为“ACM训练基地”*/
        private String roomusage;
        /**类型：教室, 实验室*/
        private String roomtype;
        
        public String getRoomlocation() {
            return this.roomlocation;
        }
        
        public void setRoomlocation(String roomlocation) {
            this.roomlocation = roomlocation;
        }
        
        public String getRoomusage() {
            return this.roomusage;
        }
        
        public void setRoomusage(String roomusage) {
            this.roomusage = roomusage;
        }
        
        public String getRoomtype() {
            return this.roomtype;
        }
        
        public void setRoomtype(String roomtype) {
            this.roomtype = roomtype;
        }
    
}