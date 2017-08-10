/**
 * Created by xubojoy on 16/4/11.
 */
var timoutid;
$(document).ready(function(){
    $("#tabfirst li").each(function(index){
        var liNode = $(this);
        $(this).mouseover(function(){
            //alert("经过了");
            timoutid = setTimeout(function(){
                    $("div.content").removeClass("content");
                    $("#tabfirst li.tabin").removeClass("tabin");
                    $("div").eq(index).addClass("content");
                    liNode.addClass("tabin");
                },300);
        }).mouseout(function(){
           clearTimeout(timoutid);
        });
    });

    $("#realcontent").load("MyTab.html");
    $("#tabsecond li").each(function(index){
        $(this).click(function(){
            $("#tabsecond li.tabin").removeClass("tabin");
            $(this).addClass("tabin");
            if(index == 0){
                $("#realcontent").load("MyTab.html");
            }else if (index == 1){
                $("#realcontent").load("MyTab.html");
            }else if(index == 2){
                $("#realcontent").load("MyTab.html");
            }
        });
    });
});