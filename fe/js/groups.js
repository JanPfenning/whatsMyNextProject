function xslOnClick(id){
    console.log(id)
    document.getElementById('form_'+id).submit();
}
function placeCircles(){
    let circles = document.getElementsByClassName("groupCircles");
    let texts = document.getElementsByClassName("groupTexts");
    let n = circles.length;
    let baseAlpha = (180/(n));
    let baseCircle = document.getElementById("baseCircle");
    let baseCircleBounding = baseCircle.getBoundingClientRect();
    let baseX = baseCircleBounding.width/2 + baseCircleBounding.x;
    let baseY = baseCircleBounding.height + baseCircleBounding.y/2 + 50;
    baseCircle.setAttribute("cx", baseX);
    baseCircle.setAttribute("cy",baseY);
    let baseText = document.getElementById("baseText");
    baseText.setAttribute("x", baseX);
    baseText.setAttribute("y",baseY-(baseCircle.getAttribute("r")/3));
    let radius = 450;
    let angle = baseAlpha/2;
    let circleSize = calcCircleSize(getDeltaX(angle+baseAlpha,radius), getDeltaX(angle+2*baseAlpha,radius),
        getDeltaY(angle+baseAlpha,radius),getDeltaY(angle+2*baseAlpha,radius));
    for (let i = 0; i < n; i++) {
        let circle = circles[i];
        let text = texts[i];
        let deltaX = getDeltaX(angle,radius);
        let xcood = baseX+deltaX;
        let deltaY = getDeltaY(angle,radius);
        let ycood = baseY-deltaY;
        circle.setAttribute("r", circleSize);
        circle.setAttribute("cx", xcood);
        circle.setAttribute("cy", ycood);
        text.setAttribute("x", xcood);
        text.setAttribute("y", ycood+7);
        text.setAttribute("font-size", circleSize/4);
        angle+=baseAlpha;
    }
}

function calcCircleSize(x1,x2,y1,y2){
    let deltaX = Math.abs(x1-x2);
    let deltaY = Math.abs(y1-y2);
    let puffer = 10;
    let dist = ((Math.sqrt(Math.pow(deltaX,2)+Math.pow(deltaY,2)))-puffer)/2;
    return (dist<180 ? dist : 180);
}

function init(){
    placeCircles();
    calcCircleSize();
}