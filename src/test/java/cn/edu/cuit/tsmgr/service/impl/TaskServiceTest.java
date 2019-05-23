package cn.edu.cuit.tsmgr.service.impl;

import cn.edu.cuit.tsmgr.model.Page;
import cn.edu.cuit.tsmgr.model.Users;
import org.junit.Test;

import static org.junit.Assert.*;

public class TaskServiceTest {

    @Test
    public void getFTaskList() {
        TaskService service = new TaskService();
        Users user = new Users();
        user.setType(Users.USER_TSMEMBER);
        service.getFTaskList(new Page(10,10), user);

    }
}