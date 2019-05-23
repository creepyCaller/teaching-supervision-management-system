package cn.edu.cuit.tsmgr.service;

public interface SaveNameServiceInter extends BaseServiceInter{

    /**
     * 保存教师名称到Users表和Teachers表
     * @return
     */
    int saveTeacherName(String username, String name);

    /**
     * 保存督导员名称到Users表和Teachers表
     * @return
     */

    int saveTSMemberName(String username, String name);
}
