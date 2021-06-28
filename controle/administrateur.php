<?php

require_once('vue/View.php');

/** Vérification si une session existe sinon accueil visiteur */
function estConnecté()
{
    if (strcmp($_SESSION['profil']['typeUtilisateur'], "administrateur") != 0)
        header("Location:" . '/');
}
/** Destruction de la session **/
function deconnexion()
{
    estConnecté();
    $_SESSION['profil'] = array();
    session_destroy();
    header("Location:" . '/');
}

/** vue Accueil Administrateur **/
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



/** Informations de l'utilisateur **/
function informationsAd()
{
    estConnecté();
    $view = new View('administrateur/informationsAd');
    $view->generate();
}

/** Footer Admin **/
function footerAd()
{
    estConnecté();
    $view = new View('administrateur/infofooterAd');
    $view->generate();
}

/** Changements d'informations administrateur**/
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
    $view = new View('administrateur/informationsAd');

    $view->setMsg("Modifications effectué !");
    $view->generate();
}


/*Fonctionnalités panier  */
function ajoutPanier()
{
    require("./modele/administrateur/administrateurBD.php");
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
            if (!ajoutPanierBd($idProd, $quantite, $id)) {
                $msg = "Erreur ajout !";
                $view = new View('administrateur/panier');
                $contenu = array();
                $contenu = recupPanierUser($id);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "Produit ajouté au panier!";
                $view = new View('administrateur/panier');
                $contenu = array();
                $contenu = recupPanierUser($id);
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


/*recupere panier d'un user*/
function panier()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    $view = new View('administrateur/panier');
    $id = $_SESSION['profil']['idUtilisateur'];
    $contenu = recupPanierUser($id);
    $view->setContentArray($contenu);
    $view->generate();
}
//suppression du panier
function deleteFromPanier()
{
    require("./modele/administrateur/administrateurBD.php");
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
            if (!supprimeProdPanier($idProd, $id)) {
                $msg = "Echec de suppresion veuillez reessayer !";
                $view = new View('administrateur/panier');
                $contenu = array();
                $contenu = recupPanierUser($id);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                /*
                try {
                    majQteProd($idProd, $quantiteFinal);
                } catch (Exception $e) {
                    $msgError = $e->getMessage();
                    require_once("controle/erreur.php");
                    erreur($msgError);
                }
                */
                $msg = "produit supprimé !";
                $view = new View('administrateur/panier');
                $contenu = array();
                $contenu = recupPanierUser($id);
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

function viderPanier()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    $view = new View('administrateur/panier');
    $contenu = array();
    $id = $_SESSION['profil']['idUtilisateur'];
    viderLePanier($id);
    $contenu = recupPanierUser($id);
    $view->setContentArray($contenu);
    $view->generate();
}




///////////////////////////////////////
/*Fonctionnalités ventes  */
function vente()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    $view = new View('administrateur/vente');
    $contenu = array();
    $id = $_SESSION['profil']['idUtilisateur'];
    $contenu = recupVenteUser($id);
    $view->setContentArray($contenu);
    $view->generate();
}
/** Gestion des produits **/

function ajoutProd()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    if (count($_POST) == 0) {
        vente();
    } else {
        try {

            $nom = isset($_POST['nom']) ? ($_POST['nom']) : '';
            $prix = isset($_POST['prix']) ? ($_POST['prix']) : '';

            $categorie = isset($_POST['categorie']) ? ($_POST['categorie']) : '';
            $quantite = isset($_POST['quantite']) ? ($_POST['quantite']) : '';
            $desc = isset($_POST['description']) ? ($_POST['description']) : '';
            $dataImg = file_get_contents($_FILES['imgProd']['tmp_name']);
            $idVendeur = $_SESSION['profil']['idUtilisateur'];
            // echo $idVendeur;
            $currentDateTime = date('Y-m-d H:i:s');
            if (!ajoutProduit($nom, $prix, $categorie, $quantite, $desc, $idVendeur, $dataImg, $currentDateTime)) {
                $msg = "Erreur ajout !";
                $view = new View('administrateur/vente');
                $contenu = array();
                $contenu = recupVenteUser($idVendeur);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "Produit ajouté !";
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

function deleteProduct()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    if (count($_POST) == 0) {
        vente();
    } else {
        try {

            $id = isset($_POST['id']) ? ($_POST['id']) : '';
            $idVendeur = $_SESSION['profil']['idUtilisateur'];
            if (!supprimeProd($id)) {
                $msg = "Echec de suppresion veuillez reessayer !";
                $view = new View('administrateur/vente');
                $contenu = array();
                $contenu = recupVenteUser($idVendeur);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "produit supprimé !";
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

function modifQte()
{
    require("./modele/administrateur/administrateurBD.php");
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

/*Fonctionnalités ventes  */
function commande()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    $view = new View('administrateur/commande');
    $contenu = array();
    $id = $_SESSION['profil']['idUtilisateur'];
    $contenu = commandeUser($id);
    $view->setContentArray($contenu);
    $view->generate();
}


function ajoutCommande()
{
    require("./modele/administrateur/administrateurBD.php");
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
                $view = new View('administrateur/commande');
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
                $view = new View('administrateur/commande');
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

/**Fonctionnalités administrateur */

function gestionCommande()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    $view = new View('administrateur/gestionCommande');
    $contenu = array();
    $contenu = recupCommandeAdmin($contenu);
    $view->setContentArray($contenu);
    $view->generate();
}

function editCommande()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
    if (count($_POST) == 0) {
        gestionCommande();
    } else {
        try {
            $id = isset($_POST['id']) ? ($_POST['id']) : '';
            $etatcommande = isset($_POST['etatCmd']) ? ($_POST['etatCmd']) : '';

            if (!updateCommande($id,$etatcommande)) {
                $msg = "Erreur dans le changement, veuillez essayer plus tard !";
                $view = new View('administrateur/gestionCommande');
                $contenu = array();
                $contenu = recupCommandeAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                $msg = "Modifications effectuées !";
                $view = new View('administrateur/gestionCommande');
                $contenu = array();
                $contenu = recupCommandeAdmin($contenu);
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

function editUser()
{
    require("./modele/administrateur/administrateurBD.php");
    estConnecté();
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
            if (!updateUser($id, $nom, $prenom, $mail, $questSec, $repSec, $adresse, $telephone)) {
                $msg = "Erreur dans le changement, veuillez essayer plus tard !";
                $view = new View('administrateur/gestionUser');
                $contenu = array();
                $contenu = recupUserAdmin($contenu);
                $view->setContentArray($contenu);
                $view->setMsg($msg);
                $view->generate();
            } else {
                actionAdmin($_SESSION['profil']['idUtilisateur'], "modifications", $login);
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
    estConnecté();
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
                actionAdmin($_SESSION['profil']['idUtilisateur'], "ajout", $login);
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
    estConnecté();
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
                actionAdmin($_SESSION['profil']['idUtilisateur'], "suppression", $login);
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
