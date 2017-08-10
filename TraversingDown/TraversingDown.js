/**
 * Created by xubojoy on 16/3/30.
 */
$(document).ready(function(){
    //$("#div1").children().css({border:"3px solid #FF0000"});  //children 是可选参数
    //$("#div1").find("p").css({border:"3px solid #FF0000"}); //find后跟必选参数

    $("p").parent().css({border:"3px solid #FF0000"});//向上遍历一层
    $("p").parents().css({border:"3px solid #FF0000"});//向上遍历所有元素
    $("p").parentsUntil("#div1").css({border:"3px solid #FF0000"});//向上遍历p---div1之间元素(区间遍历)

});