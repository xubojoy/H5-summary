/**
 * Created by Administrator on 2016/7/13.
 * author yaoqianfeng
 */
//��ȡ����������
//�����
function randomNum(Min,Max) {
    var Range = Max - Min;
    var Rand = Math.random();
    return(Min + Math.round(Rand * Range));
}

//ת���ɶ�ά��������
function coordinateMap(data,scale){
    var coordinate=[];
    if(data){
        for(var i=0;i<data.length;i++){
            coordinate.push([i*scale.w,data[i]*scale.h]);
        }
        return coordinate;
    }else{
        return [];
    }
}