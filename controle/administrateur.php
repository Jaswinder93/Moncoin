<?php

require_once('vue/View.php');
/* function accueil() {
        estConnecté();
        $view = new View('administrateur/accueil');
        $view->generate();
    }
*/
function estConnecté()
{
    if (strcmp($_SESSION['profil']['typeUtilisateur'], "administrateur") != 0)
        header("Location:" . '/');
}
function deconnexion()
{
    var_dump($_SESSION);
    estConnecté();
    $_SESSION['profil'] = array();
    var_dump($_SESSION);
    header("Location:" . '/');
}

function accueil()
{
    estConnecté();
    require("./modele/administrateur/administrateurBD.php");
    $contenu = array();
    $contenu = recupProduitsAd($contenu);
    $view = new View('administrateur/accueil');
    $view->setContentArray($contenu);
    $view->generate();
}


/*clique sur un produit*/
function produit()
{

    estConnecté();
    require("./modele/administrateur/administrateurBD.php");
    if (count($_POST) == 0) {
        $view = new View('administrateur/produit');
        $view->generate();
    } else {
        $view = new View('administrateur/produit');
        $contenu = array();
        $contenu = recupProduitAd($_POST['produit']);
        $view->setContentArray($contenu);
        $view->generate();
    }
}

function ajoutPanier()
{
    estConnecté();
    $view = new View('administrateur/panier');
    $view->setMsg("Veuillez vous connecter pour pouvoir effectuer un achat");
    $view->generate();
}

function panier()
{
    estConnecté();
    $view = new View('administrateur/identification');
    $view->setMsg("Veuillez vous connecter pour pouvoir accéder au panier");
    $view->generate();
}

function informations()
{
    estConnecté();
    $view = new View('administrateur/informations');
    $view->generate();
}


function footer()
{
    estConnecté();
    $view = new View('administrateur/infofooter');
    $view->generate();
}

function changeInformation()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    $nom = isset($_POST['nom']) ? ($_POST['nom']) : '';
    $prenom = isset($_POST['prenom']) ? ($_POST['prenom']) : '';
    $mail = isset($_POST['mail']) ? ($_POST['mail']) : '';
    $telephone = isset($_POST['telephone']) ? ($_POST['telephone']) : '';
    $adresse = isset($_POST['adresse']) ? ($_POST['adresse']) : '';
    $repSec = isset($_POST['repSec']) ? ($_POST['repSec']) : '';
    $questSec = isset($_POST['questSec']) ? ($_POST['questSec']) : '';
    updateUser($_SESSION['profil']['idUtilisateur'], $nom, $prenom, $mail, $questSec, $repSec, $adresse, $telephone);
    $login = $_SESSION['profil']['login'];
    $_SESSION['profil'] = newInfosUser($login);
    $view = new View('administrateur/informations');

    $view->setMsg("Modifications effectué !");
    $view->generate();
}




/**Fonctionnalités administrateur */

function gestionUser()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    $view = new View('administrateur/gestionUser');
    $contenu = array();
    $contenu = recupUserAdmin($contenu);
    $view->setContentArray($contenu);
    $view->generate();
}

function editUser(){
    require("./modele/administrateur/administrateurBD.php");
    if (count($_POST) == 0) {
        gestionUser();
    } else {
        try {
            $login = isset($_POST['login']) ? ($_POST['login']) : '';
            $id = isset($_POST['id']) ? ($_POST['id']) : '';
            $nom = isset($_POST['nom']) ? ($_POST['nom']) : '';
            $prenom = isset($_POST['prenom']) ? ($_POST['prenom']) : '';
            $mail = isset($_POST['mail']) ? ($_POST['mail']) : '';
            $telephone = isset($_POST['telephone']) ? ($_POST['telephone']) : '';
            $adresse = isset($_POST['adresse']) ? ($_POST['adresse']) : '';
            $repSec = isset($_POST['repSec']) ? ($_POST['repSec']) : '';
            $questSec = isset($_POST['questSec']) ? ($_POST['questSec']) : '';
            if (!updateUser($id,$nom, $prenom, $mail,$questSec,$repSec,$adresse, $telephone)) {
                $msg = "Erreur dans le changement, veuillez essayer plus tard !";
                $view = new View('administrateur/gestionUser');
                $contenu = array();
                $contenu = recupUserAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                actionAdmin($_SESSION['profil']['idUtilisateur'],"modifications",$login);
                $msg = "Modifications effectuées !";
                $view = new View('administrateur/gestionUser');
                $contenu = array();
                $contenu = recupUserAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}
function ajoutUser()
{
    require("./modele/administrateur/administrateurBD.php");
    if (count($_POST) == 0) {
        gestionUser();
    } else {
        try {

            $nom = isset($_POST['nom']) ? ($_POST['nom']) : '';
            $prenom = isset($_POST['prenom']) ? ($_POST['prenom']) : '';
            $login = isset($_POST['login']) ? ($_POST['login']) : '';
            $password = isset($_POST['password']) ? ($_POST['password']) : '';
            $mail = isset($_POST['mail']) ? ($_POST['mail']) : '';
            $telephone = isset($_POST['telephone']) ? ($_POST['telephone']) : '';
            $adresse = isset($_POST['adresse']) ? ($_POST['adresse']) : '';
            $repSec = isset($_POST['repSec']) ? ($_POST['repSec']) : '';
            $questSec = isset($_POST['questSec']) ? ($_POST['questSec']) : '';
            if (!ajoutInscription($nom, $prenom, $login, $password, $mail, $telephone, $adresse, $repSec, $questSec)) {
                $msg = "Ce login est déjà utilisé !";
                $view = new View('administrateur/gestionUser');
                $contenu = array();
                $contenu = recupUserAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                actionAdmin($_SESSION['profil']['idUtilisateur'],"ajout",$login);
                $msg = "utilisateur ajouté !";
                $view = new View('administrateur/gestionUser');
                $contenu = array();
                $contenu = recupUserAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}

function deleteUser()
{
    require("./modele/administrateur/administrateurBD.php");
    if (count($_POST) == 0) {
        gestionUser();
    } else {
        try {

            $login = isset($_POST['login']) ? ($_POST['login']) : '';
            if (!supprimeUser($login)) {
                $msg = "Echec de suppresion veuillez reessayer !";
                $view = new View('administrateur/gestionUser');
                $contenu = array();
                $contenu = recupUserAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                actionAdmin($_SESSION['profil']['idUtilisateur'],"suppression",$login);
                $msg = "utilisateur supprimé !";
                $view = new View('administrateur/gestionUser');
                $contenu = array();
                $contenu = recupUserAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}
