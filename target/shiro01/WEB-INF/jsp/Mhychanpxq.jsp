<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>产品信息详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
</head>
<body>
<!--隐藏id-->
<input type="hidden" id="proId"  name="proId" value="<%=request.getParameter("proId") %>">

<h1>扣款记录</h1><br>
<br>

<div>
    <h2>产品名称：<%=request.getParameter("proName") %> &nbsp;&nbsp;
        借款额度范围：<%=request.getParameter("proMoney") %> &nbsp;&nbsp;
    </h2>
</div>
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
        query();
        function tableInit() {
            table.render({
                id: 'test',
                elem: '#test',
                loading: false,
                page: false,
                height: 480
                , cols: [[
                    {field: 'realName',align:'center', width: 280, title: '借款用户'}
                    , {field: 'idNumber', align:'center',width: 280, title: '身份证号'}
                    , {field: 'phoneNumber',align:'center', width: 280, title: '手机号码'}
                    ,{field: 'bidRequestAmount', align: 'center', width: 280, title: '借款金额'}
                    , {field: 'applyTime', align: 'center', width: 260, title: '借款时间'}
                ]],
            });
        }


        function query() {
            table.reload('test', {
                url: '${pageContext.request.contextPath}/fanfa/chanpxq',
                method: 'post',
                loading: true,
                page: true,
                //查询条件
                where: {
                    proId: $("#proId").val()
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

        }
    })
</script>
</html>
