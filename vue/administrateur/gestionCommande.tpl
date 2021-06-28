<?php
$this->t = "Gestionnaire commande";
?>

<?php

    $nb_user= sizeof($this->contentArray);
?>

<div id="userGestionnaire">
    <h2>Gestion des commandes</h2>
    <p style="color:red;">
        <?=$this->msgError;
                    ?>
    </p>
    <p>
        <?=$this->msg; ?>
    </p>


    <table class="tabGestion">
        <thead>
            <tr>
                <th>id Commande</th>
                <th>id acheteur</th>
                <th>Etat Commande</th>
                <th>Date Commande</th>
                <th colspan="2">Edition</th>
            </tr>
        </thead>
        <tbody>
            <?php for($i =0; $i<$nb_user;$i++){
            ?>
            <tr>
                <td>
                    <?=$this->contentArray[$i]['idCommande'];?>
                </td>
                <td>
                    <?=$this->contentArray[$i]['idUtilisateur'];?>
                </td>

                <td>
                    <?=$this->contentArray[$i]['EtatCommande'];?>
                </td>
                <td><?php 
                      $date= strtotime($this->contentArray[$i]['DateCommande']); 
                     echo date('d-m-Y H:i', $date);?>
                </td>
                <td><a href="/administrateur/gestionCommande?ind=<?php echo $i;?>#menuEdit"><i
                            class="fas fa-user-edit"></i></a></td>
                            
                <td><a href="/administrateur/gestionCommande?ind=<?php echo $i;?>#menuDeleteCmd"><i
                class="fas fa-trash-alt"></i></a></td>
            </tr>
            <?php }?>
        </tbody>
    </table>

</div>

<div id="menuDeleteCmd" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/gestionCommande" class="closebtn">×</a>
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
                    <form class="formInformationsAdd" action="deleteCmd" method="post">
                        <div>
                            <label for="id">id commande :</label>
                            <input name="id" value="<?php echo $prod['idCommande'];?>" readonly><br>
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

<div id="menuEdit" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/gestionCommande" class="closebtn">×</a>
            <h2>Edition d'utilisateur</h2>

            <?php
            if(isset($_GET['ind'])){
                     $cmd=array();
                     if(isset($this->contentArray[$_GET['ind']])){
                     $cmd=$this->contentArray[$_GET['ind']];
                     ?>
            <div>
                <form class="formInformationsAdd" action="editCommande" method="post">
                    <div>
                        <label for="id">Identifiant commande :</label>
                        <input style="background-color:grey"="id" type="text" name="id"
                            value="<?php echo $cmd['idCommande']; ?>" readonly><br>
                    </div>

                    <div>
                        <label for="login">Montant :</label>
                        <input style="background-color:grey" type="text" minlength="5" name="login"
                            value="<?php echo $cmd['MontantCommande']; ?>" readonly>
                    </div>
                    <div>
                        <label for="etatCmd">Catégorie :</label>
                        <select style="padding:2px;border:1px solid black;" name='etatCmd' id="categorie" required>
                            <option value=''>--- Choix etat commande ---</option>
                            <option value='en cours' name='encours'>En cours</option>
                            <option value='Expédié' name='expedie'>Expédié</option>
                            <option value='En livraison' name='enlivre'>En Livraison</option>
                            <option value='livré' name='livre'>Livré</option>
                        </select>
                    </div>
                    <input id="modifBtn" type="submit" value="Confirmer le changement">
            </div>
        </div>
        </form>
    </div>

    <?php
                     }else echo "<p>Veuillez choisir une commande !</p>";
                 }else echo "<p>Veuillez choisir une commande !</p>";
             ?>
</div>
</div>
</div>