function onInit(){
    list = readProperties();
    radarChart(list);
}

function radarChart(values){
    let nodes = document.getElementById("projectMatrix").childNodes;
    let labelList = [];
    for (let i = 1; i < nodes.length; i+=2){
        let label = nodes.item(i).getAttribute("id");
        label = label.charAt(0).toUpperCase()+label.substr(1,label.length);
        labelList.push(label);
    }
    let radarData = {
        labels: labelList,
        datasets: [
            {
                label: false,
                data: values,
                backgroundColor: "rgba(220,0,0,0.6)",
                borderColor: "#FF0000",
                pointLabelFontSize: 20,
                borderWidth: .01
            }
        ]
    };
    console.log(radarData);

    let radarOptions = {
        elements: {
            point:{
                radius: 0
            }
        },
        responsive: false,
        maintainAspectRatio: false,
        scale: {
            pointLabels: {
                fontSize: 13,
                color: "rgba(0,0,255,1)"
            },
            angleLines: {
                display: false,
                color: "#FFAAFF"
            },
            gridLines: {
                color: "#00FFFF",
                tickMarkLength: 20
            },
            ticks: {
                label: false,
                min: 0,
                max: 10,
                fixedStepSize: 1,
                showLabelBackdrop: false,
                fontSize: 0,
                color: "#FF0000"
            }
        },
        title: {
            display: false
        },
        legend: {
            display: false,
        }
    };

    let ctx5 = document.getElementById("radarChart").getContext("2d");

    new Chart(ctx5, { type: 'radar', data: radarData, options: radarOptions });
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
