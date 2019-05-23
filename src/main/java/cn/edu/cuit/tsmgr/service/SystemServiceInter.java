package cn.edu.cuit.tsmgr.service;

import cn.edu.cuit.tsmgr.model.Systemimformation;
import cn.edu.cuit.tsmgr.model.Users;

public interface SystemServiceInter extends BaseServiceInter {

    /**
     * 获取听课任务列表
     * @return
     */
    public String getTasksList();

    /**
     * 获取课程评价信息表
     * @return
     */
    public String getNormalClassEvaluateTablesList();

    /**
     * 获取实验课评价信息表
     * @return
     */
    public String getLabClassEvaluateTablesList();

    /**
     * 获取课表
     * @return
     */
    public String getCoursesList();

    /**
     * 获取班级表
     * @return
     */
    public String getClassesList();

    /**
     * 获取教室列表
     * @return
     */
    public String getRoomsList();

    /**
     * 登录验证
     * @param user
     * @return
     */
    public Users checkUser(Users user);

    /**
     * 修改密码
     * @param user
     */
    public int editPassword(Users user);

    /**
     * 修改系统信息
     * @param name 修改的名称
     * @param value 值
     * @return 返回修改后的系统信息对象
     */
    public Systemimformation editSystemImformation(String name, String value);

    /**
     * 新增用户
     * @param user
     */
    public int registe(Users user);

}
