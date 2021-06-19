
<?php
require_once('vue/View.php');
function accueil()
{
    $view = new View('visiteur/accueil');
    $view->generate();
}


//identification
function identification()
{
    $view = new View('visiteur/identification');
    $view->generate();
}

//requête vers BDD renvoie vrai si le compte existe

//selon les données saisies, et le profil des données affiche le compte profil sinon msg erreur si non existant
function verificationIdent()
{
    require("./modele/visiteur/visiteurBD.php");
    if (count($_POST) == 0) {
        identification();
    } else {
        try {
            $login = isset($_POST['login']) ? ($_POST['login']) : '';
            $password = isset($_POST['password']) ? ($_POST['password']) : '';
            if (count($_POST) == 0)
                identification();
            if (!checkConnection($login, $password, $profil)) {
                $_SESSION['profil'] = "";
                $msg = "les informations renseignées sont erronées !";
                require_once("controle/erreur.php");
                erreuridentification($msg);
            } else {
                $_SESSION['profil'] = $profil;
                $url = "/" . $_SESSION['profil']['typeUtilisateur'] . "/accueil";
                header("Location:" . $url);
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}

//mot de passe oublier
function password()
{
    $view = new View('visiteur/password');
    $view->generate();
}
//inscription

function inscription()
{
    $view = new View('visiteur/inscription');
    $view->generate();
}

//retourne vrai si l'inscription est effectué

function verificationInscrit()
{
    require("./modele/visiteur/visiteurBD.php");
    if (count($_POST) == 0) {
        inscription();
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
            if (!checkInscription($nom, $prenom, $login, $password, $mail, $telephone, $adresse, $repSec, $questSec)) {
                $msg = "Ce login est déjà utilisé !";
                $view = new View('visiteur/inscription');
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "Vous êtes inscrit, vous pouvez vous connecter";
                $view = new View('visiteur/inscription');
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

function verifMotDePasse()
{
    require("./modele/visiteur/visiteurBD.php");
    if (count($_POST) == 0) {
        password();
    } else {
        try {
            $login = isset($_POST['login']) ? ($_POST['login']) : '';
            $contenu = array();
            $contenu = checkLogin($login, $contenu);
            if (!empty($contenu)) {
                $view = new View('visiteur/repSecrete');
                $view->setContentArray($contenu);
                $view->generate();
            } else {
                $msg = "Mauvais login !";
                require_once("controle/erreur.php");
                erreurPassword($msg);
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}
function verifRepSec()
{
    require("./modele/visiteur/visiteurBD.php");
    if (count($_POST) == 0) {
        password();
    } else {
        try {
            $login = isset($_POST['login']) ? ($_POST['login']) : '';
            $repSec = isset($_POST['repSec']) ? ($_POST['repSec']) : '';
            $contenu = array();
            $contenu = checkRepSec($login, $repSec, $contenu);
            if (!empty($contenu)) {
                $view = new View('visiteur/modifPassword');
                $view->setContentArray($contenu);
                $view->generate();
            } else {
                $msg = "Mauvaise réponse secrète !";
                require_once("controle/erreur.php");
                erreurRepSec($msg);
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}
function chgMotDePasse()
{
    require("./modele/visiteur/visiteurBD.php");
    if (count($_POST) == 0) {
        password();
    } else {
        try {

            $password_one = isset($_POST['password_one']) ? ($_POST['password_one']) : '';
            $password_two = isset($_POST['password_two']) ? ($_POST['password_two']) : '';
            $login = isset($_POST['login']) ? ($_POST['login']) : '';
            $password_one = filter_var($password_one, FILTER_SANITIZE_STRING);
            $password_two = filter_var($password_two, FILTER_SANITIZE_STRING);

            if (strcmp($password_one, $password_two) == 0) {
                if (checkMdpIdentique($password_one, $login)) {
                    $msg = "Le mot de passe à été modifié avec succès !";
                    $view = new View('visiteur/identification');
                    $view->setMsg($msg);
                    $view->generate();
                }
            } else {
                $msg = "Les 2 mots de passes ne se correspondent pas !";
                require_once("controle/erreur.php");
                erreurMotDePasse($msg);
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}



?>
