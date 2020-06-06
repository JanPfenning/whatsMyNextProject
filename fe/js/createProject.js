function init(){

}
/*TODO make all those static parent references by a for loop*/
function changeList(inputElement,type){
    value = inputElement.value;
    row = inputElement.parentNode;
    if(type===2){
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
            if(type === 2){
                newRow.childNodes.forEach(getRow);
            }else if(type===1){
                newRow.childNodes.forEach(emptyValues);
            }else{
                console.error("We dont know how to handle parameter: "+type)
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
/*TODO make those static parent references by a for loop*/
function removeLine(element,type){
    if(type===4){
        e = element.parentNode.previousElementSibling.previousElementSibling.previousElementSibling.previousElementSibling.firstElementChild;
    }else if(type===2){
        e = element.parentNode.previousElementSibling.previousElementSibling.firstElementChild;
    }else{
        console.error("We dont know how to handle parameter: "+type)
    }
    e.value = '';
    e.onchange()
}
function getValue(div){
    div.childNodes.forEach(child.forEach(getValue));
    return value;
}
function changePic(slider) {
    var x = slider.value;
    if (x === '1') {
        slider.className = "gravel";
    } else if (x === '2') {
        slider.className = 'sand';
    } else if (x === '3') {
        slider.className = 'dirt';
    } else if (x === '4') {
        slider.className = 'wood';
    } else if (x === '5') {
        slider.className = 'cobblestone';
    } else if (x === '6') {
        slider.className = 'coal';
    } else if (x === '7') {
        slider.className = 'redstone';
    } else if (x === '8') {
        slider.className = 'lapis';
    } else if (x === '9') {
        slider.className = 'emerald';
    } else if (x === '10') {
        slider.className = 'diamond';
    }
}