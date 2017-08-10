/**
 * Created by xubojoy on 16/4/8.
 */
$(document).ready(function () {
    $(".main>a").click(function () {
        //alert("点击了");
        var urlNode = $(this).next("ul");
        //if (urlNode.css("display") == "none"){
        //    urlNode.css("display","block");
        //}else {
        //    urlNode.css("display","none");
        //}
        //urlNode.toggle(500);//数字  slow  normal fast
        urlNode.slideToggle();
    });

    $(".hmain").hover(function(){
       $(this).children("ul").slideToggle();
    });
});