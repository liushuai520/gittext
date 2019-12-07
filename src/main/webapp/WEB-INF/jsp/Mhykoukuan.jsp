<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>正常扣款</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">

</head>
<body>
<div >

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
                 <input type="text" class="layui-input " id="payDate2" placeholder="yyyy-MM-dd HH:mm:ss">
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
        <a class="layui-btn layui-btn-xs" lay-event="chaxq">查看详情</a>
    </script>

    <table class="layui-hide" id="test" lay-filter='test'></table>

</div>


</body>
<script src="${pageContext.request.contextPath}/layui/layui.all.js" charset="utf-8"></script>
<script>
    var $,table,form,layer,element,laydate;
    layui.use(['table','element','layer','form','jquery'], function() {
        table =layui.table;
        layer=layui.layer;
        form = layui.form;
        element=layui.element;
        laydate=layui.laydate;
        $=layui.$;

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
                loading: false,
                page: false,
                height: 480
                , cols: [[
                    {field: 'id', width: 80,align:'center', title: '编号', sort: true}
                    , {field: 'realName',align:'center', width: 140, title: '客户姓名'}
                    , {field: 'idNumber', align:'center',width: 140, title: '身份证号'}
                    , {field: 'phoneNumber',align:'center', width: 140, title: '手机号码'}
                    , {field: 'bidRequestAmount',align:'center', width: 140, title: '借款金额'} //minWidth：局部定义当前单元格的最小宽度，layui 2.2.1 新增
                    , {field: 'monthes2Return',align:'center', width: 140, title: '期数'}
                    , {field: 'totalMoney',align:'center', width: 140, title: '应还金额（元）'}
                    , {field: 'type', width: 140, align:'center',title: '状态'}
                    , {field: 'payDate', align:'center',width: 140, title: '放贷时间'}
                    , {field: 'add', align:'center',title: '操作', width: 130, toolbar: "#barDemo"}
                ]],
            });
        }

        function query() {

            table.reload('test', {
                url: '${pageContext.request.contextPath}/fanfa/KChaxun',
                method: 'POST',
                loading: true,
                page: true,
                //查询条件
                where: {
                    realname: $("#realName").val(),
                    idnumber:$("#idNumber").val(),
                    type:$("#type").val(),
                    payDate1:$("#payDate1").val(),
                    payDate2:$("#payDate2").val()


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

            //查看详情
            table.on('tool(test)',function (obj) {
                var row = obj.data;
                if(obj.event==='chaxq') {
                    location.href='${pageContext.request.contextPath}/input/Mhykoujl?realName='+row.realName+'&idNumber='+row.idNumber+'&bidRequestAmount='+row.bidRequestAmount+'&id='+row.id+'&proName='+row.pro_name;
                }
            })
        }

        })
</script>
</html>
