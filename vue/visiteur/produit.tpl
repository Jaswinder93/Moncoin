<?php
    $this->t = "produit";
?>


<div class="contentForm">
    <form class="formdebut" action="/visiteur/produit#pagination" type="post">
        <h3>Chercher par catégorie: </h3>
        <select name='categorie' id="categorie">
            <option value='Vêtements' name='vetement'>Vêtements</option>
            <option value='Informatique' name='informatique'>Informatique</option>
            <option value='Livres' name='livre'>Livres</option>
            <option value='Chaussures' name='chaussure'>Chaussures</option>
            <option value='Bijoux' name='bijou'>Bijoux</option>
            <option value='Jeux-DVD' name='jeu-dvd'>Jeux-DVD</option>
            <option value='Logiciels' name='logiciel'>Logiciels</option>
        </select>
        <input type='submit' value="Chercher" />

    </form>


</div>

<?php if (count($_POST) == 0) { ?>
<div id="bgdebut">
    <div class="contentCategory">
        <h1>Explorez les produits par catégories</h1>
        <div class="carousel" data-flickity='{ "groupCells": true, "autoPlay": true, "imagesLoaded":true }'>
            <div class="carousel-cell">
                <a href="/visiteur/produit?categorie=Vêtements#bgdebut">
                    <img class="w3-images" src="../vue/visiteur/img/vetement.png">

                </a>
                <p>Vêtements</p>
            </div>
            <div class="carousel-cell">
                <a href="/visiteur/produit?categorie=Informatique#bgdebut">
                    <img class="w3-images" src="../vue/visiteur/img/pc.png">

                </a>
                <p>Informatique</p>
            </div>
            <div class="carousel-cell">
                <a href="/visiteur/produit?categorie=Livres#bgdebut">
                    <img class="w3-images" src="../vue/visiteur/img/book.png">
                </a>
                <p>Livres</p>
            </div>
            <div class="carousel-cell">
                <a href="/visiteur/produit?categorie=Chaussures#bgdebut">
                    <img class="w3-images" src="../vue/visiteur/img/boot.png">
                </a>
                <p>Chaussures</p>
            </div>
            <div class="carousel-cell">
                <a href="/visiteur/produit?categorie=Bijoux#bgdebut">
                    <img class="w3-images" src="../vue/visiteur/img/bijou.png">
                </a>
                <p>Bijoux</p>
            </div>
            <div class="carousel-cell">
                <a href="/visiteur/produit?categorie=Jeux-DVD#bgdebut">
                    <img class="w3-images" src="../vue/visiteur/img/jeu.png">
                </a>
                <p>Jeux/DVD</p>
            </div>
            <div class="carousel-cell">
                <a href="/visiteur/produit?categorie=Logiciels#bgdebut">
                    <img class="w3-images" src="../vue/visiteur/img/logiciel.png">
                </a>

                <p>Logiciels</p>
            </div>
        </div>
    </div>
</div>
<?php } ?>

    <?php 
$categorie=isset($_GET['categorie']) ? ($_GET['categorie']):null;
$tab_cat = array('Vêtements','Informatique','Livres','Chaussures','Bijoux','Jeux-DVD','Logiciels');
if(!is_null($categorie)){
    if(in_array($categorie,$tab_cat)){
        appelCategories($categorie);
    }else{
        
    echo '<div class="basAccueil">';
        echo '<h1>La catégorie recherchée n\'existe pas</h1>';
        
    echo '</div>';
    }
}
?>

<?php

function appelCategories($categorie) {
    $produits=array();
    require_once('./modele/visiteur/visiteurBD.php');
    $produits=recupProduitsCateg($produits,$categorie);
    //var_dump($produits);
    echo '<div class="basAccueil">';
        echo '<h1>Explorez les produits de la catégorie '.$categorie.'</h1>';
        $nb_ele_accueil = 2;
        $nb_products=sizeof($produits);
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
        echo '<div id="pagination">';
            echo '<div class="menuPagesBas">';
                $page = $page_souhaite;
                if($page>1){
                    echo "<li><a href='?categorie=".$categorie."&page=".($page-1)."#pagination' >Precedent</a></li>";
                }
                if($page<$nb_page_accueil){
                    echo "<li><a href='?categorie=".$categorie."&page=".($page+1)."#pagination' >Suivant</a></li>";
                }
            echo '</div>';
            echo '<div class="menuPages">';
                for($x=1;$x<=$nb_page_accueil;$x++){
                    echo "<a href='?categorie=".$categorie."&page=$x#pagination' selected>$x</a>";
                }
            echo '</div>';
            echo '<div class="allProducts">';
             for($i =$debut; $i<$fin;$i++){
                $image = $produits[$i]['image'];
                // image path, convertir en base64
                $imageData = base64_encode($image);
                // Formatimage 
                $src = 'data: image/jpeg;base64,'.$imageData;
                echo '<div class="eachProduct">';
                echo '<div class="eachProductPlace">';
                echo '<form action="/visiteur/produit#choiceProduct" method="post">';
                echo '<img src="'.$src.'">';
                echo '<div>';
                echo '<p class="titreProd">'.$produits[$i]['NomProduit'].'</p>';
                echo '<p class="prixProd">'.$produits[$i]['PrixProduit']."€";'</p>';
                echo '<p class="vendeurProd">Vendu par '.$produits[$i]['utilisateur']['nom']." ".$produits[$i]['utilisateur']['prenom'];'</p><br>';
                echo '</div>';
                echo '<input id="monId" type="hidden" name="produit" value='.$produits[$i]['idProduit'].'>';
                echo '<input  class="formProd" type="submit" value="Voir le produit">';
                echo '</form>';
                echo '</div>';
                echo '</div>';
             }   
            echo '</div>';
            echo '<div class="menuPagesBas">';
            if($page>1){
                    echo "<li><a href='?categorie=".$categorie."&page=".($page-1)."#pagination' >Precedent</a></li>";
                }
                if($page<$nb_page_accueil){
                    echo "<li><a href='?categorie=".$categorie."&page=".($page+1)."#pagination' >Suivant</a></li>";
                }
            echo '<p class="infoPage">Page '.$page.'</p>';
            
            echo '</div>';
        echo '</div>';
        

    echo '</div>';
}

?>

<?php if (count($_POST) != 0) {
    echo '<div id="choiceProduct">';
        $image = $this->contentArray[0]['image'];
        //image path, convertir en base64
        $imageData = base64_encode($image);
        // Formatimage 
        $src = 'data: image/jpeg;base64,'.$imageData;

        echo '<div class="productChosen">';
            echo '<form class="formProduit" action="/visiteur/ajoutPanier" method="post">';
            echo '<div class="img-hover-zoom">';
            echo '<img src="'.$src.'">';
            echo '</div>';
            echo '<div class="infosProduit">';
            echo '<p class="titreProd">'.$this->contentArray[0]['NomProduit'].'</p>';
            echo '<p class="categProd">Catégorie : '.$this->contentArray[0]['Categorie'];'</p>';
            echo '<p class="prixProd"><span>Prix du produit : </span>'.$this->contentArray[0]['PrixProduit']."€";'</p>';
            echo '<p class="vendeurProd">Vendu par '.$this->contentArray[0]['utilisateur']['nom']." ".$this->contentArray[0]['utilisateur']['prenom'];'</p><br>';
            echo '<div>';
            echo '<p class="descProd"><span>Description : </span>'.$this->contentArray[0]['Description'];'</p>';
            echo '</div>';
            echo '<input id="monId" type="hidden" name="produit" value='.$this->contentArray[0]['idProduit'].'>';
            echo '<input  class="formProd" type="submit" value="Ajouter au panier">';
            echo '</div>';
            echo '</form>';
            echo '</div>';

        echo '</div>';
} ?>