<?php


function recupProduitsAd($contenu)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `produit` ORDER BY idProduit desc";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll(); // fetchAll() car PLUSIEURS LIGNES récupérées
        //Verification si compte existe
        if (count($rowAll) > 0) {
            for ($i = 0; $i < count($rowAll); $i++) {
                $contenu[$i] = $rowAll[$i];
                $user = recupVendeurAd($contenu[$i]['idVendeur']);
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


function recupProduitsCategAd($contenu, $categorie)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `produit` where Categorie=:categorie ORDER BY idProduit desc";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':categorie', $categorie);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll(); // fetchAll() car PLUSIEURS LIGNES récupérées
        //Verification si compte existe
        if (count($rowAll) > 0) {
            for ($i = 0; $i < count($rowAll); $i++) {
                $contenu[$i] = $rowAll[$i];
                $user = recupVendeurAd($contenu[$i]['idVendeur']);
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

function recupProduitAd($id)
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
            $user = recupVendeurAd($contenu[0]['idVendeur']);
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

function recupVendeurAd($id)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `utilisateur` where idUtilisateur=:id";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':id', $id);
        $statement->execute();
        $rowAll = $statement->fetchAll(PDO::FETCH_BOTH); // fetchAll() car PLUSIEURS LIGNES récupérées
        //Verification si compte existe
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



function actionAdmin($idAdmin,$act,$log)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "INSERT INTO `administre`(`idAdmin`, `ActionAdmin`, `loginUser`)
     VALUES (:idA,:actionAdmin,:loginUser)";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':idA', $idAdmin);
        $statement->bindParam(':actionAdmin', $act);
        $statement->bindParam(':loginUser', $log);
        $statement->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

function updateUser($id, $nom, $prenom, $mail, $questSec, $repSec, $adresse, $tel)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "Update `utilisateur` SET  `nom`=:nom,`mail`=:mail,`prenom`=:prenom, 
        `questionSecrete`=:questionSecrete,`reponseSecrete`=:reponseSecrete,`adresse`=:adresse,`tel`=:tel
                WHERE idUtilisateur=:id";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':nom', $nom);
        $statement->bindParam(':prenom', $prenom);
        $statement->bindParam(':mail', $mail);
        $statement->bindParam(':questionSecrete', $questSec);
        $statement->bindParam(':reponseSecrete', $repSec);
        $statement->bindParam(':adresse', $adresse);
        $statement->bindParam(':tel', $tel);
        $statement->bindParam(':id', $id);
        $statement->execute();
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

function newInfosUser($login)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `utilisateur` where login=:login";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':login', $login);
        $statement->execute();
        $rowAll = $statement->fetchAll(PDO::FETCH_BOTH); // fetchAll() car PLUSIEURS LIGNES récupérées
        //Verification si compte existe
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

function recupUserAdmin($contenu)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `utilisateur` where typeUtilisateur='utilisateur'";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll(); // fetchAll() car PLUSIEURS LIGNES récupérées
        //Verification si compte existe
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

function ajoutInscription($nom, $prenom, $login, $password, $mail, $tel, $adresse, $repSec, $questSec)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "INSERT INTO `utilisateur`(`login`, `nom`, `mail`, `prenom`, `password`, `tel`,`adresse`,`reponseSecrete`,`questionSecrete`) 
                    VALUES (:ndc,:nom,:mail,:prenom,:mdp,:tel,:adresse,:repSec,:questSec)";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':ndc', $login);
        $statement->bindParam(':nom', $nom);
        $statement->bindParam(':mail', $mail);
        $statement->bindParam(':prenom', $prenom);
        $statement->bindParam(':mdp', $password);
        $statement->bindParam(':tel', $tel);
        $statement->bindParam(':adresse', $adresse);
        $statement->bindParam(':repSec', $repSec);
        $statement->bindParam(':questSec', $questSec);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        return false;
        die(); // On arrête le script php
    }
}

function supprimeUser($login)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "DELETE FROM `utilisateur` WHERE login=:login and typeUtilisateur='utilisateur'";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':login', $login);
        $statement->execute();
        return true;
    } catch (PDOException $e) {
        return false;
        die();
    }
}
