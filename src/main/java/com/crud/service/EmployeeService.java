package com.crud.service;

import com.crud.mapper.EmployeeMapper;
import com.crud.model.DepartmentExample;
import com.crud.model.Employee;
import com.crud.model.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /*查询所有员工*/
    public List<Employee> getAll(){

        
        return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee) {

        employeeMapper.insertSelective(employee);
    }


    /*检验用户名是否可用
    * @param empName
    * @return true:用户名可用，false:不可用
    * */
    public boolean checkUser(String empName) {
        // 构造查询条件
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        // 查询
        long count = employeeMapper.countByExample(example);
        return count == 0 ;
    }

    public Employee getEmp(int id) {

      return employeeMapper.selectByPrimaryKey(id);

    }

    //员工更新
     public void updateEmp(Employee employee){
         employeeMapper.updateByPrimaryKeySelective(employee);
     }

    public void delEemp(int id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        // 条件拼装
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
