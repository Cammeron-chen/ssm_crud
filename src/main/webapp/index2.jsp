<%--
  Created by IntelliJ IDEA.
  User: 陈建奇
  Date: 2020/2/2
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"  %>

<html>
<head>
    <title>员工列表</title>
    <%-- <%
         pageContext.setAttribute("APP_PATH", request.getContextPath());
     %>--%>
    <%pageContext.setAttribute("APP_PATH",request.getContextPath());%>
    <meta charset="UTF-8">
    <%--引入bootstarp页面--%>
    <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <%--引入jquery--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.3.1.min.js" ></script>
    <script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.js"></script>
</head>
<body>
<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empGender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender1_update_input" value="M" checked="checked"> 男
                                 <%--<span class="help-block"></span>--%>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">department</label>
                        <div class="col-sm-6">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empGender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender1_add_input" value="M" checked="checked"> 男
                               <%-- <span class="help-block"></span>--%>
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="empGender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">department</label>
                        <div class="col-sm-6">
                            <%--提交部门id即可--%>
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>
<%--搭建显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <H1>SSM_CURD</H1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_All_btn"> 删除</button>
        </div>
    </div>

    <%--    显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table  table-hover" id="table">
                <thead>
                <tr>
                    <th><input type="checkbox" id="check_All" name="全部选择"/></th>
                    <th>empId</th>
                    <th>empName</th>
                    <th>empGender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>
    <%-- 显示分页信息--%>
    <div class="row">
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6 col-md-offset-8" id="page_nav_area">
        </div>
    </div>
</div>

<script type="text/javascript">
    var totalPage,currentPage;
  $(function () {

      to_page(1);
  });

  // 根据参数查询分页信息
  function to_page(pn) {
      $.ajax({
          url:"${APP_PATH}/emp",
          data:"pn=" + pn,
          type:"get",
          success:function (result) {
              // console.log(result)
              // 1.解析并显示员工数据
              build_emp_table(result);
              // 2. 解析并显示分页信息
              build_page_info(result);
              build_page_nav(result);
          }
      });
  }

  //1.解析并显示员工数据
   function build_emp_table(result) {

      //清空表格
      $("#table tbody").empty();
      var emp =result.extend.pageInfo.list;
      $.each(emp,function (index,item) {

          var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
          var empIdTd = $("<td></td>").append(item.empId);
          var empNameTd = $("<td></td>").append(item.empName);
          var genderTd = $("<td></td>").append(item.empGender=="M"?"男":"女");
          var emailTd = $("<td></td>").append(item.email);
          var deptNameTd = $("<td></td>").append(item.department.deptName);




          var editBtn=$("<button></button>").addClass("btn btn-danger btn-sm edit_btn")
              .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
              .append("编辑");
          //为编辑按钮添加一个自定义的属性，来表示当前的员工id
          editBtn.attr("edit-id",item.empId);

          var delBtn=$("<button></button>").addClass("btn btn-primary btn-sm delete_btn")
              .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
              .append("删除");
           delBtn.attr("del-id",item.empId)
          var btn=$("<td></td>").append(editBtn).append(" ").append(delBtn);
          $("<tr></tr>")
              .append(checkBoxTd)
              .append(empIdTd)
              .append(empNameTd)
              .append(genderTd)
              .append(emailTd)
              .append(deptNameTd)
              .append(btn)
              .appendTo("#table tbody");
      });
   }

  //2.解析并显示分页信息
  function build_page_info(result) {
            $("#page_info_area").empty();
             $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum
                       +"页，总"+result.extend.pageInfo.pages+"页,总条记录"
                        +result.extend.pageInfo.total);
             totalPage=result.extend.pageInfo.total;
             currentPage=result.extend.pageInfo.pageNum;
  }

  //解析分页条
  function build_page_nav(result){

      $("#page_nav_area").empty()
      var ul = $("<ul></ul>").addClass("pagination");

      //构建元素
      var firstPageLi = $("<li></li>")
          .append($("<a></a>").append("首页").attr("href","#"));
      var prePageLi = $("<li></li>")
          .append($("<a></a>").append("&laquo;"));

         if(result.extend.pageInfo.hasPreviousPage==false){
             firstPageLi.addClass("disabled");
             prePageLi.addClass("disabled");
         }else {
             //为元素添加点击翻页事件
             firstPageLi.click(function () {
                 to_page(1);
             })
             prePageLi.click(function () {
                 to_page(result.extend.pageInfo.pageNum - 1);
             });

         }
         
      var nextPageLi = $("<li></li>")
          .append($("<a></a>").append("&raquo;"));
      var lastPageLi = $("<li></li>")
          .append($("<a></a>").append("末页").attr("href","#"));

      if(result.extend.pageInfo.hasNextPage == false){
          nextPageLi.addClass("disabled");
         lastPageLi.addClass("disabled");
      }else {
          nextPageLi.click(function () {
              to_page(result.extend.pageInfo.pageNum +1);
          });
          lastPageLi.click(function () {

              to_page(result.extend.pageInfo.pages);
          });
      }
      

      //添加首页和前一页的提示
      ul.append(firstPageLi).append(prePageLi);
      //页码号码
      $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
          var numLi = $("<li></li>").append($("<a></a>").append(item));
          if (result.extend.pageInfo.pageNum == item){

              numLi.addClass("active");
          }
          numLi.click(function () {
              to_page(item);
          });
          ul.append(numLi);
      });
      //添加下一页和末页的提示
      ul.append(nextPageLi).append(lastPageLi);

      var navEle = $("<nav></nav>").append(ul);
      navEle.appendTo($("#page_nav_area"));
  }

  function reset_form(ele){
      $(ele)[0].reset();
      //情况表单样式
      $(ele).find("*").removeClass("has-error has-success");
      $(ele).find(".help-block").text("");
  }
  // 点击新增按钮，弹出模态框
   $("#emp_add_modal_btn" ).click(function () {
       //表单重置
      /* $("#empAddModal form")[0].reset();*/

       reset_form("#empAddModal form");

  //发出ajax请求，查出部门信息，显示在下拉列表中
       getDept("#empAddModal select");
       //弹出模态框
       $("#empAddModal").modal({
           backdrop:"static"
       });
   });

  //查出所有的部门信息并显示在下拉列表中
  function getDept(ele) {
      $(ele).empty();
      $.ajax({
          url:"${APP_PATH}/dept",
          type:"get",
          success:function (result) {
              //console.log(result);
              //{"code":100,"message":"处理成功","extend":{"dept":[{"deptId":1,"deptName":"开发部门"},{"deptId":2,"deptName":"测试部门"}]}}
               //显示部门信息在下拉列表中
            /*  $("#dept_add_select")*/
              $.each(result.extend.dept,function () {
                  var optionEle =$("<option></option>").append(this.deptName).attr("value",this.deptId);
                   optionEle.appendTo(ele);
              });
          }
      });
  }


  //校验方法
    function validate_add_form(){
      //1、拿到校验的数据
        var empName=$("#empName_add_input").val();
        var  regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF{2,5}])/;
       if(!regName.test(empName)){
           //alert("用户名是2~5位，数字或字符是3~16");
           show_validate_msg("#empName_add_input","error","用户名是2~5位，数字或字符是6~16");
      /*     $("#empName_add_input").parent().addClass("has-error");
           $("#empName_add_input").next("span").text("用户名是2~5位，数字或字符是3~16");*/
           return false;
       }else{
          /* $("#empName_add_input").parent().addClass("has-success");
           $("#empName_add_input").next("span").text();*/
           show_validate_msg("#empName_add_input","success","");
       };
       var email =$("#email_add_input").val();
       var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
       if(!regEmail.test(email)){
          /* alert("邮箱格式不正确，请重新输入！");*/

           show_validate_msg("#email_add_input","error","邮箱格式不正确，请重新输入！");
          /* $("#email_add_input").parent().addClass("has-error");
           $("#email_add_input").next("span").text("邮箱格式不正确，请重新输入！");*/
           return false;
       }else{
          /* $("#email_add_input").parent().addClass("has-success");
           $("#email_add_input").next("span").text();*/

           show_validate_msg("#email_add_input","success","");
       }
       return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele,status,msg){
        //先清楚当前校验状态
        $(ele).parent().removeClass("has-success");
        $(ele).next("span").text("");
      if("success"==status){
          $(ele).parent().addClass("has-success");
          $(ele).next("span").text(msg);
      } else  if("error"==status){
          $(ele).parent().addClass("has-error");
          $(ele).next("span").text(msg);
      }

    }

    //用户名校验
    $("#empName_add_input").change(function() {
        //发送ajax请求校验用户名是否可用
        var empName=this.value;
        $.ajax({
            url:"${APP_PATH}/checkUser",
            data:"empName="+empName,
            type:"POST",
            success:function (result) {
                if(result.code == 100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    });
    //保存员工
  $("#emp_save_btn").click(function () {
      //1、模态框中填写的表单数据提交给服务器进行保存
      //2、先进性校验
       if(!validate_add_form()){
           return false;
      }
       //判断之前的ajax用户名校验是否成功
      if($(this).attr("ajax-va")=="error"){
          return false;
      }
      //3、发送ajax请求保存员工
     //alert($("#empAddModal form").serialize());
     $.ajax({
          url:"${APP_PATH}/emp",
          type:"POST",
          data: $("#empAddModal form").serialize(),
         success:function (result){

              if(result.code==100){
                  //alert(result.message);
                  //保存成功后 1、关闭模态框
                  $('#empAddModal').modal('hide');
                  //2显示刚才保存的数据,发送ajax请求最后一页就可以
                  to_page(totalPage);
              }else {
                 //console.log(result);
                 // 有哪个字段信息就显示哪个信息
                 if (undefined !=result.extend.errorFields.email) {
                     // 显示邮箱错误信息
                     show_validate_msg("#email_add_input","error",
                         result.extend.errorFields.email);
                 }
                 if (undefined != result.extend.errorFields.empName) {
                     show_validate_msg("#empName_add_input","error",
                         result.extend.errorFields.empName);
                 }
             }

         }
      });

  });

  //编辑按钮的单击时间
    $(document).on("click",".edit_btn",function () {
       // alert("edit");
        //1.查出部门和员工信息，并显示信息列表
        //弹出模态框
        getDept("#empUpdateModal select");

        //查询显示员工信息
        getEmp($(this).attr("edit-id"));


        //吧i的传给更新按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });

    });

    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                //console.log(result);
                var empData=result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                $("#email_update_input").val(empData.email);
                $("#empUpdateModal input[name=empGender]").val([empData.empGender]);
                $("#empUpdateModal select").val([empData.dId]);
            }
            });
    }

    //点击更新员工信息
    $("#emp_update_btn").click(function () {
        //验证邮箱是否合法
        //2、校验邮箱信息
        var email =$("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            /* alert("邮箱格式不正确，请重新输入！");*/
            show_validate_msg("#email_update_input","error","邮箱格式不正确，请重新输入！");

            return false;
        }else{
            show_validate_msg("#email_update_input","success","");
        }

        // 发送ajax请求
        $.ajax({
            url:"${APP_PATH}/emp/"+ $(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function (result) {
                //alert(result.message);
                //关闭对话框，回到当前页面
               $("#empUpdateModal").modal("hide");
               to_page(currentPage);
            }
        });

    })

    //删除按钮
    $(document).on("click",".delete_btn",function (){
        //1、弹出是否确认删除对话框
        var empName=$(this).parents("tr").find("td:eq(2)").text();
       var empId= $(this).attr("del-id");
        if(confirm("确认删除["+empName+"]吗？"));
            //确认，发送ajax请求删除即可
        $.ajax({
            url:"${APP_PATH}/emp/"+ empId,
            type:"delete",
            success:function (result) {
                alert(result.message);
                //回到本页
                to_page(currentPage);
            }
        });
    });

    //完成安选和全不选
    $("#check_All").click(function () {

        //dom原生的属性：attr获取自定义属性的值
    ($(".check_item").prop("checked",$(this).prop("checked")));
    });

    $(document).on("click",".check_item",function () {
        //判断选中的元素是否是5个
        //alert($(".check_item:checked").length)
        var flag=$(".check_item:checked").length==$(".check_item").length;
        $("#check_All").prop("checked",flag);
    });

    //批量删除
    $("#emp_del_All_btn").click(function (){
        var empNames="";
        var del_ids="";
            $.each($(".check_item:checked"),function () {
            empNames+= $(this).parents("tr").find("td:eq(2)").text()+",";
                del_ids += $(this).parents("tr").find("td:eq(1)").text()+"-";
            });
            empNames=empNames.substring(0,empNames.length-1);
            del_ids=del_ids.substring(0,del_ids.length-1);
        if (confirm("确认删除【"+empNames+"】用户吗？")){
            // 发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/" + del_ids,
                type:"delete",
                success:function (result) {
                    alert(result.message);
                    to_page(currentPage);
                }
            });
        }
    });
</script>
</body>
</html>
