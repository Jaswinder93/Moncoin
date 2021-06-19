<?php

require_once('vue/View.php');
    function accueil() {
        estConnecté();
        $view = new View('utilisateur/accueil');
        $view->generate();
    }

    function estConnecté(){
        if(strcmp ($_SESSION['profil']['typeUtilisateur'],"utilisateur")!=0)
            header ("Location:" .'/');
    }
    function deconnexion(){
        var_dump($_SESSION);
        estConnecté();
        $_SESSION['profil'] = array();
        var_dump($_SESSION);
        header ("Location:" .'/') ;
    }

?>