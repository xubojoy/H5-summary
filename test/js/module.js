/**
 * Created by Administrator on 2016/7/13.
 * author yaoqianfeng
 */
var module = {
    line: {
        //����
        /**
         *
         * @param coordinate
         * @param lineObj
         */
        drawLine: function (coordinate, lineObj) {
            var count = 0;
            context.beginPath();
            lineTimer = setInterval(function () {
                if (count < coordinate.length) {
                    if (count == 0) {
                        context.moveTo(0, 0);//�������
                        context.lineTo(coordinate[count][0], coordinate[count][1]);//����
                    } else {
                        context.moveTo(coordinate[count - 1][0], coordinate[count - 1][1]);
                        context.lineTo(coordinate[count][0], coordinate[count][1]);//����
                    }
                    count++;
                } else {
                    clearInterval(lineTimer);
                }
                context.lineWidth = lineObj.lineWidth;
                context.strokeStyle = lineObj.color;
                context.closePath();
                context.stroke();
            }, 1 * 1000);
        },

        //��Բ
        /**
         *
         * @param coordinate
         * @param r
         * @param circleObj
         */
        drawCircle: function (coordinate, r, circleObj) {
            var x, y;
            var count = 0;
            circleTimer = setInterval(function () {
                if (count < coordinate.length) {
                    x = coordinate[count][0];
                    y = coordinate[count][1];
                    context.beginPath();
                    context.arc(x, y, r, 0, 2 * Math.PI);
                    context.closePath();
                    context.fillStyle = circleObj.fillColor;
                    context.fill();
                    //Բ��
                    context.lineWidth = circleObj.borderWidth;
                    context.strokeStyle = circleObj.borderColor;
                    context.stroke();
                    count++;
                } else {
                    clearInterval(circleTimer);
                }
            }, 1 * 1000);
        },

        drawText: function (coordinate) {

        }
    }
};