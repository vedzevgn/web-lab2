function startTime() {
    var today = new Date();
    var h = today.getHours();
    var m = today.getMinutes();
    var s = today.getSeconds();

    h = checkTime(h);
    m = checkTime(m);
    s = checkTime(s);

    document.getElementById('currentTime').innerHTML = h + ":" + m + ":" + s;
    t = setTimeout(function () {
        startTime()
    }, 500);
}

startTime();

var roundX = true;
var autoSend = false;

document.addEventListener("DOMContentLoaded", (event) => {
    if(document.querySelector(".invalidResult") != null){
        setTimeout(() => document.querySelector(".invalidResult").style.animation = "shake 400ms ease-in-out", 400);
    }

    roundX = ('true' === getCookie('roundX'));
    autoSend = ('true' === getCookie('autoSend'));
    document.getElementById("roundXSwitch").checked = roundX;
    document.getElementById("autoSendSwitch").checked = autoSend;

    checkTable();
});

document.getElementById("roundXSwitch").addEventListener("change", (event) => {
    roundX = document.getElementById("roundXSwitch").checked;
    setCookie('roundX', roundX);
    console.log(roundX);
});

document.getElementById("autoSendSwitch").addEventListener("change", (event) => {
    autoSend = document.getElementById("autoSendSwitch").checked;
    setCookie('autoSend', autoSend);
    console.log(autoSend);
});

function checkTable() {
    const table = document.getElementById('resultsTable');
    const rows = table.getElementsByTagName('tr');

    $('#resultsTable').addClass('updating');

    if (rows.length > 1) {
        document.getElementById("clearButton").classList.remove("inactiveButton");
        document.getElementById("emptyTableMessage").style.display = "none";
        document.getElementById("resultsTable").style.display = "block";
    } else {
        document.getElementById("clearButton").classList.add("inactiveButton");
        document.getElementById("emptyTableMessage").style.display = "block";
        document.getElementById("resultsTable").style.display = "none";
    }

    setTimeout(() => $('#resultsTable').removeClass('updating'), 400);
    
}

const areasHint = document.getElementById('areasHint');

let isTransitioning = false;

async function editHint(newText, element) {
    if (isTransitioning) {
        return;
    }

    isTransitioning = true;

    const originalText = element.innerText;

    element.style.transition = "opacity .2s";
    element.style.opacity = "0";

    await new Promise((resolve) => setTimeout(resolve, 200));
    element.innerText = newText;

    element.style.opacity = "0.8";

    await new Promise((resolve) => setTimeout(resolve, 1800));

    element.style.transition = "opacity .2s";
    element.style.opacity = "0";

    await new Promise((resolve) => setTimeout(resolve, 200));
    element.innerText = originalText;

    element.style.opacity = "0.8";
    isTransitioning = false;
}

function scrollDown(element){
    element.scrollTop = element.scrollHeight;
}

$(window).scroll(function () {
    var scroll = $(window).scrollTop();
    if (scroll > 20) {
        $('#header').addClass('wideHeader');
    } else {
        $('#header').removeClass('wideHeader');
    }
}

);

function closeModalWindow(ID, start) {
    document.getElementById(ID).classList.add('closedModalWindow');
    document.getElementById("modalWindowBack").classList.add("hiddenModalBack");
}

function showModalWindow(ID, message) {
    $('.errorMessage').html(message);
    document.getElementById(ID + "Window").classList.remove('closedModalWindow');
    document.getElementById("modalWindowBack").classList.remove("hiddenModalBack");
}

function checkTime(i) {
    if (i < 10) {
        i = "0" + i;
    }
    return i;
}

function formSubmit(){
    if(!checkInputs()){
        return false;
    } else {
        let form = document.querySelector("form");
        form.method = 'POST';
        form.submit();
        document.getElementById("clearButton").classList.remove("inactiveButton");
        return true;
    }
}

function checkInputs(){
    let xInp = document.getElementById("x");
    let yInp = document.getElementById("y");
    let rInp = document.getElementById("r");

    if (xInp == null) {
        showModalWindow("incorrectValue", "Пожалуйста, выберите значение для X.");
        return false;
    } else if (parseFloat(yInp.value) > 3 || parseFloat(yInp.value) < -3) {
        showModalWindow("incorrectValue", "Пожалуйста, введите значение для Y от -3 до 3.");
        return false;
    } else if (rInp == "") {
        showModalWindow("incorrectValue", "Пожалуйста, введите значение для R.");
        return false;
    } else if (!isValid(xInp.value) || !isValid(yInp.value) || (!isValid(rInp.value) && !isPositive(rInp.value))) {
        showModalWindow("incorrectValue", "Проверьте введённые данные.");
        return false;
    } else {
        return true;
    }
}


function isValid(value) {
    return !isNaN(parseFloat(value)) && isFinite(value) && value != null;
}

function isPositive(value) {
    return (value > 0);
}

function clearTable(url) {
    $.ajax({
        type: 'POST',
        url: url,
        data: "clear=true",
        success: (response) => {
            var table = document.getElementById("resultsTable");
            while (table.rows.length > 1) {
                table.deleteRow(1);
            }
            checkTable();
        },
        error: (error) => {
            console.log(error);
        }
});
}


function checkAddress(checkbox) {
    if (checkbox.checked == true) {
        var checkboxes = document.getElementsByClassName('checkbox');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = false;
            document.getElementById('x').value = "";
        }
        checkbox.checked = true;
        document.getElementById('x').value = checkbox.value;
    }

    if (checkbox.checked == false) {
        document.getElementById('x').value = "";
    }
}

function unblurNumber() {
    $('#rVal').removeClass('blurred');
}

function disappear(start){
    let content = document.querySelector('.contentWrapper');
    if(start) {
        content.style.transition = ".4s";
        content.style.opacity = "0";
        content.style.transform = "scale(0.9)";
    }
}

function appear(){
    let content = document.querySelector('.contentWrapper');
    content.style.transition = ".4s";
    setTimeout(() => {content.style.opacity = "1"; content.style.transform = "scale(1)"}, 100);
}

function xUpdate(value) {
    removePoint();
    document.getElementById('x').value = value;
    $('#xVal').addClass('blurred');
    setTimeout(() => $('#xVal').html(value), 100);
    setTimeout(() => $('#xVal').removeClass('blurred'), 200);
}

const yInput = document.querySelector('#y');

yInput.addEventListener('input', function () {
    removePoint();
    const value = yInput.value;

    if (!value) {
        yInput.classList.remove('valid', 'invalid');
    } else if (isNaN(+(value))) {
        yInput.classList.add('invalid');
        yInput.classList.remove('valid');
    } else if (+(value) >= -3 && +(value) <= 3) {
        yInput.classList.add('valid');
        yInput.classList.remove('invalid');
    } else {
        yInput.classList.add('invalid');
        yInput.classList.remove('valid');
    }
});


const rInput = document.querySelector('#r');
const rInputDublicate = document.querySelector('#rDublicate');

rInput.addEventListener('input', function () {
    rInputDublicate.value = rInput.value;
    removePoint();
});

rInputDublicate.addEventListener('input', function () {
    rInput.value = rInputDublicate.value;
    removePoint();
});


let rInputs = [rInput, rInputDublicate];

rInputs.forEach(r => {r.addEventListener('input', function () {
    const value = rInput.value;

    if (!value) {
        rInput.classList.remove('valid', 'invalid');
        rInputDublicate.classList.remove('valid', 'invalid');
    } else if (isNaN(+(value))) {
        rInput.classList.add('invalid');
        rInput.classList.remove('valid');
        rInputDublicate.classList.add('invalid');
        rInputDublicate.classList.remove('valid');
    } else if (+(value) >= 2 && +(value) <= 5) {
        rInput.classList.add('valid');
        rInput.classList.remove('invalid');
        rInputDublicate.classList.add('valid');
        rInputDublicate.classList.remove('invalid');
        showPoints();
        repositionPoints(rInput.value);
    } else {
        rInput.classList.add('invalid');
        rInput.classList.remove('valid');
        rInputDublicate.classList.add('invalid');
        rInputDublicate.classList.remove('valid');
    }
});
});


let pointX = 0;
let pointY = 0;

let cX = centerX;
let cY = centerY

coordinatesBox.addEventListener('click', function(event) {
    const previousDot = coordinatesBox.querySelector('.previousDot');
    if (previousDot) {
        previousDot.classList.add('blurredDot');
        setTimeout(() => coordinatesBox.removeChild(previousDot), 200);
    }

    radius = +(rInput.value);

    if(radius == 0 || rInput.classList.contains('invalid')){
        editHint("Проверьте введённое значение R", areasHint);

        rInputDublicate.parentElement.classList.add("shake");
        setTimeout(() => rInputDublicate.parentElement.classList.remove("shake"), 400);

        return;
    }


    const rect = coordinatesBox.getBoundingClientRect();
    const x = event.clientX - rect.left;
    const y = event.clientY - rect.top;

    const dot = document.createElement('div');
    dot.classList.add('dot');
    dot.classList.add('previousDot');
    dot.classList.add('blurredDot');

    const centerX = rect.width / 2;
    const centerY = rect.height / 2;
    const dotX = x;
    const dotY = y;
    dot.style.left = (dotX - 6) + 'px';
    dot.style.top = (dotY - 4) + 'px';

    const existingDot = coordinatesBox.querySelector('.dot');
    if (existingDot) {
        existingDot.classList.add('previousDot');
    }

    coordinatesBox.appendChild(dot);

    setTimeout(() => dot.classList.remove('blurredDot'), 0);

    pointX = dotX - centerX;
    pointY = -(dotY - centerY);

    let scale = 300 / 240;

    //((-(dotY - centerY) * radius) / centerY) * scale;

    let finalX = ((pointX * radius) / centerX) * scale;
    let finalY = ((pointY * radius) / centerY) * scale;

    let nearestX = nearest(finalX);
    let nearestY = checkY(finalY);
    setTimeout(() => position(dot, nearestX, nearestY, centerX, centerY, radius, scale), 50);

    const popupContent = document.createElement('div');
    popupContent.classList.add('popup-content');
    popupContent.textContent = `X: ${nearestX}; Y: ${nearestY.toFixed(3)}`;

    document.getElementById('x').value = nearestX;
    document.getElementById('xVal').innerHTML = nearestX;
    document.getElementById('y').value = nearestY.toFixed(3);

    const popup = document.createElement('div');
    popup.classList.add('popup');
    popup.classList.add('hiddenPopup');
    popup.appendChild(popupContent);
    dot.appendChild(popup);

    setTimeout(function() {
        popup.classList.remove('hiddenPopup');
    }, 200);

    setTimeout(function() {
        popup.classList.add('hiddenPopup');
    }, 2000);



    //console.log("finalX: " + finalX + " finalY: " + finalY);
    //console.log("x: " + pointX + " y: " + pointY + " rectX: " + centerX + " rectY: " + centerY);
});

function nearest(number) {
    if (number > 5){
        editHint("Значение X не может быть больше 5", areasHint)
        return 5;
    }
    if (number < -3){
        editHint("Значение X не может быть меньше -3", areasHint)
        return -3;
    }
    if(roundX) {
        return Math.round(number);
    } else {
        return number.toFixed(3);
    }
}

function checkY(number){
    if (number > 3){
        editHint("Значение Y не может быть больше 3", areasHint)
        return 3;
    }
    if (number < -3){
        editHint("Значение Y не может быть меньше -3", areasHint)
        return -3;
    }
    return number;
}

function position(point, nearestX, nearestY, centerX, centerY, r, scale){
    point.style.left = ((centerX + (centerX / r) * nearestX / scale) - 8) + 'px';
    point.style.top = ((centerY - (centerY / r) * nearestY / scale) - 4) + 'px';
    document.getElementById("interactiveSubmitButton").classList.remove("inactiveButton");
    if(autoSend){
        setTimeout(() => {disappear(checkInputs()); closeModalWindow('areasWindow');}, 600);
        setTimeout(() => formSubmit(), 1000);
    }
}

function addPoint(nearestX, nearestY, r){
    const point = document.createElement('div');
    coordinatesBox.appendChild(point);
    point.style.left = ((centerX + (centerX / r) * nearestX / scale) - 8) + 'px';
    point.style.top = ((centerY - (centerY / r) * nearestY / scale) - 4) + 'px';
}

function removePoint(){
    document.getElementById("interactiveSubmitButton").classList.add("inactiveButton");
    let point = document.querySelector('#coordinates .previousDot');
    if(point) {
        point.classList.add('blurredDot');
        setTimeout(() => point.remove(), 200);
    }
}