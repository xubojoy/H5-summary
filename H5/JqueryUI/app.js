/**
 * Created by xubojoy on 16/4/11.
 */
$(document).ready(function(){
    //$("#a_btn").button();
    $("#btn").button();
    $("#select").selectable();
    $("#btn").on("click",function(){
        if ($("#right").hasClass("ui-selected")){
            alert("恭喜你答对了");
        }
    })
})