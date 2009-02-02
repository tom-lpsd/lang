function initClock() {
    showCurrentTime();
    window.setInterval(showCurrentTime, 1000);
}

function showCurrentTime() {
    var textbox = document.getElementById("currentTime");
    textbox.value = new Date().toLocaleTimeString();
    textbox.select();
}
