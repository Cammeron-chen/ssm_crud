package com.crud.test;

import com.crud.mapper.DepartmentMapper;
import com.crud.mapper.EmployeeMapper;
import com.crud.model.Department;
import com.crud.model.Employee;
import com.sun.xml.internal.ws.developer.UsesJAXBContext;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/*1.导入Springtest依赖
2.@ContextConfiguration指定spring配置文件的位置
3.直接autowired要使用*/



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;

    //第一种测试
    @Test
    public void test(){
        //创建ioc容器
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
            EmployeeMapper bean=context.getBean(EmployeeMapper.class);
            System.out.println(bean);
    }
    //第二中测试
    @Test
    public void test2(){

      /* //插入几个部门
        departmentMapper.insertSelective(new Department(null,"开发部门"));
        departmentMapper.insertSelective(new Department(null,"测试部门"));*/
      //插入员工
       employeeMapper.insertSelective(new Employee(null,"陈建奇","男","1602591640@qq.com",1));


    }
    /*批量插入数据*/
    @Autowired
    SqlSession sqlSession;
    @Test
    public void test3(){
        EmployeeMapper mapper=sqlSession.getMapper(EmployeeMapper.class);
    for( int i=0;i<20;i++){
        String uid=UUID.randomUUID().toString().substring(0,5);
        mapper.insertSelective(new Employee(null,uid,"m",uid+"@qq.com",1));
    }
     System.out.println("批量完成");
    }


}

