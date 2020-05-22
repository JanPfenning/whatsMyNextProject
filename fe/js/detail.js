function onInit(){
    drawRadar();
}

function readProperties(){
    let unterhaltsam = document.getElementById("unterhaltsam").textContent;
    let wissenschaftlich = document.getElementById("wissenschaftlich").textContent;
    let kosten = document.getElementById("kosten").textContent;
    let komplexitaet = document.getElementById("komplexitaet").textContent;
    let voraussetzungen = document.getElementById("voraussetzungen").textContent;
    let einstiegshuerde = document.getElementById("einstiegshuerde").textContent;
    return [parseInt(unterhaltsam),
        parseInt(wissenschaftlich),
        parseInt(kosten),
        parseInt(komplexitaet),
        parseInt(voraussetzungen),
        parseInt(einstiegshuerde)];
}

function drawRadar(){
    baseX = 150;
    baseY = 150;
    for (let i = 1; i <= 10; i++) {
        svg = document.getElementById("polygon"+i);
        points = "";
        for (let j = 0; j < 6; j++) {
            x = baseX+Math.round(getDeltaX(30+j*60,i*10));
            y = baseY+Math.round(getDeltaY(30+j*60,i*10));
            points+=(' '+x+','+y);
        }
        points = points.substr(1,points.length);
        svg.setAttribute("points",points)
    }
    values = readProperties();
    poly = document.getElementById("polygonValues");
    valuePoints = "";
    for (let i = 0; i < 6; i++) {
        x = baseX+Math.round(getDeltaX(30+i*60,values[i]*10));
        y = baseY+Math.round(getDeltaY(30+i*60,values[i]*10));
        valuePoints+=(' '+x+','+y);
        xText = baseX-30+Math.round(getDeltaX(30+i*60,14*10));
        yText = baseY+5+Math.round(getDeltaY(30+i*60,11*10));
        textElement = document.getElementById("text"+(i+1));
        textElement.setAttribute('x', xText);
        textElement.setAttribute('y', yText);
        let circle = document.createElementNS("http://www.w3.org/2000/svg",'circle');
        circle.setAttribute("class", 'valuePoint');
        circle.setAttribute("r", "2");
        circle.setAttribute('cx',x);
        circle.setAttribute('cy',y);
        document.getElementById("radarChartSVG").appendChild(circle);
    }
    valuePoints = valuePoints.substr(1,valuePoints.length);
    poly.setAttribute("points",valuePoints)
}
