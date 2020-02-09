package com.crud.service;

import com.crud.mapper.DepartmentMapper;
import com.crud.model.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
   DepartmentMapper departmentMapper;

    public List<Department> getDept(){
        //返回使所有员工
        List<Department> list=departmentMapper.selectByExample(null);
        return list ;
    }
}
