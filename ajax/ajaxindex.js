/**
 * Created by xubojoy on 16/3/30.
 */
$(document).ready(function(){
    $("#btn").on("click",function(){
        //$.get("server.php",{name:$("#namevalue").val()},function(data){
        //    $("#result").text(data);
        //})
        $("#result").text("数据加载中,请稍后......");
        $.post("server.php",{name:$("#namevalue").val()},function(data){
            $("#result").text(data);
        }.error(function(){
            $("#result").text("通讯有问题");
        }));
    });
});