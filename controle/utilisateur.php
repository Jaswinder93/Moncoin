<?php

require_once('vue/View.php');
    /** Vérification si une session existe sinon accueil visiteur */
    function estConnecté(){
        if(strcmp ($_SESSION['profil']['typeUtilisateur'],"utilisateur")!=0)
            header ("Location:" .'/');
    }
    
/** Destruction de la session **/
    function deconnexion(){
        var_dump($_SESSION);
        estConnecté();
        $_SESSION['profil'] = array();
        var_dump($_SESSION);
        header ("Location:" .'/') ;
    }

/** vue Accueil utilisateur **/
    function accueil()
{
    estConnecté();
    require("./modele/utilisateur/utilisateurBD.php");
    $contenu = array();
    $contenu = recupProduitsUser($contenu);
    $view = new View('utilisateur/accueil');
    $view->setContentArray($contenu);
    $view->generate();
}


/*clique sur un produit*/
function produit()
{

    estConnecté();
    require("./modele/utilisateur/utilisateurBD.php");
    if (count($_POST) == 0) {
        $view = new View('utilisateur/produit');
        $view->generate();
    } else {
        $view = new View('utilisateur/produit');
        $contenu = array();
        $contenu = recupProduitUser($_POST['produit']);
        $view->setContentArray($contenu);
        $view->generate();
    }
}
/** Footer user **/
function footerUser()
{
    estConnecté();
    $view = new View('utilisateur/infofooterUser');
    $view->generate();
}

/** Informations de l'utilisateur **/

function informationsUser()
{
    estConnecté();
    $view = new View('utilisateur/informationsUser');
    $view->generate();
}

/** Changements d'informations utilisateur**/
function changeInformation()
{
    
    require("./modele/utilisateur/utilisateurBD.php");
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
    $view = new View('utilisateur/informationsUser');

    $view->setMsg("Modifications effectué !");
    $view->generate();
}



/*Fonctionnalités commande  */
function commande()
{
    require("./modele/utilisateur/utilisateurBD.php");
    estConnecté();
    $view = new View('utilisateur/commande');
    $contenu = array();
    $id = $_SESSION['profil']['idUtilisateur'];
    $contenu = commandeUtil($id);
    $view->setContentArray($contenu);
    $view->generate();
}

function ajoutCommandeUser()
{
    require("./modele/utilisateur/utilisateurBD.php");
    estConnecté();
    if (count($_POST) == 0) {
        commande();
    } else {
        try {
            $idproduits = $_POST['idProduct'];
            $qteProduct = $_POST['qteProduct'];
            $qteDispo =$_POST['qteDispo'];
            $montantCommande = $_POST['totalPrice'];
            $id = $_SESSION['profil']['idUtilisateur'];
            //var_dump($idproduits);
            //var_dump($qteProduct);
            $index=0;
            foreach ($idproduits as $idP) {
                $quantiteDispo=$qteDispo[$index];
                $quantite=$qteProduct[$index];
                $quantiteTotal=intval($quantiteDispo) - intval($quantite);;
                majQteProd($idP,$quantiteTotal);
                $index++;
            }
            $valueCommande = ajouterCommande($id, 1, $montantCommande);
            if (!$valueCommande) {
                $msg = "Echec de commande !";
                $view = new View('utilisateur/commande');
                $contenu = array();
                $contenu = commandeUser($id);
                $view->setMsg($msg);
                $view->setContentArray($contenu);
                $view->generate();
            } else {
                echo "<script>alert('Commande passée !');</script>";
                $index=0;
                foreach ($idproduits as $idP) {
                    constitueCommande($idP,$valueCommande[0]['idCommande'],$qteProduct[$index]);
                    $index++;
                }
                $view = new View('utilisateur/commande');
                $contenu = array();
                $contenu = commandeUser($id);
                viderLePanier($id);
                $view->setContentArray($contenu);
                $view->generate();
            }
        } catch (Exception $e) {
            $msgError = $e->getMessage();
            require_once("controle/erreur.php");
            erreur($msgError);
        }
    }
}


/*Fonctionnalités panier  */

/*recupere panier d'un user*/
function panier()
{
    require("./modele/utilisateur/utilisateurBD.php");
    estConnecté();
    $view = new View('utilisateur/panier');
    $id = $_SESSION['profil']['idUtilisateur'];
    $contenu = recupPanierUserUtil($id);
    $view->setContentArray($contenu);
    $view->generate();
}

function ajoutPanier()
{
    require("./modele/utilisateur/utilisateurBD.php");
    estConnecté();

    if (count($_POST) == 0) {
        panier();
    } else {
        try {
            $id = $_SESSION['profil']['idUtilisateur'];
            $quantiteTotal = isset($_POST['totalQuantite']) ? ($_POST['totalQuantite']) : '';

            $quantite = isset($_POST['quantite']) ? ($_POST['quantite']) : '';
            $idProd = isset($_POST['idProduit']) ? ($_POST['idProduit']) : '';
            //$quantiteFinal = intval($quantiteTotal) - intval($quantite);
            if (!ajoutPanierBdUser($idProd, $quantite, $id)) {
                $msg = "Erreur ajout !";
                $view = new View('utilisateur/panier');
                $contenu = array();
                $contenu = recupPanierUserUtil($id);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "Produit ajouté au panier!";
                $view = new View('utilisateur/panier');
                $contenu = array();
                $contenu = recupPanierUserUtil($id);
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


//suppression du panier
function deleteFromPanier()
{
    require("./modele/utilisateur/utilisateurrBD.php");
    estConnecté();
    if (count($_POST) == 0) {
        panier();
    } else {
        try {

            $quantiteTotal = isset($_POST['totalQuantite']) ? ($_POST['totalQuantite']) : '';
            $quantite = isset($_POST['quantite']) ? ($_POST['quantite']) : '';
            //$quantiteFinal = intval($quantiteTotal) + intval($quantite);
            $idProd = isset($_POST['idProduit']) ? ($_POST['idProduit']) : '';
            $id = $_SESSION['profil']['idUtilisateur'];
            if (!supprimeProdPanierUser($idProd, $id)) {
                $msg = "Echec de suppresion veuillez reessayer !";
                $view = new View('utilisateur/panier');
                $contenu = array();
                $contenu = recupPanierUserUtil($id);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "produit supprimé !";
                $view = new View('utilisateur/panier');
                $contenu = array();
                $contenu = recupPanierUserUtil($id);
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

//modifie quantité produit apres commande
function modifQteUser()
{
    require("./modele/utilisateur/utilisateurBD.php");
    estConnecté();
    if (count($_POST) == 0) {
        vente();
    } else {
        try {
            $id = isset($_POST['id']) ? ($_POST['id']) : '';
            $qte = isset($_POST['newQte']) ? ($_POST['newQte']) : '';
            $idVendeur = $_SESSION['profil']['idUtilisateur'];
            if (!updateQte($id, $qte)) {
                $msg = "Echec de modification veuillez reessayer !";
                $view = new View('administrateur/vente');
                $contenu = array();
                $contenu = recupVenteUser($idVendeur);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "Quantité modifié !";
                $view = new View('administrateur/vente');
                $contenu = array();
                $contenu = recupVenteUser($idVendeur);
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

?>