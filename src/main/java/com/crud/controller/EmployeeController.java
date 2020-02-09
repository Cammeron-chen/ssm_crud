package com.crud.controller;

import com.crud.model.Employee;
import com.crud.model.Msg;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;



import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.List;

/*处理员工增删该查*/
@Controller
public class EmployeeController {
/*
pageInfo的用法：
//获取第1页，10条内容，默认查询总数count
PageHelper.startPage(1, 10);
    List<User> list = userMapper.selectAll();
    //用PageInfo对结果进行包装
    PageInfo page = new PageInfo(list);
    //测试PageInfo全部属性
*/
    @Autowired
    EmployeeService employeeService;
    //@RequestMapping("/emp")
    //用jsp页面请求
  /*  public String getEmp(@RequestParam(value="pn",defaultValue ="1") int pn, Model model){
        //引入PageHelper分页插件
        PageHelper.startPage(pn,5);
        //startPage后面就是一个分页查询
        List<Employee> map=employeeService.getAll();
        //用PageInfo对结果进行包装，只需要将pageInfo交给页面
        //封装了详细的分页信息。
        PageInfo page = new PageInfo(map,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }*/

    @RequestMapping("/emp")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //引入PageHelper分页插件
        PageHelper.startPage(pn,5);
        //startPage后面就是一个分页查询
        List<Employee> map=employeeService.getAll();
        //用PageInfo对结果进行包装，只需要将pageInfo交给页面
        //封装了详细的分页信息。
        PageInfo page = new PageInfo(map,5);
       for (Employee emp:map) {
           System.out.println(emp.getEmpGender());
       }
        return Msg.success().add("pageInfo",page);
    }

    /*员工保存*/
    //1、支持jsr303校验
    //2、导入Hibernate-Validator
    @RequestMapping(value="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){

        if(result.hasErrors()){
            //校验失败，返回失败,显示校验失败的错误信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError:fieldErrors){
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }


    /*检查用户名是否可用*/
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        // 先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9-_]{6,16}$)|(^[\\u2e80-\\u9fff]{2,5})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是6~16位数字和字母的组合，或者2~5位中文");
        }
        // 数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","不可用");
        }

    }

    @RequestMapping(value = "/emp/{id}",method =RequestMethod.GET)
    @ResponseBody
    //处理查询员工的方法
    public Msg getEmp(@PathVariable("id") int id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }


    /*直接使用PUT请求的问题：
    *      请求体中有数据
    *      但是Employee对象封装不上：
    *        update tbl_emp where emp_id=1014;
    *
    * 原因：
    *    Tomcat:
    * 1.将请求中的数据，封装一个map
    * 2.request.getParameter("empName")就会从这个map中取值
    * 3.SPringMVC封装POJO对象的时候。
    *       会把POJO对象中每个属性的值，request.getParameter("email")
    * AJAX发送put请求引发的问题：
    *   PUT请求，请求体中的数据，request.getParameter("")拿不到
    *   Tomcat发现PUT不会封装请求体中的数据为map，只用POST请求下封装map
    *
    *
    *
    * */


    //员工更新
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method =RequestMethod.PUT)
    public Msg saveEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //员工删除
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody()
    public Msg deleteEmp(@PathVariable("ids")String ids){
        if(ids.contains("-")){
            String[] str_ids = ids.split("-");
            List<Integer> del_ids = new ArrayList<>();
            // 组装id 的集合
            for (String str:str_ids) {
                del_ids.add(Integer.parseInt(str));
            }
            employeeService.deleteBatch(del_ids);
        }else{
            Integer id = Integer.parseInt(ids);
            employeeService.delEemp(id);
        }
        return Msg.success();
    }
}
