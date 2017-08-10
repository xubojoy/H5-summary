/**
 * Created by xubojoy on 16/3/24.
// */
//$(document).ready(function(){
//   //alert("文档加载完毕!")
//   // $("button").click(function(){
//   // $("button").dblclick(function(){
//    $("button").mouseleave(function(){
//        $(this).hide();
//    })
//});


//$(document).ready(function(){
//   $("button").click(function(){
//       $(".pclass").text("p呗修改了");
//   })
//});

$(document).ready(function(){
    //$("#clickMe").bind("click",clickHandler1());
    //$("#clickMe").bind("click",clickHandler1);
    $("#clickMe").unbind("click");//解除所有绑定
    $("#clickMe").unbind("click",clickHandler1);//只解除clickHandler1

    //jquery1.7之后 可使用on或off 跟bind和unbind使用一样
    $("#clickMe").on("click",clickHandler1);
    $("#clickMe").off("click",clickHandler1);
});

function clickHandler1(e){
    alert("clickHandler1");
}