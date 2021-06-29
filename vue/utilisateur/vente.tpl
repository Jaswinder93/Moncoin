<?php
    $this->t = "Mes ventes";
?>

<?php

    $nb_vente= sizeof($this->contentArray);
?>

<div id="sellGestionnaire">
    <h2>Gestion de ventes</h2>

    <p style="color:red;">
        <?=$this->msgError;
            ?>
    </p>
    <p>
        <?=$this->msg; ?>
    </p>
    <a class="addProd" href="/utilisateur/vente#menuAjoutProd">Ajouter un produit</a>


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
            <?php
            
            $qteProdCategDispo=array("Vêtements"=>0, "Informatique"=>0, "Logiciels"=>0, "Chaussures"=>0, "Jeux-DVD"=>0, "Livres"=>0, "Bijoux"=>0);
             for($i =0; $i< $nb_vente;$i++){
            $qteProdCategDispo[$this->contentArray[$i]['Categorie']]+=$this->contentArray[$i]['QteProduit'];
            ?>
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
                <td><a href="/utilisateur/vente?ind=<?php echo $i;?>#menuVoirProd"><i class="far fa-eye"></i></a>
                </td>

                <td><a href="/utilisateur/vente?ind=<?php echo $i;?>#menuProdQte"><i
                            class="fas fa-plus-circle"></i></a></td>
                <td><a href="/utilisateur/vente?ind=<?php echo $i;?>#menuProdDelete"><i
                            class="fas fa-trash-alt"></i></a></td>

            </tr>
            <?php }
            ?>
        </tbody>
    </table>
    <p class="ventesVendu">Mes ventes :</p>
    <table class="tabGestion">
        <thead>
            <tr>
                <th>Nom Produit</th>
                <th>Quantité vendu</th>
                <th>Date </th>
                <th>Montant Produit</th>

                <th>Admin</th>
                <th colspan="1">Acheteur</th>
            </tr>
        </thead>
        <?php
    $qteProdCateg=array("Vêtements"=>0, "Informatique"=>0, "Logiciels"=>0, "Chaussures"=>0, "Jeux-DVD"=>0, "Livres"=>0, "Bijoux"=>0);
    $tabProd=array();
    $argProdCateg=array("Vêtements"=>0, "Informatique"=>0, "Logiciels"=>0, "Chaussures"=>0, "Jeux-DVD"=>0, "Livres"=>0, "Bijoux"=>0);
    
    $id_commande=array();
    for($i =0; $i< $nb_vente;$i++){
        $tabProd=selectCmdProdUser($this->contentArray[$i]['idProduit']);

        foreach($tabProd as $tab){
        
        if(isset($tab)){
            $idU=$tab['idUtilisateur'];
            $idA=$tab['idAdmin'];
            $argProdCateg[$tab['Categorie']]+=($tab['qteProduit']*$tab['PrixProduit']);
            $qteProdCateg[$tab['Categorie']]+=$tab['qteProduit'];
        ?>
        <tr>
            <td>
                <?=$tab['NomProduit'];?>
            </td>

            <td>
                <?=$tab['qteProduit'];?>
            </td>
            <td><?php 
            $date= strtotime($tab['DateCommande']); 
           echo date('d-m-Y H:i', $date);?>
            </td>
            </td>
            <td>
            <?=$tab['PrixProduit'];?>€
            </td>
            </td>
                <td><a href="/utilisateur/vente?ind=<?php echo $idA;?>#menuVoir"><i class="far fa-eye"></i></a>
                
            </td>
            <td><a href="/utilisateur/vente?ind=<?php echo $idU;?>#menuVoir"><i class="far fa-eye"></i></a>
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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
     
<div style="box-shadow: rgba(0, 0, 0, 0.02) 0px 1px 3px 0px, rgba(27, 31, 35, 0.15) 0px 0px 0px 1px;width: 80%;margin-left:10%;margin-top:5%;background-color:white;">
<div style="width: 350px;margin:auto;">
    
<h3 style="width: 80%;text-decoration:underline;text-align:center;margin-left: 10%;padding:4%;">Quantité vendues par catégorie</h3>
<canvas id="graphique" width="100px" height="100px"></canvas>
<h3 style="width: 80%;text-decoration:underline;text-align:center;margin-left: 10%;padding:4%;">Bénéfices par catégories</h3>
<canvas id="graph" width="100px" height="100px"></canvas>
<h3 style="width: 80%;text-decoration:underline;text-align:center;margin-left: 10%;padding:4%;">Quantité disponible par catégorie</h3>
<canvas id="graphe" width="100px" height="100px"></canvas>
</div>
</div>
<script>
// l'identifiant est celui du canevas
var ctx = document.getElementById('graphique').getContext('2d');

var ctx2 = document.getElementById('graph').getContext('2d');

var ctx3 = document.getElementById('graphe').getContext('2d');
// création du graphique
var myChart = new Chart(ctx, {
type: 'doughnut',   // le type du graphique
data: {        // les données
    labels: ['Vêtements', 'Informatique', 'Logiciels', 'Livres', 'Chaussures',  'Jeux-DVD', 'Bijoux'],
    datasets: [{
                label: 'Quantité vendu',
                data: [<?php echo $qteProdCateg['Vêtements']; ?>, <?php echo $qteProdCateg['Informatique']; ?>,<?php echo $qteProdCateg['Logiciels']; ?>, <?php echo $qteProdCateg['Livres']; ?>, <?php echo $qteProdCateg['Chaussures']; ?>,
                <?php echo $qteProdCateg['Jeux-DVD']; ?>, <?php echo $qteProdCateg['Bijoux']; ?>], 
                backgroundColor: [
                    'rgb(255, 99, 132)',
                    'rgb(54, 162, 235)',
                    'rgb(255, 205, 86)',
                    'rgb(200, 100, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 150, 86)',
                    'rgb(35, 25, 86)',
                  ],
                  hoverOffset: 4

               }]
       }
     }
);

var myChart2 = new Chart(ctx2, {
type: 'bar',   // le type du graphique
data: {        // les données
    labels: ['Vêtements', 'Informatique', 'Logiciels', 'Livres', 'Chaussures',  'Jeux-DVD', 'Bijoux'],
    datasets: [{
                label: 'Somme reçu',
                data: [<?php echo $argProdCateg['Vêtements']; ?>, <?php echo $argProdCateg['Informatique']; ?>,<?php echo $argProdCateg['Logiciels']; ?>, <?php echo $argProdCateg['Livres']; ?>, <?php echo $argProdCateg['Chaussures']; ?>,
                <?php echo $argProdCateg['Jeux-DVD']; ?>, <?php echo $argProdCateg['Bijoux']; ?>], 
                backgroundColor: [
                    'rgb(150, 205, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 205, 86)',
                  ],
                  hoverOffset: 4

               }]
       }
     }
);


var myChart3 = new Chart(ctx3, {
type: 'polarArea',   // le type du graphique
data: {        // les données
    labels: ['Vêtements', 'Informatique', 'Logiciels', 'Livres', 'Chaussures',  'Jeux-DVD', 'Bijoux'],
    datasets: [{
                label: 'Quantité disponible',
                data: [<?php echo $qteProdCategDispo['Vêtements']; ?>, <?php echo $qteProdCategDispo['Informatique']; ?>,<?php echo $qteProdCategDispo['Logiciels']; ?>, <?php echo $qteProdCategDispo['Livres']; ?>, <?php echo $qteProdCategDispo['Chaussures']; ?>,
                <?php echo $qteProdCategDispo['Jeux-DVD']; ?>, <?php echo $qteProdCategDispo['Bijoux']; ?>],
                backgroundColor: [
                    'rgb(255, 99, 132)',
                    'rgb(54, 162, 235)',
                    'rgb(255, 205, 86)',
                    'rgb(200, 100, 86)',
                    'rgb(150, 205, 86)',
                    'rgb(150, 150, 86)',
                    'rgb(35, 25, 86)',
                  ],
                  hoverOffset: 4

               }]
       }
     }
);
</script>


<div id="menuAjoutProd" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/utilisateur/vente" class="closebtn">×</a>
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
            <a href="/utilisateur/vente" class="closebtn">×</a>
            <div>
                <h2>Modifier la quantité du produit</h2>
                <?php
                if(isset($_GET['ind'])){
                    $prod=array();
                    if(isset($this->contentArray[$_GET['ind']])){
                    $prod=$this->contentArray[$_GET['ind']];
                         ?>
                <div>
                    <form class="formInformationsAdd" action="modifQteUser" method="post">
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
            <a href="/utilisateur/vente" class="closebtn">×</a>
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
            <a href="/utilisateur/vente" class="closebtn">×</a>
            <h2>Informations</h2>
            <?php
           if(isset($_GET['ind'])){
                    $user=array();
                    $user=recupVendeurUser($_GET['ind']);
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
            <a href="/utilisateur/vente" class="closebtn">×</a>
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
                echo '<form id="formVuProd" action="/utilisateur/produit#choiceProduct" method="post">';
                echo '<div class="infoVuProd">';
                echo '<div>';
                echo '<img src="'.$src.'">';
                echo '<div/>';
                echo '<div>';
                echo '<p style="color:black;font-size:20px;text-decoration:underline;" class="titreProd">'.$prod['NomProduit'].'</p>';
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