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
    //TODO make this 5 dynamic to the topic count
    var n = 5;
    baseAlpha = (180/(n));
    baseCircle = document.getElementById("baseCircle");
    baseX = baseCircle.getBoundingClientRect().x;
    baseY = 16*(baseCircle.getBoundingClientRect().y/36);
    baseCircle.setAttribute("cx", baseX);
    baseCircle.setAttribute("cy",baseY);
    baseText = document.getElementById("baseText");
    baseText.setAttribute("x", baseX);
    baseText.setAttribute("y",baseY-(baseCircle.getAttribute("r")/3));
    radius = 250;
    angle = baseAlpha/2;
    for (let i = 1; i <= n; i++) {
        circle = document.getElementById("circle"+i);
        text = document.getElementById("text"+i);
        deltaX = getDeltaX(angle,radius);
        xcood = baseX+deltaX;
        deltaY = getDeltaY(angle,radius);
        ycood = baseY-deltaY;
        circle.setAttribute("cx", xcood);
        circle.setAttribute("cy", ycood);
        text.setAttribute("x", xcood);
        text.setAttribute("y", ycood);
        angle+=baseAlpha;
    }
}
