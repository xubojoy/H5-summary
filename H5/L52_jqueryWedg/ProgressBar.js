/**
 * Created by xubojoy on 16/4/14.
 */

var pb;
var max = 100;
var current = 0;

$(document).ready(function(){
    //$("#pb").progressbar({
    //    value:10
    //});
    pb = $("#pb");
    pb.progressbar({max:100})
    setInterval(changepb,100);
});

function changepb(){
    current ++;
    if (current >= 100){
        return;
    }
    pb.progressbar("option","value",current);
}

