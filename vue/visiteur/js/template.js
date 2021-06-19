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
    if (width > 1024) {
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



$(document).ready(function() {
    // Add smooth scrolling to all links
    $("#navHeaderFooter").on('click', function(event) {
        $([document.documentElement, document.body]).animate({
            scrollTop: $("#head").offset().top
        }, 600, 'linear');
    });
});


var eye = document.querySelector(".far.fa-eye.one");
var noeye = document.querySelector(".fas.fa-eye-slash.one");
var eyeTwo = document.querySelector(".far.fa-eye.two");
var noeyeTwo = document.querySelector(".fas.fa-eye-slash.two");

var pswd = document.getElementById("mypass");
var pswd2 = document.getElementById("mypass2");

document.body.addEventListener('click', function(evt) {
    if (evt.target.className === 'far fa-eye one') {
        eye.style.display = 'none';
        noeye.style.display = 'block';
        pswd.type = "text";
    }
    if (evt.target.className === 'fas fa-eye-slash one') {
        eye.style.display = 'block';
        noeye.style.display = 'none';
        pswd.type = "password";
    }
}, false);

document.body.addEventListener('click', function(evt) {
    if (evt.target.className === 'far fa-eye two') {
        eyeTwo.style.display = 'none';
        noeyeTwo.style.display = 'block';
        pswd2.type = "text";
    }
    if (evt.target.className === 'fas fa-eye-slash two') {
        eyeTwo.style.display = 'block';
        noeyeTwo.style.display = 'none';
        pswd2.type = "password";
    }
}, false);