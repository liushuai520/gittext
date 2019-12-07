<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>产品管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<body>
<!--新增-->
<div class="layui-row" id="EditUser" style="display:none;">
    <div class="layui-col-md10">
        <form class="layui-form layui-from-pane" id="updateUser"   style="margin-top:20px" >
            <input type="hidden" id="proId" name="proId">
            <div class="layui-form-item">
                <label class="layui-form-label">产品名称:</label>
                <div class="layui-input-block">
                    <input type="text" name="proName" id="proName1"  lay-verify="required" class="layui-input"  style="width: 150px;">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">额度范围:</label>
                <div class="layui-input-block">
                    <input type="text" name="proMoney" id="proMoney" lay-verify="required" class="layui-input" style="width: 150px;">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">期限:</label>
                <div class="layui-input-block">
                    <input type="text" name="proDeadline" id="proDeadline" lay-verify="proDeadline" class="layui-input" style="width: 150px;">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">利息:</label>
                <div class="layui-input-block">
                    <input type="text" name="proInterest" id="proInterest" class="layui-input" style="width: 150px;">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">年龄范围:</label>
                <div class="layui-input-block">
                    <input type="text" name="proScope" id="proScope" class="layui-input" style="width: 150px;">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">所需信用分:</label>
                <div class="layui-input-block">
                    <input type="text" name="proLineofcredit" id="proLineofcredit" class="layui-input" style="width: 150px;">
                </div>
            </div>

            <div class="layui-form-item" style="margin-top:40px" id="check">
                <div class="layui-input-block">
                    <button class="layui-btn  layui-btn-submit " lay-submit="" lay-filter="formDemo" >确认提交</button>
                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>
                </div>
            </div>

        </form>
    </div>
</div>

<h1>产品管理</h1>
<div style="margin-top: 30px;background-color: #dedede">
    <br>
<form class="layui-form" action="" method="post">

    <div class="layui-form-item">

        <div class="layui-inline">
            <label class="layui-form-label">产品名称:</label>
            <div class="layui-input-inline">
                <input type="tel" name="proName" id="proName" lay-verify="required" autocomplete="off" class="layui-input">
            </div>
        </div>


        <div class="layui-inline">
            <label class="layui-form-label">查询方式：</label>
            <div class="layui-input-inline" style="width: 200px">
                <select name="fanshi"  id="fanshi" lay-verify="required">
                    <option value=""></option>
                    <option value="热度">热度</option>
                    <option value="利息">利息</option>
                    <option value="门槛">门槛</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <input type="button" class="layui-btn layui-btn-normal layui-btn-radius" value="搜索" id="sousuo">
            <input type="button" class="layui-btn layui-btn-checked layui-btn-radius" value="新增" id="xz">
        </div>

    </div>
</form>
    <br>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="bianji">编辑信息</a>
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="chaxq">查看详情</a>
</script>

<table class="layui-hide" id="test" lay-filter='test' style="text-align: center"></table>
</body>
<script src="${pageContext.request.contextPath}/layui/layui.all.js" charset="utf-8"></script>
<script>
    var $,table,form,layer,element;
    layui.use(['table','element','layer','form','jquery'], function() {
        table = layui.table;
        layer = layui.layer;
        form = layui.form;
        element = layui.element;
        $ = layui.$;


        //初始化表格
        tableInit();
        element.init();
        form.render();

        $('#sousuo').click(function () {
            query();
        })
        $('#xz').click(function () {

            layer.open({
                type:1,
                title:"新增",
                area:['300px','600px'],
                content:$("#EditUser")
            })
            $("#proName1").val('');
            $("#proMoney").val('');
            $("#proDeadline").val('');
            $("#proInterest").val('');
            $("#proScope").val('');
            $("#proLineofcredit").val('');
        })
        query();
        function tableInit() {
            table.render({
                id: 'test',
                elem: '#test',
                loading:false,
                page:true,
                height: 480
                , cols: [[
                    {field: 'proId', width: 155, title: '产品号',align:'center',  sort: true}
                    , {field: 'proName', width: 225,align:'center', title: '产品名称'}
                    , {field: 'proMoney', width: 225, align:'center',title: '额度范围'}
                    , {field: 'proInterest', width: 225,align:'center', title: '所收利息' }
                    , {field: 'menKan', width: 225,align:'center', title: '门槛要求'}
                    , {field: 'add', title: '操作',align:'center', width: 255, toolbar: "#barDemo"}
                ]],
            });
        }


        //表单验证
        form.verify({
            proDeadline:[
                /^[\S]{0,2}$/
                ,'密码必须0到2位，且不能出现空格'
            ]
        })


        function query() {
            table.reload('test', {
                url: '${pageContext.request.contextPath}/fanfa/Chanpin',
                method: 'POST',
                loading: true,
                page: true,
                //查询条件
                where: {
                    proName: $("#proName").val(),
                    fanshi:$("#fanshi").val()
                },
                request: {
                    //自定义分页请求参数名
                    pageName: 'page', //页码的参数名称，默认：page
                    limitName: 'rows' //每页数据量的参数名，默认：limit
                },
                response: {
                    //自定义分页响应结果集
                    statusName: "success", //数据状态的字段名称，默认：code
                    msgName: 'message', //状态信息的字段名称，默认：msg
                    countName: 'total', //数据总数的字段名称，默认：count
                    dataName: 'rows', //数据列表的字段名称，默认：data
                },
                done: function (res, curr, count) {

                }
            });




            table.on('tool(test)',function (obj) {
                var row=obj.data;
                if(obj.event==='bianji'){

                    $("#proId").val(row.proId);
                    $("#proName1").val(row.proName);
                    $("#proMoney").val(row.proMoney);
                    $("#proDeadline").val(row.proDeadline);
                    $("#proInterest").val(row.proInterest);
                    $("#proScope").val(row.proScope);
                    $("#proLineofcredit").val(row.proLineofcredit);
                    layer.open({
                        type:1,
                        title:"编辑",
                        area:['300px','600px'],
                        content:$("#EditUser")
                    })
                }else{
                    location.href='${pageContext.request.contextPath}/input/Mhychanpxq?proId='+row.proId+'&proMoney='+row.proMoney+'&proName='+row.proName;
                }
            })


            form.on('submit(formDemo)', function(data) {
                alert($("#proId").val())
                  if($("#proId").val()!=''){
                $.ajax({
                    url:'${pageContext.request.contextPath}/fanfa/xiugai',
                    type:'post',
                    contentType:'application/json',
                    data:JSON.stringify(data.field),
                    success:function (msg) {
                        if(msg.success){
                            layer.closeAll('loading');
                            layer.load(2);
                            layer.msg("修改成功", {icon: 6});
                            setTimeout(function(){
                                    layer.closeAll();//关闭所有的弹出层
                                    table.reload("test");
                                    //刷新表格
                                    query()
                                }
                                , 1000);
                        }else{
                            layer.msg("修改失败", {icon: 5});
                        }
                    }
                })
                return false;

                  }else{
                      $.ajax({
                          url:'${pageContext.request.contextPath}/fanfa/xinzen',
                          type:'post',
                          contentType:'application/json',
                          data:JSON.stringify(data.field),
                          success:function (msg) {
                              if(msg.success){
                                  layer.closeAll('loading');
                                  layer.load(2);
                                  layer.msg("新增成功", {icon: 6});
                                  setTimeout(function(){
                                          layer.closeAll();//关闭所有的弹出层
                                          table.reload("test");
                                          //刷新表格
                                          query()
                                      }
                                      , 1000);
                              }else{
                                  layer.msg("新增失败", {icon: 5});
                              }
                          }
                      })
                      return false;
                  }
            })


        }


    })
</script>
</html>
