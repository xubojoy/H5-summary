/**
 * Created by xubojoy on 16/3/30.
 */
$(document).ready(function () {
    $("#flipshow").click(function () {
        $("#content").slideDown(1000);
    });
    $("#fliphide").click(function () {
        $("#content").slideUp(1000);
    });
    $("#fliptoggle").click(function () {
        $("#content").slideToggle(1000);
    });
})

