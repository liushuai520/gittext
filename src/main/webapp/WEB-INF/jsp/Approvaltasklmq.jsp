<%--
  Created by IntelliJ IDEA.
  User: JM-MQ
  Date: 2019/11/8
  Time: 13:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css"  media="all">
    <script src="${ctx}/layui/layui.js"></script>
</head>
<body>
<div class="layui-row" id="EditUser" style="display:none;">

            <div class="layui-form-item">
                <label class="layui-form-label">选择审核员：</label>
                <div class="layui-input-block layui-form"  lay-filter="selFilter" style="width: 200px;margin-top: 30px;">
                    <select style="margin-left: 100px;" name="booktype" id="booktype" lay-verify="required" >
                        <option value=""></option>
                        <option value="武侠" >武侠</option>
                        <option value="玄幻" >玄幻</option>
                    </select>
                </div>
            </div>


            <div class="layui-form-item" style="margin-top:10px;margin-left: 200px;" id="check">
                <div class="layui-input-block">
                    <button class="layui-btn  layui-btn-submit " lay-submit="" lay-filter="formDemo" >确定</button>
                    <button type="reset" class="layui-btn layui-btn-primary">关闭</button>
                </div>
            </div>

        </form>
    </div>
</div>


<blockquote style="margin-top: 20px;">
    <!--搜索维度-->
    <div class="layui-form">
        <div class="layui-form-item">
            <label class="layui-form-label">客户姓名：</label>
            <div class="layui-input-inline">
                <input type="text" id='bookname' name="bookname" lay-verify="required" placeholder="请输入客户姓名" autocomplete="true" class="layui-input">
            </div>
            <label class="layui-form-label">手机号码：</label>
            <div class="layui-input-inline">
                <input type="text" id='tel' name="tel" lay-verify="required" placeholder="请输入手机号码" autocomplete="true" class="layui-input">
            </div>
            <label class="layui-form-label">状态：</label>
            <div class="layui-input-inline">
                <div class="layui-input-inline">
                    <select  name="modules" lay-verify="required" lay-search="">
                        <option value="1">待审核</option>
                        <option value="2">审核成功</option>
                    </select>
                </div>
            </div>

            <button class="layui-btn layui-btn-normal layui-btn-radius" data-type="reload">查询</button>
        </div>
    </div>
</blockquote>
<div style="margin-left: 1100px;">
    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal" id="zhi">指派任务</button>
    <button type="button" class="layui-btn layui-btn-sm layui-btn-normal">导出</button>
</div>
<table class="layui-hide layui-elem-quote" id="test"></table>
</div>
<script>
    layui.use(['table','layer','form','jquery'], function(){
        var table = layui.table;
        var layer=layui.layer;
        var form=layui.form;
        var $=layui.$;
        table.render({
            elem: '#test'
            ,url:'/demo/table/user/'
            ,cols: [[
                {type:'checkbox'}
                ,{field:'id', width:120, title: '编号', sort: true}
                ,{field:'username', width:120, title: '客户姓名'}
                ,{field:'sex', width:200, title: '身份证'}
                ,{field:'city', width:150, title: '手机号码'}
                ,{field:'sign', title: '借款金额', width:100}
                ,{field:'experience', width:100, title: '期数', sort: true}
                ,{field:'score', width:150, title: '申请时间', sort: true}
                ,{field:'classify', width:110, title: '状态'}
                ,{field:'wealth', width:100, title: '审核人'},
                ,{field:'wealth', width:150, title: '操作'}
            ]]
            ,page: true
        });


        $("#zhi").click(function () {
            oper();
        })
        function oper(){
            layer.open({
                type:1,
                title:'指派任务',
                area:['500px','210px'],
                content:$("#EditUser")
            })
        }

    });
</script>
</body>
</html>
