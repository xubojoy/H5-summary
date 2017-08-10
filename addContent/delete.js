/**
 * Created by xubojoy on 16/3/29.
 */
//remove empty
$(document).ready(function(){
    $("#btn").click(function(){
        //$("#div").remove();//删除div 包括所有内容
        $("#div").empty();//只删除div中的元素
    });
});