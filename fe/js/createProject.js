function changeList(inputElement,type){
    value = inputElement.value;
    row = inputElement.parentNode;
    if(type==="mat"){
        row = inputElement.parentNode.parentNode;
    }
    container = row.parentNode;
    if(value==="") {
        if(row.nextElementSibling!==null){
            container.removeChild(row);
        }
    }
    else{
        if(row.nextElementSibling === null){
            newRow = row.cloneNode(true);
            if(type === "mat"){
                newRow.childNodes.forEach(getRow);
            }else{
                newRow.childNodes.forEach(emptyValues);
            }
            container.appendChild(newRow);
        }
    }
}

function getRow(value){
    if(value.tagName === "SPAN"){
        value.childNodes.forEach(emptyValues)
    }
}
function emptyValues(value){
    if(value.tagName==="INPUT"){
        value.value = "";
    }
}