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
    //TODO Make radius dependent
    let circles = document.getElementsByClassName("topicCircles");
    let texts = document.getElementsByClassName("topicTexts");
    let n = circles.length;
    let baseAlpha = (180/(n));
    let baseCircle = document.getElementById("baseCircle");
    let baseCircleBounding = baseCircle.getBoundingClientRect();
    let baseX = baseCircleBounding.width/2 + baseCircleBounding.x;
    let baseY = baseCircleBounding.height + baseCircleBounding.y/2 + 50;
    console.log(baseCircle.getBoundingClientRect());
    baseCircle.setAttribute("cx", baseX);
    baseCircle.setAttribute("cy",baseY);
    let baseText = document.getElementById("baseText");
    baseText.setAttribute("x", baseX);
    baseText.setAttribute("y",baseY-(baseCircle.getAttribute("r")/3));
    let radius = 450;
    let angle = baseAlpha/2;
    for (let i = 0; i < n; i++) {
        let circle = circles[i];
        let text = texts[i];
        let deltaX = getDeltaX(angle,radius);
        let xcood = baseX+deltaX;
        let deltaY = getDeltaY(angle,radius);
        let ycood = baseY-deltaY;
        circle.setAttribute("cx", xcood);
        circle.setAttribute("cy", ycood);
        text.setAttribute("x", xcood);
        text.setAttribute("y", ycood);
        angle+=baseAlpha;
    }
}
