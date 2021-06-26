<?php
    $this->t = "Informations";
?>
<div id="infoFooter">

<?php

$categorie=isset($_GET['info']) ? ($_GET['info']):null;
$tab_cat = array('infoMoncoin','futur','support','coordonnees');
if(!is_null($categorie)){
    if(in_array($categorie,$tab_cat)){
       echo $categorie();
    }else {header("Location:/administrateur/".$categorie);}
} else informations();
?>

</div>
<?php
function informations(){
    infoMoncoin();
    support();
    coordonnees();
    futur();
}

function infoMoncoin(){
    echo "<div id='infoMoncoin'>";
    echo "<h3>Les informations concernant Moncoin</h3>";
    echo "<h4>L'objectif de Moncoin</h4>";
    echo "<p>Moncoin, est une plateforme, qui permet aux particuliers d'acheter des produits, de vendre des produits de leurs choix.</p>";
    echo "<h4>Histoire</h4>";
    echo "<p>Cette application a été développé dans la cadre du cours 'Développement web', elle a été développé en Html/CSS/JS et PHP.</p>";
    echo "<h4>Changement de plateforme</h4>";
    echo "<p>Nous envisageons d'utliser les outils spécifiques, des frameworks, qui vont faciliter, et qui vont rendre plus rapide et dynamique le site.</p>";
    echo "</div>";
}
function futur(){
    
    echo "<div id='aVenir'>";
    echo "<h3>A venir sur le Moncoin</h3>";
    echo "<h4>Moncoin en pleine expansion</h4>";
    echo "<p>Moncoin prospère petit à petit, disponible sur le territoire nationale, nous envisageons un buisness à l'internationale</p>";
    echo "<h4>Ajout de nouvelles catégories</h4>";
    echo "<p>Nous envisageons de créer de nouvelles catégories, et de proposer aux clients d'ajouter leurs propres catégories si celles-ci n'existent pas, pour augmenter le choix des clients.</p>";
echo "<h4>Ajout de différents moyens de paiements</h4>";
    echo "<p>Mise en place de différents moyens de paiements : différents cartes de paiements, paypal etc ...</p>";
    echo "</div>";
}

function support(){
    
    echo "<div id='support'>";
    echo "<h3>Support</h3>";
    
    echo "<h4>Perte de mot de passe ?</h4>";
    
    echo "<p>En cas d'oubli ou de perte de votre mot de passe, vous pouvez accéder au formulaire de connexion, et créer un nouvel mot de passe en faisant mot de passe oublié.</p>";
    echo "<h4>Problème de commande ?</h4>";
    echo '<p>Vous pouvez contacter l\'entreprise pour être mis en relation avec le vendeur : <a href="/administrateur/footer?info=coordonnees">Coordonnées entreprise</a></p>';
    echo "<h4>Autre problème :</h4>";
    echo '<p>Pour tout autre soucis vous pouvez contacter l\'administrateur du site, ou l\'entreprise : <a href="/administrateur/footer?info=coordonnees">Coordonnées entreprise</a></p>';
    echo "</div>";
}
function coordonnees(){
    echo "<div id='contacts'>";
    
    echo "<h3>Contacts</h3>";
    echo "<h4>Contact administrateur site</h4>";
    echo "<p>administrateur@moncoin.com</p>";
    echo "<h4>Adresse entreprise</h4>";
    echo "<p>110 rue Imaginaire, 75016 Paris</p>";
    echo "<h4>Numéro de contact</h4>";
    echo "<p>Numéro : <a href='tel:+33611111111'>Appelez-ici !</a>";
    echo "</div>";
}
?>