var nom = document.getElementById("nameInfo");
var btnChange = document.getElementById("modifyInfo");
var btnSave = document.getElementById("saveInfo");
var allIds = ['nameInfo', 'prenomInfo', 'mailInfo', 'questInfo', 'repInfo', 'telInfo', 'adresseInfo'];
if (btnChange != null) {
    btnChange.addEventListener('click', function(evt) {
        this.type = "hidden";
        btnSave.type = "submit";
        allIds.forEach(function myFunction(item) {
            var ele = document.getElementById(item);
            console.log(ele);
            ele.disabled = false;
        });


    });
}