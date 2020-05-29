function getDeltaY(alpha, c){
    if(alpha===90){
        return c;
    }else{
        return (Math.sin(toDegree(alpha)))*c;
    }
}

function getDeltaX(alpha, c){
    if(alpha !== 90){
        return (Math.cos(toDegree(alpha)))*c;
    }else return 0;
}

function toDegree(angle){
    return angle * (Math.PI / 180);
}