/**
 * Created by xubojoy on 16/4/15.
 */
    angular.module('app',[])
    .controller('FirstControl',function($scope){
        //$scope.msg = "hello angular";
        $scope.user = {username:'', pwd:''};
        $scope.login = function(){
            console.log($scope.user);
        }
    })

    //.controller('NextControl',function($scope){
    //    $scope.msg = "hello 极客学院";
    //})