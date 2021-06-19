<?php

require_once('vue/View.php');
    function erreur($msgError){
        $userNow= isset($_SESSION['profil']['typeUtilisateur'])?$_SESSION['profil']['typeUtilisateur']:'visiteur';
        $view = new View($userNow.'/erreur');
        $view->setMsgError($msgError);
        $view->generate();
    }

    function erreurIdentification($msgError){
        $userNow= isset($_SESSION['profil']['typeUtilisateur'])?$_SESSION['profil']['typeUtilisateur']:'visiteur';
        $view = new View($userNow.'/identification');
        $view->setMsgError($msgError);
        $view->generate();
    }
    function erreurPassword($msgError){
         $view = new View('visiteur/password');
        $view->setMsgError($msgError);
        $view->generate();
    }
    function erreurRepSec($msgError){
       $view = new View('visiteur/password');
       $view->setMsgError($msgError);
       $view->generate();
   }

    function erreurMotDePasse($msgError){
        $view = new View('visiteur/modifPassword');
        $view->setMsgError($msgError);
        $view->generate();
    }

?>