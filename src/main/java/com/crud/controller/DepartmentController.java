package com.crud.controller;


import com.crud.model.Department;
import com.crud.model.Msg;
import com.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class DepartmentController {

      @Autowired
     DepartmentService departmentService;
    /**
     * 返回所有的部门信息
     */
    @RequestMapping("/dept")
    @ResponseBody
    public Msg getDept(){
        // 查出的所有部门信息
        List<Department> list = departmentService.getDept();
        return Msg.success().add("dept", list);

    }
}
