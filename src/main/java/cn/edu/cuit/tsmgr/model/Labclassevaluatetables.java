package cn.edu.cuit.tsmgr.model;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;


public class Labclassevaluatetables implements Serializable {
        
        private static final long serialVersionUID = 1L;
        
        private Integer id;
        /**授课教师*/
        private String teachername;
        /**课程名称*/
        private String coursename;
        /**上课班级*/
        private String classname;
        /**授课位置*/
        private String roomlocation;
        /**编辑者*/
        private String compiler;
        
        private Date time;

        private String etime;
        /**第几节课，1-2，7-8，这种,因为一般都是两节课连在一起*/
        private String lessonno;
        /**授课主题*/
        private String theme;
        /**备课充分，有完整的实验教案或讲义，熟悉实验内容，实验目的明确，内容充实，符合教学大纲要求；*/
        private Integer t1;
        /**分组及人数符合实验要求，指导教师讲授具有启发性，熟悉仪器设备，操作示范正确，熟练。*/
        private Integer t2;
        /**普通话熟练，口头语言表达清楚准确，富有感染力和吸引力，采用板书或其他教学手段（如多媒体、直观教学）演示和介绍实验内容效果良好。*/
        private Integer t3;
        /**实验各环节时间把握恰当，注重引导学生思考和学生实际动手能力的培养，注重探索与改进实验教学方法，重视课堂内外师生双向交流。*/
        private Integer t4;
        /**遵守教学与课堂纪律，上课通信工具关闭，不迟到早退，准时上下课；*/
        private Integer t5;
        /**为人师表，注重教态仪表和言行身教，教书的同时注重育人，引导学生积极向上，不对学生宣讲负面和具有消极影响的言论；*/
        private Integer t6;
        /**对学生要求严格，善于管理学生上课出勤和课堂纪律，对原始实验数据审查严格，对实验报告批阅认真规范*/
        private Integer t7;
        /**学生实验兴趣浓，思维活跃，注意力集中，实验秩序纪律好，通过本节实验课的教学，学生能掌握本节课的教学内容，感觉受启发，收获大。*/
        private Integer t8;
        /**总评等级*/
        private Integer generallevel;
        /**综合评语*/
        private String generalcomment;
        /**按时开门，环境整洁，实验仪器设备维护完好，台套数满足教学要求；实验室管理规范，室内醒目位置有文字式的管理制度与操作规范，*/
        private Integer labmgrlevel;

        private String slabmgrlevel;
        /**非同行检查性听课的人员可以不对“教学内容”模块第1—2项作出评价，其评价总分按第4—8项得分总和的1.49倍计算得出。*/
        private Integer iscolleage;
        
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
        
        public Integer getGenerallevel() {
            return this.generallevel;
        }
        
        public void setGenerallevel(Integer generallevel) {
            this.generallevel = generallevel;
        }
        
        public String getGeneralcomment() {
            return this.generalcomment;
        }
        
        public void setGeneralcomment(String generalcomment) {
            this.generalcomment = generalcomment;
        }
        
        public Integer getLabmgrlevel() {
            return this.labmgrlevel;
        }
        
        public void setLabmgrlevel(Integer labmgrlevel) {
            this.labmgrlevel = labmgrlevel;
            switch (labmgrlevel) {
                case 4:
                    this.slabmgrlevel = "优";
                    break;
                case 3:
                    this.slabmgrlevel = "良";
                    break;
                case 2:
                    this.slabmgrlevel = "一般";
                    break;
                case 1:
                    this.slabmgrlevel = "中下";
                    break;
                case 0:
                    this.slabmgrlevel = "差";
                    break;
            }
        }
        
        public Integer getIscolleage() {
            return this.iscolleage;
        }
        
        public void setIscolleage(Integer iscolleage) {
            this.iscolleage = iscolleage;
        }

        public String getSlabmgrlevel() {
            return slabmgrlevel;
        }

        public void setSlabmgrlevel(String slabmgrlevel) {
            this.slabmgrlevel = slabmgrlevel;
        }
}