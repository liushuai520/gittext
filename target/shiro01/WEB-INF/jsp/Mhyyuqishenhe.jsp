<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>逾期审核</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<body>
<!--审核-->



<div class="layui-row" id="EditUser" style="display:none;">
    <div class="layui-col-md10">
        <form class="layui-form layui-from-pane" id="updateUser"   style="margin-top:20px" >
            <div class="layui-form-item">
                <label class="layui-form-label">客户名称:</label>
                <div class="layui-input-block">
                    <input type="text" name="realname" id="realName1" class="layui-input" style="width: 150px;">
                    <input type="hidden" name="id" id="id" class="layui-input" style="width: 150px;">
                    <input type="hidden" name="reId" id="reId" class="layui-input" style="width: 150px;">
                </div>
            </div>

            <div class="layui-form-item">
                <label class="layui-form-label">审核状态：</label>
                <div class="layui-input-block layui-form"  lay-filter="selFilter" style="width: 150px;">
                    <select name="auditType" id="auditType" lay-verify="xila" >
                        <option value="">--请选择--</option>
                        <option value="审核通过">审核通过</option>
                    </select>
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

<div style="margin-top: 30px;background-color: #dedede">
    <br>
<form class="layui-form" action="" method="post">

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">客户姓名:</label>
            <div class="layui-input-inline">
                <input type="tel" name="realName" id="realName" lay-verify="required|phone" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">身份证号:</label>
            <div class="layui-input-inline">
                <input type="text" name="idNumber" id="idNumber" lay-verify="email" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">手机号:</label>
            <div class="layui-input-inline">
                <input type="text" name="phoneNumber" id="phoneNumber" lay-verify="email" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">放贷时间:</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="payDate1" placeholder="yyyy-MM-dd HH:mm:ss">
            </div>
            <div class="layui-input-inline" >
                <input class="layui-input " id="payDate2" placeholder="yyyy-MM-dd HH:mm:ss">
            </div>
        </div>

        <div class="layui-inline">
            <label class="layui-form-label">状态：</label>
            <div class="layui-input-inline" style="width: 200px">
                <select name="type"  id="type" lay-verify="required">
                    <option value=""></option>
                    <option value="已还款">已还款</option>
                    <option value="未还款">未还款</option>
                    <option value="逾期">逾期</option>
                </select>
            </div>
        </div>

        <div class="layui-inline">
            <input type="button" class="layui-btn layui-btn-normal layui-btn-radius" value="搜索" id="sousuo">
        </div>

    </div>
</form>
</div>

<script type="text/html" id="barDemo">
    {{#  if(d.audit_type == '未审核'){ }}
    <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="zhipai">审核</a>
    {{# } else if(d.audit_type=='审核通过') { }}
    <a class="layui-btn layui-btn-warm layui-btn-xs layui-btn-disabled">审核通过</a>
    {{#  } else { }}
    <a class="layui-btn layui-btn-green layui-btn-xs " lay-event="zhipai">重新审核</a>
    {{#  } }}
</script>

<table class="layui-hide" id="test" lay-filter='test'></table>

</body>
<script src="${pageContext.request.contextPath}/layui/layui.all.js" charset="utf-8"></script>
<script>
    var $,table,form,layer,element,laydate;
    layui.use(['table','element','layer','form','jquery'], function() {
        table = layui.table;
        layer = layui.layer;
        form = layui.form;
        element = layui.element;
        laydate=layui.laydate;
        $ = layui.$;


        //初始化表格
        tableInit();
        element.init();
        form.render();
        query();
        $('#sousuo').click(function () {
            query();
            //清空搜索内容
            $("#realName").val(''),
                $("#idNumber").val(''),
                $("#type").val(''),
                $("#payDate1").val(''),
                $("#payDate2").val('')
        })
        function tableInit() {
            table.render({
                id: 'test',
                elem: '#test',
                loading:false,
                page:true,
                height: 480
                , cols: [[
                    {field: 'id', width: 80, title: '编号',align:'center',  sort: true}
                    ,{field: 're_id'}
                    , {field: 'realName', width: 120,align:'center', title: '客户姓名'}
                    , {field: 'idNumber', width: 170, align:'center',title: '身份证号'}
                    , {field: 'phoneNumber', width: 170,align:'center', title: '手机号码'}
                    , {field: 'totalMoney', width: 120,align:'center', title: '应还金额'}
                    , {field: 'reality', width: 120,align:'center', title: '实付金额'}
                    , {field: 'audit_type', width: 120,align:'center', title: '状态',templet:"#void"}
                    , {field: 'refundabortTime', width: 180,align:'center', title: '到期还款时间'}
                    ,{field: 'shenher', width: 120, align:'center',title: '提交申请人'}
                    , {field: 'add', title: '操作',align:'center', width: 100, toolbar: "#barDemo"}
                ]],
            });
        }

        function query() {
            table.reload('test', {
                url: '${pageContext.request.contextPath}/fanfa/yuqishen',
                method: 'POST',
                loading: true,
                page: true,
                //查询条件
                where: {
                    realname: $("#realName").val(),
                    idnumber:$("#idNumber").val(),
                    type:$("#type").val()
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


            //时间选择
            laydate.render({
                elem: '#payDate1'
            });


            laydate.render({
                elem: '#payDate2'
            });

            table.on('tool(test)',function (obj) {
                var row=obj.data;
                    if (obj.event === 'zhipai') {
                        if(row.reality==0){
                            alert("应付金额必须大于100元，否则审核不通过！")
                            $.ajax({
                                url:'${pageContext.request.contextPath}/fanfa/shiba',
                                type:'post',
                                data:{
                                    id:row.id,
                                    reId:row.reId,
                                    auditType:'审核失败'
                                },
                                success:function (msg) {
                                    if(msg.msg=="1"){
                                        layer.msg("审核不通过", {icon: 5});
                                        //刷新表格
                                        query()
                                        setTimeout(function(){
                                            layer.closeAll();//关闭所有的弹出层
                                        }, 1000);
                                    }else{
                                        layer.msg("失败", {icon: 5});
                                    }
                                }

                            })
                            query();
                        }
                        else{
                        $("#realName1").val(row.realName);
                        $("#id").val(row.id);
                        $("#reId").val(row.re_id);
                        layer.open({
                            type: 1,
                            title: "审核项",
                            area: ['400px', '300px'],
                            content: $("#EditUser")
                        })
                    }
                    }
            })

            //审核
            form.on('submit(formDemo)', function(data) {
                $.ajax({
                    url:'${pageContext.request.contextPath}/fanfa/yuqis',
                    type:'post',
                    contentType:'application/json',
                    data:JSON.stringify(data.field),
                    success:function (msg) {
                        if(msg.success){
                            layer.closeAll('loading');
                            layer.load(2);
                            layer.msg("操作成功", {icon: 6});
                            setTimeout(function(){
                                    layer.closeAll();//关闭所有的弹出层
                                    table.reload("test");
                                    //刷新表格
                                    query()
                                }
                                , 1000);
                        }else{
                            layer.msg("操作失败", {icon: 5});
                        }
                    }
                })
                return false;
            })

        }

    })
</script>
<script type="text/html"  id="void">

    {{#  if(d.audit_type == '未审核'){ }}
      <span style="color: darkmagenta">未审核</span>
    {{# } else if(d.audit_type=='审核通过') { }}
    <span style="color: blue">审核通过</span>
    {{# } else{ }}
       <span style="color: red">审核失败</span>
     {{#  } }}
</script>
</html>
