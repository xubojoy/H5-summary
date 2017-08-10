<?php
/**
 * Created by IntelliJ IDEA.
 * User: xubojoy
 * Date: 16/3/30
 * Time: 上午11:42
 */
//if(isset($_GET['name'])){
//    echo "hello:".$_GET['name'];
//}else{
//    echo "error";
//}

if(isset($_POST['name'])){
    echo "hello:".$_POST['name'];
}else{
    echo "error";
}