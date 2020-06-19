function onInit(){
    document.getElementById("defaultOpen").click();
    drawRadar();
}

function readProperties(){
    let unterhaltsam = document.getElementById("unterhaltsam").textContent;
    let wissenschaftlich = document.getElementById("wissenschaftlich").textContent;
    let kosten = document.getElementById("kosten").textContent;
    let komplexitaet = document.getElementById("komplexitaet").textContent;
    let voraussetzungen = document.getElementById("voraussetzungen").textContent;
    let einstiegshuerde = document.getElementById("einstiegshuerde").textContent;
    /*return [parseInt(unterhaltsam),
        parseInt(wissenschaftlich),
        parseInt(kosten),
        parseInt(komplexitaet),
        parseInt(voraussetzungen),
        parseInt(einstiegshuerde)];*/
    return JSON.parse('[{"value": '+parseInt(unterhaltsam)+',"title": "Unterhaltsam"},'
        +'{"value":'+parseInt(wissenschaftlich)+', "title": "Wissenschaftlich"},'
        +'{"value":'+parseInt(kosten)+',"title": "Kosten"},'
        +'{"value":'+parseInt(einstiegshuerde)+',"title": "Vorwissen"},'
        +'{"value":'+parseInt(komplexitaet)+',"title": "Komplexität"},'
        +'{"value":'+ parseInt(voraussetzungen)+',"title": "Werkzeug"}'
        +']');

}
function drawRadarBase(rings, baseX, baseY,root){
    for (let i = 1; i <= rings; i++) {
        ring = document.createElementNS("http://www.w3.org/2000/svg","polygon");
        ring.setAttribute("id","ring"+i);
        ring.setAttribute("class", "radarRing");
        points = "";
        for (let j = 0; j < 6; j++) {
            x = baseX+Math.round(getDeltaX(30+j*60,i*10));
            y = baseY+Math.round(getDeltaY(30+j*60,i*10));
            points+=(' '+x+','+y);
        }
        points = points.substr(1,points.length);
        ring.setAttribute("points",points);
        root.appendChild(ring);
    }
}
function markDot(x,y,root){
    let circle = document.createElementNS("http://www.w3.org/2000/svg",'circle');
    circle.setAttribute("class", 'valuePoint');
    circle.setAttribute("r", "0");
    circle.setAttribute('cx',x);
    circle.setAttribute('cy',y);
    animation = document.createElementNS("http://www.w3.org/2000/svg",'animate')
    animation.setAttribute('attributeName','r');
    animation.setAttribute('dur','0.1s');
    animation.setAttribute('fill','freeze');
    animation.setAttribute('from',0);
    animation.setAttribute('to',2);
    animation.setAttribute('begin','2s');
    circle.appendChild(animation)
    root.appendChild(circle);
}
function drawPolygon(baseX,baseY,root){
    let values = readProperties();
    let valuePolygon = document.createElementNS("http://www.w3.org/2000/svg","polygon");
    valuePolygon.setAttribute("id","valuePolygon");
    let polygonPoints = "";
    for (let i = 0; i < 6; i++) {
        /*Find the value on the Axis*/
        let x = baseX+Math.round(getDeltaX(30+i*60,values[i].value*10));
        let y = baseY+Math.round(getDeltaY(30+i*60,values[i].value*10));
        polygonPoints+=(' '+x+','+y);
        /*Generate Name of Axis*/
        let xText = baseX+Math.round(getDeltaX(30+i*60,11*10));
        let yText = baseY+Math.round(getDeltaY(30+i*60,11.5*10));
        let axisName = document.createElementNS("http://www.w3.org/2000/svg","text");
        axisName.setAttribute("id","axis"+i);
        axisName.setAttribute("class","text");
        axisName.setAttribute('x', xText);
        axisName.setAttribute('y', yText);
        axisName.textContent=values[i].title;
        root.appendChild(axisName);
        /*Mark the value of this Axis with a Dot*/
        markDot(x,y,root);
    }
    document.getElementById("axis1").setAttribute("text-anchor","middle");
    document.getElementById("axis2").setAttribute("text-anchor","end");
    document.getElementById("axis3").setAttribute("text-anchor","end");
    document.getElementById("axis4").setAttribute("text-anchor","middle");
    document.getElementById("axis5").setAttribute("text-anchor","start");
    document.getElementById("axis0").setAttribute("text-anchor","start");


    polygonPoints = polygonPoints.substr(1,polygonPoints.length);
    //valuePolygon.setAttribute("points",polygonPoints);
    animation = document.createElementNS("http://www.w3.org/2000/svg",'animate')
    animation.setAttribute('attributeName','points');
    animation.setAttribute('dur','1s');
    animation.setAttribute('fill','freeze');
    animation.setAttribute('from',baseX+','+baseY+','+baseX+','+baseY+','+baseX+','+baseY+','+baseX+','+baseY+','+baseX+','+baseY+','+baseX+','+baseY);
    animation.setAttribute('to',polygonPoints);
    animation.setAttribute('begin','1s');

    valuePolygon.appendChild(animation);


    root.appendChild(valuePolygon);
}

function drawRadar(){
    baseX = 180;
    baseY = 150;
    radarChartSVG = document.getElementById("radarChartSVG");
    drawRadarBase(10,baseX,baseY,radarChartSVG);
    drawPolygon(baseX,baseY,radarChartSVG);
}
function openInfo(infoHeading, button) {
    var i, tabcontent, tablinks;
    tabcontent = document.getElementsByClassName("tabcontent");
    for (i = 0; i < tabcontent.length; i++) {
        tabcontent[i].style.display = "none";
    }
    tablinks = document.getElementsByClassName("tablink");
    for (i = 0; i < tablinks.length; i++) {
        tablinks[i].style.backgroundColor = "";
    }
    document.getElementById(infoHeading).style.display = "block";
    onResize();
    button.style.backgroundColor = "blue";
}

function navToTopics(){
    document.getElementById("toTopics").submit();
}
function navToGroups(){
    document.getElementById("toGroups").submit();
}
function navToProjects(){
    document.getElementById("toProjects").submit();
}
function onResize(){
    info = document.querySelector('#information');
    style = getComputedStyle(info);
    availW = window.screen.availWidth;
    //console.log('available: '+availW);
    //console.log('used: '+style.width);
    if(availW>700){
        info.style.width = availW/2;
    }else{
        info.style.width = '';
    }
}
