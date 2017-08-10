/**
 * Created by xubojoy on 16/3/30.
 */
var mj = $.noConflict();
mj(document).ready(function(){
   mj("#btn").on("click",function(){
      mj("div").text("new hello")
   });
});