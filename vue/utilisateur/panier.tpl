<?php
    $this->t = "Mon Panier";
?>

<?php

$nb_panier= sizeof($this->contentArray);
?>

<div id="panierGestionnaire">
    <h2>Mon panier</h2>
    <a class="consultProd" href="/administrateur/produit">Chercher des produits</a>
    <table class="tabGestion">
        <thead>
            <tr>
                <th>Nom Produit</th>
                <th>Prix Produit</th>
                <th>Quantité choisie</th>
                <th colspan="3">Edition</th>
            </tr>
        </thead>
        <tbody>
            <?php for($i =0; $i< $nb_panier;$i++){
            ?>
            <tr>
                <td>
                    <?=$this->contentArray[$i]['NomProduit'];?>
                </td>

                <td>
                    <?=$this->contentArray[$i]['PrixProduit'];?> €
                </td>
                <td>
                    <?=$this->contentArray[$i]['nbProduits'];?>
                </td>
                <td><a href="/administrateur/panier?ind=<?php echo $i;?>#menuVoirProd"><i class="far fa-eye"></i></a>
                </td>
                <td><a href="/administrateur/panier?ind=<?php echo $i;?>#menuDeletePanier"><i
                            class="fas fa-trash-alt"></i></a></td>
            </tr>
            <?php }?>
        </tbody>
    </table>
    <?php
    if(count($this->contentArray)>0){?>
    
    <div class="btnPanier">
    <a class="btnCancelAll" href="/administrateur/viderPanier">Annuler mon panier</a>
        <a class="btnCmd" href="/administrateur/panier#MaCommande">Commander les produits</a>
    </div>
    <?php }
    ?>


</div>

<div id="MaCommande" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/panier" class="closebtn">×</a>
            <div>
                <h2>Paiement de la commande</h2>

                <p>Récapitulatif de la commande</p>
                
                <form class="formInformationsAdd" action="ajoutCommande" method="post">
                <?php 
                $prix_depart=floatval(0);
                for($i =0; $i< $nb_panier;$i++) {
                    $prix_depart += (floatval($this->contentArray[$i]['PrixProduit']))*intval($this->contentArray[$i]['nbProduits']); 

                ?>
                <div>
                <label for="totalPrice">Nom produit <?=$i+1;?> :</label>
                <input name="nameProduct[]" value="<?php echo $this->contentArray[$i]['NomProduit'];?>" readonly><br>
                <input type="hidden" name="qteDispo[]" value="<?php echo $this->contentArray[$i]['QteProduit'];?>" readonly><br>
                <input type="hidden" name="qteProduct[]" value="<?php echo $this->contentArray[$i]['nbProduits'];?>" readonly><br>
                <input type="hidden" name="idProduct[]" value="<?php echo $this->contentArray[$i]['idProduit'];?>" readonly><br>
                
                </div>

                <?php } 
                ?>
                <div>
                <div>
                    <label for="totalPrice">Prix Total :</label>
                    <input name="totalPrice" value="<?php echo $prix_depart;?>" readonly><br>
                </div>
                <div>
                            <input id="cmdValid" type="submit" value="Confirmer la commande">
                        </div>
                    </form>
            </div>
            </div>
        </div>
    </div>
</div>


<div id="menuDeletePanier" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/panier" class="closebtn">×</a>
            <div>
                <h2>Delete</h2>
                <?php
                if(isset($_GET['ind'])){
                    $prod=array();
                    if(isset($this->contentArray[$_GET['ind']])){
                    $prod=$this->contentArray[$_GET['ind']];
                         ?>
                <div>
                    <p>Confirmation de suppression ?</p>
                </div>
                <div>
                    <form class="formInformationsAdd" action="deleteFromPanier" method="post">
                        <div>
                            <label for="id">id Produit :</label>
                            <input name="idProduit" value="<?php echo $prod['idProduit'];?>" readonly><br>
                        </div>
                        <div>
                            <label for="nom">Nom Produit :</label>
                            <input value="<?php echo $prod['NomProduit'];?>" readonly><br>
                        </div>
                        
                        <input type="hidden" name="quantite" value="<?php echo $prod['nbProduits'];?>" readonly><br>
                        <input type="hidden" name="totalQuantite" value="<?php echo $prod['QteProduit'];?>" readonly><br>
             
                        <div>
                            <input id="suppressBtn" type="submit" value="Confirmer la suppression">
                        </div>
                    </form>
                </div>

                <?php
                         }else echo "<p>Veuillez choisir un utilisateur !</p>";
                     }else echo "<p>Veuillez choisir un utilisateur !</p>";
                 ?>
            </div>
        </div>
    </div>
</div>

<div id="menuVoirProd" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/panier" class="closebtn">×</a>
            <h2>Consultation produit</h2>
            <?php
           if(isset($_GET['ind'])){
                    $prod=array();
                    if(isset($this->contentArray[$_GET['ind']])){
                    $prod=$this->contentArray[$_GET['ind']];
                    $image = $prod['image'];
                    //image path, convertir en base64
                    $imageData = base64_encode($image);
                    // Formatimage 
                    $src = 'data: image/jpeg;base64,'.$imageData;
                echo '<div class="formulaireVoirProd">';
                echo '<form id="formVuProd" action="/administrateur/produit#choiceProduct" method="post">';
                echo '<div class="infoVuProd">';
                echo '<div>';
                echo '<img src="'.$src.'">';
                echo '<div>';
                echo '</div>';
                echo '<p class="titreProd">'.$prod['NomProduit'].'</p>';
                echo '<p class="prixProd">'.$prod['PrixProduit']."€";'</p>'; 
                echo '<p style="color:green">Disponible en stock : '.$prod['QteProduit'].'</p>';
                echo '<input id="monId" type="hidden" name="produit" value='.$prod['idProduit'].'>';
                echo '</div>';
                echo '</div>';
                echo '<input  id="formVuProdVoir" type="submit" value="Voir le produit">';
                echo '</form>';
                echo '</div>';
                    }else echo "<p>Veuillez choisir un utilisateur !</p>";
                }else echo "<p>Veuillez choisir un utilisateur !</p>";
            ?>
        </div>
    </div>
</div>