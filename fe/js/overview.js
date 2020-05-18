function toDetail(e){
    window.open("./detail.xml?");
    console.log(e);
}
function toTopicProjects(e){
    console.log(e)
}
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

function init(){
    var n = 5;
    baseAlpha = (180/(n));
    baseCircle = document.getElementById("baseCircle");
    baseX = baseCircle.getBoundingClientRect().x;
    baseY = 16*(baseCircle.getBoundingClientRect().y/30);
    radius = 250;
    angle = baseAlpha/2;
    for (let i = 1; i <= n; i++) {
        circle = document.getElementById("circle"+i);
        deltaX = getDeltaX(angle,radius);
        console.log(deltaX);
        xcood = baseX+deltaX;
        deltaY = getDeltaY(angle,radius);
        ycood = baseY-deltaY;
        circle.setAttribute("cx", xcood);
        circle.setAttribute("cy", ycood);
        console.log(angle);
        angle+=baseAlpha;
    }
}
