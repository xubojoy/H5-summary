/**
 * Created by xubojoy on 16/3/28.
 */
var ClickMeBtn;
$(document).ready(function () {
    ClickMeBtn = $("#ClickMeBtn");
    ClickMeBtn.click(function () {
        var e = jQuery.Event("MyEvent");
        ClickMeBtn.trigger(e);
    });
    ClickMeBtn.bind("MyEvent", function (event) {
        console.log(event);
    })
});