/**
 * Created by xubojoy on 16/3/23.
 */
(function () {
    function People(name) {
        this.name = name;
    }
    People.prototype.say = function () {
        alert("peo-hello" + this.name);
    }
    window.People = People;
}());

(function () {
    function Student(name) {
        this.name = name;
    }
    Student.prototype = new People();
    var superSsay = Student.prototype.say;

    Student.prototype.say = function () {
        superSsay.call(this);
        alert("stu-hello" + this.name);
    }
    window.Student = Student;
}());
var s = new Student("xubojoy");
s.say();