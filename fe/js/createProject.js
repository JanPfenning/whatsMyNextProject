function changeTool(inputElement){
    value = inputElement.value;
    /*wenn das element leer ist lösch es*/
    if(value==="") {
        /*wenn ein weiteres element existiert und dieses nicht leer ist (das letzte ist)
        *  lade dessen daten in das aktuelle element und wiederhole für das nächste element*/
        currentElement = inputElement;
        while(currentElement.nextElementSibling.value!==""){
            currentElement.value = currentElement.nextElementSibling.value;
            currentElement = currentElement.nextElementSibling;
        }
        currentElement.parentNode.removeChild(currentElement);
    }
    /*If the next element is not null it was only a change and no new entry*/
    else{
        /*If it is null we need to add new row*/
        if(inputElement.nextElementSibling  === null){
            newInput = document.createElement("INPUT");
            newInput.setAttribute("type",inputElement.getAttribute("type"));
            newInput.setAttribute("onchange",inputElement.getAttribute("onchange"));
            newInput.setAttribute("name",inputElement.getAttribute("name"));
            newInput.setAttribute("placeholder",inputElement.getAttribute("placeholder"));
            //newInput.setAttribute("id",parseInt(inputElement.getAttribute("id"))+1);
            //newInput.setAttribute("class",inputElement.getAttribute("class").replace("noRemove",""));
            inputElement.parentNode.appendChild(newInput)
        }
    }
}
function changeMat(inputElement){
    row = inputElement.parentNode.parentNode;
    container = row.parentNode;
    value = inputElement.value;
    if(value==="") {
        /*TODO Ersetzen der ganzen Zeile mit der folgezeile (Für jede zeile außer Letzte)*/
        /*TODO Löschen der letzten Zeile*/
    }
    else{
        /*TODO erweiterung um eine ganze Zeile wenn die nächste Zeile null ist*/
    }
}