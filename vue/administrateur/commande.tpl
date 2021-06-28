<?php
    $this->t = "Mes commandes";
?>
<?php

$nb_c= sizeof($this->contentArray);
?>

<div id="CommandeGestionnaire">
    <h2>Mes commandes</h2>
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
                <th>Id commande</th>
                <th>Etat commande</th>
                <th>Montant</th>
                <th>Date</th>
                <th colspan="1">Actions</th>
            </tr>
        </thead>
        <tbody>
            <?php for($i =0; $i< $nb_c;$i++){
            ?>
            <tr>
                <td>
                    <?=$this->contentArray[$i]['idCommande'];?>
                </td>

                <td>
                    <?=$this->contentArray[$i]['EtatCommande'];?>
                </td>
                <td>
                    <?=$this->contentArray[$i]['MontantCommande'];?> €
                </td>
                <td><?php 
                      $date= strtotime($this->contentArray[$i]['DateCommande']); 
                     echo date('d-m-Y H:i', $date);?>
                </td>
                <td><a href="/administrateur/commande?ind=<?php echo $i;?>#menuVoirCmd"><i class="far fa-eye"></i></a>
                </td>

            </tr>
            <?php }?>
        </tbody>
    </table>

</div>

<div id="menuVoirCmd" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/commande" class="closebtn">×</a>
            <h2>Consultation de mes commandes</h2>

            <?php
            $cmd=array();
            if(isset($this->contentArray[$_GET['ind']])){
            $cmd=$this->contentArray[$_GET['ind']];
            $tabProd=array();
            $tabProd=selecProdCmd($cmd['idCommande']);
            for($i=0;$i<count($tabProd);$i++){
                $image = $tabProd[$i]['image'];
                //image path, convertir en base64
                $imageData = base64_encode($image);
                // Formatimage 
                $src = 'data: image/jpeg;base64,'.$imageData;
                echo '<div class="produitCmd">';
                echo '<div>';
                echo '<img src="'.$src.'">';
                echo '</div>';
                echo '<div>';
                echo '<p class="titre">'.$tabProd[$i]['NomProduit'].'</p>';
                echo '<p class="info">Catégorie : '.$tabProd[$i]['Categorie'].'</p>';
                echo '<p class="info">Prix Unitaire : '.$tabProd[$i]['PrixProduit'].'€</p>';
                echo '<p class="info">Description: '.$tabProd[$i]['Description'].'</p>';
               
                echo '<p class="info">Vous en avez commandé : '.$tabProd[$i]['qteProduit'].'</p>';
                echo '</div>';
                echo '</div>';
            }
            }
            ?>
        </div>
    </div>
</div>