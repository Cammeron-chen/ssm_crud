package com.crud.test;

import com.crud.mapper.EmployeeMapper;
import com.crud.model.Employee;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.apache.taglibs.standard.lang.jstl.EmptyOperator;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import javax.annotation.Resource;
import java.util.List;


/**
 * 使用spring的测试模块
 * @Author:PiQianDong
 * @Date:Created in 2019-01 29 11:46
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMvc.xml"})
public class MVCTest {
    // 传入springmvc的ioc
    @Autowired
    WebApplicationContext context;
    @Autowired
            EmployeeMapper employeeMapper;
    // 虚拟mvc请求，获取到处理结果

    MockMvc mockMvc;
    @Before
    public void initMokcMvc(){
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPage() throws Exception {

        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emp").param("pn", "1")).andReturn();
        // 请求成功后，请求域中会有pageInfo
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");
        System.out.println("当前页："+pageInfo.getPageNum());
        System.out.println("总页数："+pageInfo.getPages());
        System.out.println("总记录数："+pageInfo.getTotal());
        System.out.println("在页面显示的页码：");
        for (int i : pageInfo.getNavigatepageNums()){
            System.out.print(" "+i);
        }
        // 获取员工数据
        List<Employee> list = pageInfo.getList();
        for (Employee emp: list) {
            System.out.println("ID" + emp.getEmpId() + "==>gender:"+emp.getEmpGender()+emp.getDepartment().getDeptName());
        }
    }
    @Test
    public void test3(){
       /* ApplicationContext context=new ClassPathXmlApplicationContext("applicationContext.xml");
         EmployeeMapper employeeMapper =context.getBean(EmployeeMapper.class);*/
        PageHelper.startPage(1,2);

           PageInfo<Employee> employees=new PageInfo<>(employeeMapper.selectByExampleWithDept(null));
           employees.getList().forEach(System.out::println);
    }

}
