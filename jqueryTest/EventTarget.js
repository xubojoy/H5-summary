/**
 * Created by xubojoy on 16/3/28.
 */
$(document).ready(function(){
    $("body").bind("click",bodyhandler);
    $("div").bind("click",divHandler);
});

function bodyhandler(event){
    conslelog(event);
}

function divHandler(event){
    conslelog(event);
    event.stopPropagation();
    event.stopImmediatePropagation();
}

function conslelog(event){
    console.log(event);
}