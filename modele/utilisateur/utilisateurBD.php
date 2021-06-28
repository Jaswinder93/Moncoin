<?php


/** Récupération de tout les produits triés par date **/
function recupProduitsUser($contenu)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `produit` ORDER BY DateTime desc";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            for ($i = 0; $i < count($rowAll); $i++) {
                $contenu[$i] = $rowAll[$i];
                $user = recupVendeurUser($contenu[$i]['idVendeur']);
                
                $contenu[$i]["utilisateur"] = $user;
            }
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}


/** aller vers un produit précis selon son id **/

function recupProduitUser($id)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `produit`  where idProduit=:id";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':id', $id);
        $statement->execute();
        $rowAll = $statement->fetchAll(PDO::FETCH_BOTH);

        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            $user = recupVendeurUser($contenu[0]['idVendeur']);
            $contenu[0]["utilisateur"] = $user;
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}
/** information du vendeur a parti de son identifiant **/

function recupVendeurUser($id)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `utilisateur` where idUtilisateur=:id";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':id', $id);
        $statement->execute();
        $rowAll = $statement->fetchAll(PDO::FETCH_BOTH);
        if (count($rowAll) > 0) {
            $contenu = $rowAll[0];
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}


/*recup info user de la bdd*/
function newInfosUser($login)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `utilisateur` where login=:login";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':login', $login);
        $statement->execute();
        $rowAll = $statement->fetchAll(PDO::FETCH_BOTH);
        if (count($rowAll) > 0) {
            $contenu = $rowAll[0];
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}


/** Recupération de produits selon la catégorie */
function recupProduitsCategUser($contenu, $categorie)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `produit` where Categorie=:categorie ORDER BY idProduit desc";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':categorie', $categorie);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            for ($i = 0; $i < count($rowAll); $i++) {
                $contenu[$i] = $rowAll[$i];
                $user = recupVendeurUser($contenu[$i]['idVendeur']);
                $contenu[$i]["utilisateur"] = $user;
            }
            //var_dump($contenu[0]);
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

/** Panier gestionnaire **/
/*recuperer le panier d'utilisateur*/
function recupPanierUserUtil($id)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT *
                FROM produit p
                INNER JOIN panier PA
                    on PA.idProduit = p.idProduit
                where PA.idUtilisateur=:id;";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':id', $id);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

/* ajout de produits dans le panier de l'utilisateur*/
function ajoutPanierBdUser($idProd, $qteProd, $idUser)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "INSERT INTO `panier`(`idPanier`, `nbProduits`, `idUtilisateur`, `idProduit`) VALUES 
    (null,:qteProd,:idUser,:idProd)";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':qteProd', $qteProd);
        $statement->bindParam(':idUser', $idUser);
        $statement->bindParam(':idProd', $idProd);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

/* supprimer le produits dans le panier de l'utilisateur*/
function supprimeProdPanierUser($idP, $idU)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "DELETE FROM `panier` WHERE idProduit=:idProduit and idUtilisateur=:idU";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':idProduit', $idP);
        $statement->bindParam(':idU', $idU);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        return false;
        die();
    }
}

/*Vide totalement le panier */
function viderLePanier($id)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "DELETE FROM `panier` WHERE idUtilisateur=:idU";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':idU', $id);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        return false;
        die();
    }
}



/** Commande  **/
/** Maj de la quantité du produit après commande **/
function majQteProdUser($idProd, $qteProd)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "Update `produit` SET  `QteProduit`=:qte WHERE idProduit=:id";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':id', $idProd);
        $statement->bindParam(':qte', $qteProd);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}
/* Ajout de commande et retourne cette commande pour mettre a jour son contenu */
function ajouterCommandeUser($idUser,$idAdmin,$montantCommande){
    require("./modele/connexionBD.php");
    $sql_ajt = "INSERT INTO `commande`(`EtatCommande`, `MontantCommande`, `DateCommande`,`idAdmin`, `idUtilisateur`) 
    VALUES ('En cours',:montant,now(),:idAdmin,:idUser);";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':montant', $montantCommande);
        $statement->bindParam(':idUser', $idUser);
        $statement->bindParam(':idAdmin',$idAdmin);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $commandeUser=commandeUserLastUser($idUser);
        return $commandeUser;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

/*retourne le dernier utilisateur*/
function commandeUserLastUser($idUser){
    require("./modele/connexionBD.php");
    $sql_ajt="Select * from commande WHERE idUtilisateur=:idU ORDER BY idCommande desc limit 1";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':idU', $idUser);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

//commande d'utilisateur en parametre
function commandeUserUtil($idUser){
    require("./modele/connexionBD.php");
    $sql_ajt="Select * from commande WHERE idUtilisateur=:idU";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':idU', $idUser);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

/*Commande de l'utilisateur en parametre*/

function commandeUtil($idUser){
    require("./modele/connexionBD.php");
    $sql_ajt="Select * from commande WHERE idUtilisateur=:idU";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':idU', $idUser);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

/*cherche le prod selon id Commande*/

function selecProdCmdUser($idC){
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT *
            FROM produit p
            INNER JOIN constitue c
                on c.idProduit= p.idProduit
            INNER JOIN commande co
                on co.idCommande = c.idCommande
            where co.idCommande=:idC;";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->bindParam(':idC', $idC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            //var_dump($contenu[0]);
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
    
}

/*cherche la commande à partie du id produit*/

function selectCmdProdUser($idP){
    require("./modele/connexionBD.php");
    $sql_ajt = "Select * from Commande co INNER JOIN constitue c
    on co.idCommande= c.idCommande INNER JOIN Produit p on c.idProduit=p.idProduit where p.idProduit=:idP";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->bindParam(':idP', $idP);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            //var_dump($contenu[0]);
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
    
}

/*contenu commande associe la commande aux produits */
function constitueCommandeUser($idProd,$idCommande,$qteProd){
    require("./modele/connexionBD.php");
    $sql_ajt = "INSERT INTO `constitue`(`idProduit`, `idCommande`, `qteProduit`) 
    VALUES (:idp,:idc,:qteP);";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':idc', $idCommande);
        $statement->bindParam(':idp', $idProd);
        $statement->bindParam(':qteP', $qteProd);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}


/** Actions Ventes contenu/Ajout/Suppresion/modifications etc ... **/
//recupere les ventes de l'utilisateur
function recupVenteUserUtil($id)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `produit` where idVendeur=:id";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':id', $id);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll();
        if (count($rowAll) > 0) {
            $contenu = $rowAll;
            //var_dump($contenu[0]);
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}


//ajoute un produit dans la liste des ventes que propose l'utilisateur
function ajoutProduitUser($nom, $prix, $categorie, $quantite, $desc, $idVendeur, $dataImg, $date)
{

    require("./modele/connexionBD.php");

    $sql_ajt = "INSERT INTO `produit`(`idProduit`, `NomProduit`, `PrixProduit`, `QteProduit`, `Categorie`, `idVendeur`,`image`,`Description`,`DateTime`) 
                    VALUES (null,:nomP,:prixP,:qteP,:catP,:idV,:img,:decrit,:datetemps)";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':nomP', $nom);
        $statement->bindParam(':prixP', $prix);
        $statement->bindParam(':qteP', $quantite);
        $statement->bindParam(':catP', $categorie);
        $statement->bindParam(':img', $dataImg);
        $statement->bindParam(':idV', $idVendeur);
        $statement->bindParam(':decrit', $desc);
        $statement->bindParam(':datetemps', $date);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

//supprime un produit dans la liste des ventes que propose l'utilisateur
function supprimeProdUser($id)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "DELETE FROM `produit` WHERE idProduit=:id";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':id', $id);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        return false;
        die();
    }
}

//maj de la quantité du produit
function updateQteUser($id, $qte)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "Update `produit` SET  `QteProduit`=:qte WHERE idProduit=:idProd";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':qte', $qte);
        $statement->bindParam(':idProd', $id);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

?>