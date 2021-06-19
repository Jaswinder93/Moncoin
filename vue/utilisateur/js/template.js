var content = document.querySelector('#hamburger-content');
var sidebarBody = document.querySelector('#hamburger-sidebar-body');
var button = document.querySelector('#hamburger-button');
var overlay = document.querySelector('#hamburger-overlay');
var activatedClass = 'hamburger-activated';
var croix = document.querySelector('#hamburger-croix');
var head = document.getElementById("head");

var body = document.getElementById("bodyPage");
sidebarBody.innerHTML = content.innerHTML;

button.addEventListener('click', function(e) {
    e.preventDefault();

    this.parentNode.classList.add(activatedClass);
    button.style.display = 'none';
    croix.style.display = 'block';
    body.style.overflow = "hidden";
});

croix.addEventListener('click', function(e) {
    e.preventDefault();
    this.parentNode.classList.remove(activatedClass);
    button.style.display = 'block';
    croix.style.display = 'none';
    body.style.overflow = "scroll";
});


var width;
window.onresize = window.onload = function() {
    width = this.innerWidth;
    if (width > 1124) {
        button.style.display = 'none';
        croix.style.display = 'none';
        if (activatedClass != null) {
            head.classList.remove(activatedClass);
        }
    } else {
        if (croix.style.display === 'none') {
            button.style.display = 'block';
        }
    }

}