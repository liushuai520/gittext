<%--
  Created by IntelliJ IDEA.
  User: JM-MQ
  Date: 2019/11/6
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <%@include file="../common/head.jsp"%>
    <link rel="stylesheet" href="${ctx}/layui/css/layui.css" />
    <link rel="stylesheet" href="${ctx}/css/index.css" />
    <link rel="stylesheet" href="${ctx}/css/public.css" />
    <script type="text/javascript" src="${ctx}/layui/layui.js"></script>
    <script type="text/javascript" src="${ctx}/js/menu.js"></script>
</head>
<body class="main_body">
<div class="layui-layout layui-layout-admin">
    <!-- 顶部 -->
    <div class="layui-header header">
        <div class="layui-main mag0">
            <a href="#" class="logo">巨好贷后台管理</a>
            <!-- 显示/隐藏菜单 -->
            <a href="javascript:;" class="seraph hideMenu icon-caidan"></a>
            <!-- 顶级菜单 -->
            <ul class="layui-nav mobileTopLevelMenus" mobile>
                <li class="layui-nav-item" data-menu="contentManagement">
                    <a href="javascript:;"><i class="seraph icon-caidan"></i><cite>layuiCMS</cite></a>
                    <dl class="layui-nav-child">
                        <dd class="layui-this" data-menu="contentManagement"><a href="javascript:;"><i class="layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>内容管理</cite></a></dd>
                        <dd data-menu="memberCenter"><a href="javascript:;"><i class="seraph icon-icon10" data-icon="icon-icon10"></i><cite>用户中心</cite></a></dd>
                        <dd data-menu="systemeSttings"><a href="javascript:;"><i class="layui-icon" data-icon="&#xe620;">&#xe620;</i><cite>系统设置</cite></a></dd>
                        <dd data-menu="seraphApi"><a href="javascript:;"><i class="layui-icon" data-icon="&#xe705;">&#xe705;</i><cite>使用文档</cite></a></dd>
                    </dl>
                </li>
            </ul>
            <ul class="layui-nav topLevelMenus" pc>
                <li class="layui-nav-item layui-this" data-menu="contentManagement">
                    <a href="javascript:;"><i class="layui-icon" data-icon="&#xe63c;">&#xe63c;</i><cite>内容管理</cite></a>
                </li>
                <li class="layui-nav-item" data-menu="memberCenter" pc>
                    <a href="javascript:;"><i class="seraph icon-icon10" data-icon="icon-icon10"></i><cite>用户中心</cite></a>
                </li>
                <li class="layui-nav-item" data-menu="systemeSttings" pc>
                    <a href="javascript:;"><i class="layui-icon" data-icon="&#xe620;">&#xe620;</i><cite>系统设置</cite></a>
                </li>
                <li class="layui-nav-item" data-menu="seraphApi" pc>
                    <a href="javascript:;"><i class="layui-icon" data-icon="&#xe705;">&#xe705;</i><cite>使用文档</cite></a>
                </li>
            </ul>
            <!-- 顶部右侧菜单 -->
            <ul class="layui-nav top_menu">
                <li class="layui-nav-item" id="userInfo">
                    <a href="javascript:;"><img src="../images/fairy.jpg" class="layui-nav-img userAvatar" width="35" height="35"><cite class="adminName">仙女</cite></a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" data-url="/home/app"><i class="seraph icon-ziliao" data-icon="icon-ziliao"></i><cite>个人资料</cite></a></dd>
                        <dd><a href="javascript:;" data-url=""><i class="seraph icon-xiugai" data-icon="icon-xiugai"></i><cite>修改密码</cite></a></dd>
                        <dd><a href="javascript:;" class="showNotice"><i class="layui-icon">&#xe645;</i><cite>系统公告</cite><span class="layui-badge-dot"></span></a></dd>
                        <dd pc><a href="javascript:;" class="functionSetting"><i class="layui-icon">&#xe620;</i><cite>功能设定</cite><span class="layui-badge-dot"></span></a></dd>
                        <dd><a href="" class="signOut"><i class="seraph icon-tuichu"></i><cite>退出</cite></a></dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>
    <!-- 左侧导航 -->
    <div class="layui-side layui-bg-black">
        <div class="user-photo">
            <a class="img" title="我的头像" ><img src="../images/fairy.jpg" class="userAvatar"></a>
            <p>你好！<span class="userName">仙女</span>, 欢迎登录</p>
        </div>

        <div class="navBar layui-side-scroll">
            <ul lay-filter="left-menu" class="layui-nav layui-nav-tree" id="navBar">


            </ul>
        </div>
    </div>
    <!-- 右侧内容 -->
    <div class="layui-body layui-form">
        <div class="layui-tab mag0" lay-filter="bodyTab" id="top_tabs_box">
            <ul class="layui-tab-title top_tab" id="top_tabs">
                <li class="layui-this" lay-id=""><i class="layui-icon">&#xe68e;</i> <cite>首页</cite></li>
            </ul>
            <ul class="layui-nav closeBox">
                <li class="layui-nav-item">
                    <a href="javascript:;"><i class="layui-icon caozuo">&#xe643;</i> 页面操作</a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;" class="refresh refreshThis"><i class="layui-icon">&#x1002;</i> 刷新当前</a></dd>
                        <dd><a href="javascript:;" class="closePageOther"><i class="seraph icon-prohibit"></i> 关闭其他</a></dd>
                        <dd><a href="javascript:;" class="closePageAll"><i class="seraph icon-guanbi"></i> 关闭全部</a></dd>
                    </dl>
                </li>
            </ul>
            <div class="layui-tab-content clildFrame">
                <div class="layui-tab-item layui-show">
                    <iframe src=""></iframe>
                </div>
            </div>
        </div>
    </div>


    <!-- 移动导航 -->
    <!-- <div class="site-tree-mobile"><i class="layui-icon">&#xe602;</i></div>
    <div class="site-mobile-shade"></div> -->

    <script type="text/javascript" src="${ctx}/js/index.js"></script>
</div>
</body>
</html>
