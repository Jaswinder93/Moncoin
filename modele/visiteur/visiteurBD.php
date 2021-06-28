<?php

function checkConnection($login, $password, &$profil)
{
    require("./modele/connexionBD.php");
    $sql_req = "SELECT * from `utilisateur` where login=:login and password=:password";
    try {
        $statement = $pdo->prepare($sql_req);
        $statement->bindParam(':login', $login);
        $statement->bindParam(':password', $password);
        $statement->execute();
        $rowAll = $statement->fetchAll(PDO::FETCH_BOTH); // fetchAll() car PLUSIEURS LIGNES récupérées

        //Verification si compte existe
        if (count($rowAll) > 0) {
            $profil = $rowAll[0];
            return true;
        }
        $profil = array();
        return false;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

function checkInscription($nom, $prenom, $login, $password, $mail, $tel, $adresse, $repSec,$questSec)
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

function checkLogin($login, $contenu)
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

function checkRepSec($login, $repSec,$contenu)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `utilisateur` where login=:login and reponseSecrete=:repSec";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->bindParam(':login', $login);
        $statement->bindParam(':repSec', $repSec);
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

function checkMdpIdentique($mdp_one, $login)
{
    require("./modele/connexionBD.php");
        $sql_ajt = "UPDATE `utilisateur` set password=:password WHERE login=:login";
        try {
            $statement = $pdo->prepare($sql_ajt);
            $statement->bindParam(':login', $login);
            $statement->bindParam(':password', $mdp_one);
            $statement->execute();
            return true;
        } catch (PDOException $e) {
            
            echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
            return false;
            die(); // On arrête le script php
        }
}

function recupProduits($contenu)
{
    require("./modele/connexionBD.php");
    $sql_ajt = "SELECT * from `produit` ORDER BY DateTime desc";
    try {
        $statement = $pdo->prepare($sql_ajt);
        $statement->setFetchMode(PDO::FETCH_ASSOC);
        $statement->execute();
        $rowAll = $statement->fetchAll(); // fetchAll() car PLUSIEURS LIGNES récupérées
        //Verification si compte existe
        if (count($rowAll) > 0) {
            for($i=0;$i<count($rowAll);$i++){
                $contenu[$i] = $rowAll[$i];
                $user=recupVendeur($contenu[$i]['idVendeur']);
                $contenu[$i]["utilisateur"]=$user;
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


function recupProduitsCateg($contenu,$categorie)
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
            for($i=0;$i<count($rowAll);$i++){
                $contenu[$i] = $rowAll[$i];
                $user=recupVendeur($contenu[$i]['idVendeur']);
                $contenu[$i]["utilisateur"]=$user;
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

function recupProduit($id)
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
                $user=recupVendeur($contenu[0]['idVendeur']);
                $contenu[0]["utilisateur"]=$user;
            return $contenu;
        }
        $contenu = array();
        return $contenu;
    } catch (PDOException $e) {
        echo utf8_encode("Echec de select : " . $e->getMessage() . "\n");
        die();
    }
}

function recupVendeur($id){
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
