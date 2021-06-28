<?php
    $this->t = "Mes ventes";
?>

<?php

    $nb_vente= sizeof($this->contentArray);
?>

<div id="sellGestionnaire">
    <h2>Gestions des vente</h2>

    <p style="color:red;">
        <?=$this->msgError;
            ?>
    </p>
    <p>
        <?=$this->msg; ?>
    </p>
    <a class="addProd" href="/administrateur/vente#menuAjoutProd">Ajouter un produit</a>


    <p class="venteCours">Mes produits en cours :</p>
    <table class="tabGestion">
        <thead>
            <tr>
                <th>Nom Produit</th>
                <th>Prix</th>
                <th>Quantité disponible </th>
                <th>Catégorie </th>
                <th colspan="3">Edition</th>
            </tr>
        </thead>
        <tbody>
            <?php for($i =0; $i< $nb_vente;$i++){?>
            <tr>
                <td>
                    <?=$this->contentArray[$i]['NomProduit'];?>
                </td>

                <td>
                    <?=$this->contentArray[$i]['PrixProduit'];?> €
                </td>
                <td>
                    <?=$this->contentArray[$i]['QteProduit'];?>
                </td>
                <td>
                    <?=$this->contentArray[$i]['Categorie'];?>
                </td>
                <td><a href="/administrateur/vente?ind=<?php echo $i;?>#menuVoirProd"><i class="far fa-eye"></i></a>
                </td>

                <td><a href="/administrateur/vente?ind=<?php echo $i;?>#menuProdQte"><i
                            class="fas fa-plus-circle"></i></a></td>
                <td><a href="/administrateur/vente?ind=<?php echo $i;?>#menuProdDelete"><i
                            class="fas fa-trash-alt"></i></a></td>

            </tr>
            <?php }?>
        </tbody>
    </table>
    <p class="ventesVendu">Mes ventes :</p>
    <table class="tabGestion">
        <thead>
            <tr>
                <th>Nom Produit</th>
                <th>Quantité vendu</th>
                <th>Date </th>
                <th>Montant </th>

                <th>Acheteur</th>
                <th colspan="1">Actions</th>
            </tr>
        </thead>
        <?php

    $tabProd=array();
    $id_commande=array();
    for($i =0; $i< $nb_vente;$i++){
        $tabProd=selectCmdProd($this->contentArray[$i]['idProduit']);

        foreach($tabProd as $tab){
        if(isset($tab)){
            $idU=$tab['idUtilisateur'];
        ?>
        <tr>
            <td>
                <?=$tab['NomProduit'];?>
            </td>

            <td>
                <?=$tab['qteProduit'];?>
            </td>
            <td>
            <td><?php 
            $date= strtotime($tab['DateCommande']); 
           echo date('d-m-Y H:i', $date);?>
            </td>
            </td>
            <td>
                <?=$tab['MontantCommande'];?>€
            </td>
            <td>
                <?=$tab['idUtilisateur'];?>
            </td>
            <td><a href="/administrateur/vente?ind=<?php echo $idU;?>#menuVoir"><i class="far fa-eye"></i></a>
            </td>

        </tr>
        <?php
        } else echo "rien";
        }
        $tabProd=array();
    }
    ?>
        </tbody>
    </table>
</div>



<div id="menuAjoutProd" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/vente" class="closebtn">×</a>
            <h2>Ajout de produit</h2>
            <div>
                <form class="formInformationsAdd" action="ajoutProd" method="post" enctype="multipart/form-data">
                    <div>
                        <label for="nom">Nom du produit:</label>
                        <input type="text" name="nom" maxlength="40"
                            title="- seulement les lettres et les tirêts sont acceptés" placeholder="entrez le nom"
                            autocapitalize="on" required><br>
                    </div>
                    <div>
                        <label for="Prix">Prix produit :</label>
                        <input type="number" name="prix" placeholder="1.0 €" step="0.01" min="0" max="1000000" required>
                    </div>
                    <div>
                        <label for="Prix">Quantité :</label>
                        <input type="number" name="quantite" placeholder="1" min="0" max="10000" required>
                    </div>
                    <div>
                        <label for="categorie">Catégorie :</label>
                        <select name='categorie' id="categorie" required>
                            <option value=''>--- Choix catégorie ---</option>
                            <option value='Vêtements' name='vetement'>Vêtements</option>
                            <option value='Informatique' name='informatique'>Informatique</option>
                            <option value='Livres' name='livre'>Livres</option>
                            <option value='Chaussures' name='chaussure'>Chaussures</option>
                            <option value='Bijoux' name='bijou'>Bijoux</option>
                            <option value='Jeux-DVD' name='jeu-dvd'>Jeux-DVD</option>
                            <option value='Logiciels' name='logiciel'>Logiciels</option>
                        </select>
                    </div>
                    <div>
                        <label for="desc">Description :</label>
                        <textarea name="description" value="" cols="40" rows=7 required></textarea>
                    </div>
                    <div>
                        <label for="imgProd">Image :</label>

                        <input type="file" accept=".jpg, .jpeg, .png" name="imgProd" required>
                    </div>
                    <div>
                        <input id="ajtProdBtn" type="submit" value="Ajouter">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<div id="menuProdQte" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/vente" class="closebtn">×</a>
            <div>
                <h2>Modifier la quantité du produit</h2>
                <?php
                if(isset($_GET['ind'])){
                    $prod=array();
                    if(isset($this->contentArray[$_GET['ind']])){
                    $prod=$this->contentArray[$_GET['ind']];
                         ?>
                <div>
                    <form class="formInformationsAdd" action="modifQte" method="post">
                        <div>
                            <label for="id">id Produit :</label>
                            <input name="id" value="<?php echo $prod['idProduit'];?>" readonly><br>
                        </div>
                        <div>
                            <label for="nom">Nom Produit :</label>
                            <input value="<?php echo $prod['NomProduit'];?>" readonly><br>
                        </div>
                        <div>
                            <label for="qte">Quantité actuelle :</label>
                            <input name="QteProduit" value="<?php echo $prod['QteProduit'];?>" readonly><br>
                        </div>
                        <div>
                            <label for="newQte">Nouvelle quantité :</label>
                            <input type='number' name="newQte" min="0" max="10000" required><br>
                        </div>
                        <div>
                            <input id="modifyQte" type="submit" value="Modifier la quantité">
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


<div id="menuProdDelete" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/vente" class="closebtn">×</a>
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
                    <form class="formInformationsAdd" action="deleteProduct" method="post">
                        <div>
                            <label for="id">id Produit :</label>
                            <input name="id" value="<?php echo $prod['idProduit'];?>" readonly><br>
                        </div>
                        <div>
                            <label for="nom">Nom Produit :</label>
                            <input value="<?php echo $prod['NomProduit'];?>" readonly><br>
                        </div>
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


<div id="menuVoir" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/vente" class="closebtn">×</a>
            <h2>Informations acheteur</h2>
            <?php
           if(isset($_GET['ind'])){
                    $user=array();
                    $user=recupVendeurAd($_GET['ind']);
                    if(!empty($user)){
                    ?>
            <div>
                <form class="formInformationsAdd">
                    <div>
                        <label for="nom">Nom :</label>
                        <input value="<?php echo $user['nom'];?>" readonly><br>
                    </div>
                    <div>
                        <label for="prenom">Prénom :</label>
                        <input value="<?php echo $user['prenom'];?>" readonly>
                    </div>
                    <div>
                        <label for="mail">Adresse mail :</label>
                        <input value="<?php echo $user['mail'];?>" readonly>
                    </div>
                    <div>
                        <label for="tel">Téléphone :</label>
                        <input value="<?php echo $user['tel'];?>" readonly>
                    </div>
                    <div>
                        <label for="adresse">Adresse :</label>
                        <input value="<?php echo $user['adresse'];?>" readonly>
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

<div id="menuVoirProd" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/vente" class="closebtn">×</a>
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
                echo '<div/>';
                echo '<div>';
                echo '<p class="titreProd">'.$prod['NomProduit'].'</p>';
                echo '<p class="prixProd">'.$prod['PrixProduit']."€";'</p>'; 
                echo '<p style="color:green">Disponible en stock : '.$prod['QteProduit'].'</p>';
                echo '<p class="vendeurProd">Vendu par '.$_SESSION['profil']['nom']." ".$_SESSION['profil']['prenom'];'</p><br>';

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