
layui.use(['table','layer','form','jquery','element'],function () {
    var table = layui.table;
    var layer=layui.layer;
    var form=layui.form;
    var $=layui.$;
    var element=layui.element;
    menu();
    function menu(){
        $.ajax({
            url:'menu/queryModule',
            type:'post',
            success:function (data) {
                console.log(data);
                var menu="<li class='layui-nav-item'>";
                $.each(data,function (index,item) {
                    menu+="<a id="+item.id+" href='javascript:;'>"+item.text+"</a>"
                    if(item.children!==undefined && item.children.length>0){
                        $.each(item.children,function (index,children) {
                            console.log(children.text);
                            menu+="<dl class='layui-nav-child'>"
                            menu+="<dd><a id="+children.id+" href='javascript:;' data-url="+children.url+"><cite>"+children.text+"</cite></a></dd>"
                            menu+="</dl>"
                        })
                    }

                })
                menu+="</li>"
                console.log(menu);
                $("#navBar").html(menu);
                element.render('navBar','left-menu');
                /*var menu="<li class=\"layui-nav-item\">\n" +
                    " <a href=\"javascript:;\">产品管理</a>\n" +
                    " <dl class=\"layui-nav-child\">\n" +
                    "<dd><a href=\"javascript:;\" data-url=\"/home/app\"><cite>选项1</cite></a></dd>\n" +
                    "<dd><a href=\"\">跳转</a></dd>\n" +
                    "</dl>\n" +
                    "</li>"*/
            }
        })
    }
})
