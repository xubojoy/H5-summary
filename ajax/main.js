/**
 * Created by xubojoy on 16/3/30.
 */
$(document).ready(function () {
    $("body").load("box.htm", function (a, status, c) {
        console.log(status);
        if (status == "error") {
            $("body").text("判断加载失败");
        }
    })
})