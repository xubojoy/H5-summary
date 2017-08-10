/**
 * Created by xubojoy on 16/3/28.
 */
$(document).ready(function(){
    //获取的text不带<a>标签
    //$("#btn1").click(function(){
    //    alert("text:"+$("#text").text());
    //});
    //获取的text带<a>标签
    //$("#btn1").click(function(){
    //    alert("text:"+$("#text").html());
    //});

    $("#btn1").click(function(){
        alert("text:"+$("#it").val());
    });

    $("#btn2").click(function(){
        alert("text:"+$("#aid").attr("href"));
    });

    $("#btn5").click(function(){
       $("#p5").text(function(i,ot){
           return "old:"+ot+" new:这是新的内容"+(i);
        });
    });
});