<?php
    $this->t = "Moncoin";
?>

<div id="bgdebut">
    <div class="contentCategory">
        <h1>Découvrez les différentes catégories de Moncoin</h1>
        <div class="carousel" data-flickity='{ "groupCells": true, "autoPlay": true, "imagesLoaded":true }'>
        <div class="carousel-cell">
        <a href="/administrateur/produit?categorie=Vêtements#bgdebut">
            <img class="w3-images" src="../vue/administrateur/img/vetement.png">

        </a>
        <p>Vêtements</p>
    </div>
    <div class="carousel-cell">
        <a href="/administrateur/produit?categorie=Informatique#bgdebut">
            <img class="w3-images" src="../vue/administrateur/img/pc.png">

        </a>
        <p>Informatique</p>
    </div>
    <div class="carousel-cell">
        <a href="/administrateur/produit?categorie=Livres#bgdebut">
            <img class="w3-images" src="../vue/administrateur/img/book.png">
        </a>
        <p>Livres</p>
    </div>
    <div class="carousel-cell">
        <a href="/administrateur/produit?categorie=Chaussures#bgdebut">
            <img class="w3-images" src="../vue/administrateur/img/boot.png">
        </a>
        <p>Chaussures</p>
    </div>
    <div class="carousel-cell">
        <a href="/administrateur/produit?categorie=Bijoux#bgdebut">
            <img class="w3-images" src="../vue/administrateur/img/bijou.png">
        </a>
        <p>Bijoux</p>
    </div>
    <div class="carousel-cell">
        <a href="/administrateur/produit?categorie=Jeux-DVD#bgdebut">
            <img class="w3-images" src="../vue/administrateur/img/jeu.png">
        </a>
        <p>Jeux/DVD</p>
    </div>
    <div class="carousel-cell">
        <a href="/administrateur/produit?categorie=Logiciels#bgdebut">
            <img class="w3-images" src="../vue/administrateur/img/logiciel.png">
        </a>

        <p>Logiciels</p>
            </div>
        </div>
    </div>
</div>
<div class="basAccueil">
        <?php 
    $nb_ele_accueil = 8;
    $nb_products= sizeof($this->contentArray);
    $nb_page_accueil=ceil($nb_products/$nb_ele_accueil);


    @$page_souhaite=isset($_GET['page']) ? ($_GET['page']) : 1;
    if($page_souhaite< 1){
        $page_souhaite=1;
    }
    if($page_souhaite>= $nb_page_accueil){
        $page_souhaite=$nb_page_accueil;
    }
    $debut=($page_souhaite-1)*$nb_ele_accueil;
    $fin = $debut + $nb_ele_accueil;
    if($fin>$nb_products){
        $fin=$nb_products;
    }
    ?>
    <h1>Explorez les produits récemment ajoutés</h1>

    <div id="pagination">
        <div class="menuPagesBas">

            <?php

        $page = $page_souhaite;
        if($page>1){
            echo "<li><a href='?page=".($page-1)."#pagination' >Precedent</a></li>";
        }
        if($page<$nb_page_accueil){
            echo "<li><a href='?page=".($page+1)."#pagination' >Suivant</a></li>";
        }
        ?>
        </div>
        <div class="menuPages">
            <?php
            for($x=1;$x<=$nb_page_accueil;$x++){
                echo "<a href='?page=$x#pagination' selected>$x</a>";
            }
        ?>
        </div>
        <div class="allProducts">
            <?php
        for($i =$debut; $i<$fin;$i++){
            $image = $this->contentArray[$i]['image'];
            // image path, convertir en base64
            $imageData = base64_encode($image);
            // Formatimage 
            $src = 'data: image/jpeg;base64,'.$imageData;
            if($this->contentArray[$i]['QteProduit']>0){
            echo '<div class="eachProduct">';
            echo '<div class="eachProductPlace">';
            echo '<form action="/administrateur/produit#choiceProduct" method="post">';
            echo '<img src="'.$src.'">';
            echo '<div>';
            echo '<p class="titreProd">'.$this->contentArray[$i]['NomProduit'].'</p>';
            echo '<p class="prixProd">'.$this->contentArray[$i]['PrixProduit']."€";'</p>';
            echo '<p style="color:green">Disponible en stock : '.$this->contentArray[$i]['QteProduit'].'</p>';
            echo '<p class="vendeurProd">Vendu par '.$this->contentArray[$i]['utilisateur']['nom']." ".$this->contentArray[$i]['utilisateur']['prenom'];'</p><br>';
            echo '</div>';
            echo '<input id="monId" type="hidden" name="produit" value='.$this->contentArray[$i]['idProduit'].'>';
            echo '</br><input  class="formProd" type="submit" value="Voir le produit">';
            echo '</form>';
            echo '</div>';
            echo '</div>';
            }
        }   

        ?>

        </div>

        <div class="menuPagesBas">

            <?php
        if($page>1){
            echo "<li><a href='?page=".($page-1)."#pagination' >Precedent</a></li>";
        }
        if($page<$nb_page_accueil){
            echo "<li><a href='?page=".($page+1)."#pagination' >Suivant</a></li>";
        }
        ?>

            <p class="infoPage">Page
                <?=$page?>
            </p>
        </div>
    </div>
</div>