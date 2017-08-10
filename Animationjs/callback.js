/**
 * Created by xubojoy on 16/3/30.
 */
$(document).ready(function(){
   $("button").click(function(){
      //$("p").hide(1000,function(){
      //    alert("动画结束,这个方法被称为回调");
      //});
       $("p").css("color","red").slideUp(1000).slideDown(1000);
   });
});