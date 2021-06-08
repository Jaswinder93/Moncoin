var content = document.querySelector('#hamburger-content');
var sidebarBody = document.querySelector('#hamburger-sidebar-body');
var button = document.querySelector('#hamburger-button');
var overlay = document.querySelector('#hamburger-overlay');
var activatedClass = 'hamburger-activated';
var croix= document.querySelector('#hamburger-croix');

sidebarBody.innerHTML = content.innerHTML;

button.addEventListener('click', function(e) {
	e.preventDefault();

	this.parentNode.classList.add(activatedClass);
	button.style.display='none';
	croix.style.display='block';
});

croix.addEventListener('click', function(e) {
	e.preventDefault();
	this.parentNode.classList.remove(activatedClass);
	button.style.display='block';
	croix.style.display='none';
});


var width;
window.onresize = window.onload = function() {
    width = this.innerWidth;
    if(width>1024){
		button.style.display='none';
		croix.style.display='none';
	} else button.style.display='block';
}