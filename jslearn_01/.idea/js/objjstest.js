/**
 * Created by xubojoy on 16/8/27.
 */
function Student(props) {
    this.name = props.name || 'Unnamed';
}

function PrimaryStudent(props) {
    // 调用Student构造函数，绑定this变量:
    Student.call(this, props);
    this.grade = props.grade || 1;
}


function F() {

}

F.prototype = Student.prototype;
PrimaryStudent.prototype = new F();
PrimaryStudent.prototype.constructor = PrimaryStudent;


PrimaryStudent.prototype.getGrade = function () {
    return this.grade;
};


// var xiaoming = new PrimaryStudent({
//     name:'小明',
//     grade:2
// });
//
//
// print(xiaoming);
