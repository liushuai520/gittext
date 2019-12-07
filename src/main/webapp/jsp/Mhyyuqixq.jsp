<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>逾期详情</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">

</head>
<body>
<!--隐藏id-->
<input type="hidden" id="id"  name="id" value="<%=request.getParameter("id") %>">

<h1>逾期详情</h1><br>
<br>

<div class="layui-row" id="EditUser" style="display:none;">
    <div style="text-align: center">
        <label>平台管理费：11.95</label><br>
        <label>贷后管理费：22.5</label><br>
        <label>信息查询费：11.05</label><br>
        <label>分期手续费：15</label>
    </div>
</div>

<div>
    <h2>客户名称：<%=request.getParameter("realName") %> &nbsp;&nbsp;
        身份证号：<%=request.getParameter("idNumber") %> &nbsp;&nbsp;
    </h2>
</div>

<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="fw">60.5</a>
</script>
<script type="text/html" id="zhuiqifei">
    <a class="layui-btn layui-btn-checked layui-btn-xs" lay-event="zf">36</a>
</script>
<script type="text/html" id="zhinajin">
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="zj">28.35</a>
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
        query();
        $('#sousuo').click(function () {
            query();
        })
        function tableInit() {
            table.render({
                id: 'test',
                elem: '#test',
                loading: false,
                page: false,
                height: 580
                , cols: [[
                     {field: 'days',align:'center', width: 100, title: '逾期天数'}
                    , {field: 'shouldMoney', align:'center',width: 140, title: '应还金额（元）'}
                    , {field: 'capital', align:'center',width: 140, title: '本金（元）'} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                    , {field: 'interest',align:'center', width: 140, title: '利息（元）'}
                    ,{field: '', width: 140,align:'center', title: '服务费（元）',toolbar: "#barDemo"}
                    , {field: '', width: 140, align:'center',title: '追期费（元）',toolbar: "#zhuiqifei"}
                    ,{field: '', width: 140,align:'center', title: '滞纳金（元）',toolbar: "#zhinajin"}
                    , {field: 'status', width: 70,align:'center', title: '状态'}
                    , {field: 'refundabortTime',align:'center', width: 140, title: '还款日期'}
                    , {field: 'actualTime', align:'center',width: 140, title: '扣款时间'}
                ]],
            });
        }

        function query() {
            table.reload('test', {
                url: '${pageContext.request.contextPath}/fanfa/Yqixq',
                method: 'POST',
                loading: true,
                page: true,
                //查询条件
                where: {
                    id: $("#id").val()
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
                if(obj.event==='fw') {
                    form.render('select', 'selFilter')
                    layer.open({
                        type: 1,
                        title: "服务费",
                        area: ['200px', '200px'],
                        content: $("#EditUser")
                    })
                }else if(obj.event==='zf'){

                }
            })

        }

    })
</script>
</html>
