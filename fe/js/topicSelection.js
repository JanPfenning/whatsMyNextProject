function placeCircles(){
    let circles = document.getElementsByClassName("topicCircle");
    let texts = document.getElementsByClassName("circleText");

    let n = circles.length;
    let baseAlpha = (180/(n));

    let baseX = 50;
    let baseY = 100;

    let radius = 250;
    let angle = baseAlpha/2;
    let circleSize = calcCircleSize(getDeltaX(angle+baseAlpha,radius), getDeltaX(angle+2*baseAlpha,radius),
                    getDeltaY(angle+baseAlpha,radius),getDeltaY(angle+2*baseAlpha,radius));
    radius = 75; //25% of the div width
    for (let i = 0; i < n; i++) {
        let circle = circles[i];

        let deltaX = getDeltaX(angle,radius);
        let xcood = baseX+deltaX;
        let deltaY = getDeltaY(angle,radius);
        let ycood = baseY-deltaY;
        circle.setAttribute("r", circleSize);
        circle.setAttribute("cx", ((baseX+xcood)/2)+"%");
        circle.setAttribute("cy", ycood+"%");

        let text = texts[i];
        text.setAttribute("x", (baseX+xcood)/2+"%");
        text.setAttribute("y", ycood+"%");
        text.setAttribute("font-size", circleSize/4);
        angle+=baseAlpha;
    }
}

function calcCircleSize(x1,x2,y1,y2){
    let deltaX = Math.abs(x1-x2);
    let deltaY = Math.abs(y1-y2);
    let puffer = 0;
    let dist = 1.3*((Math.sqrt(Math.pow(deltaX,2)+Math.pow(deltaY,2)))-puffer)/2;
    return (dist<120 ? dist : 120);
}

function init(){
    placeCircles();
}

function xslOnClick(id){
    document.getElementById('form_'+id).submit();
}
