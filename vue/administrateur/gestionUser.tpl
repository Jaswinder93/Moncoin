<?php
$this->t = "Gestionnaire user";
?>

<?php

    $nb_user= sizeof($this->contentArray);
?>

<div id="userGestionnaire">
    <h2>Gestion des utilisateurs</h2>
    <a class="addUser" href="/administrateur/gestionUser#menuAjout">Ajouter un utilisateur</a>
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
                <th>id Utilisateur</th>
                <th>Nom</th>
                <th>Prenom</th>
                <th colspan="3">Edition</th>
            </tr>
        </thead>
        <tbody>
            <?php for($i =0; $i<$nb_user;$i++){
                if($this->contentArray[$i]['typeUtilisateur']=='utilisateur'){
                ?>
            <tr>
                <td>
                    <?=$this->contentArray[$i]['idUtilisateur'];?>
                </td>

                <td>
                    <?=$this->contentArray[$i]['nom'];?>
                </td>
                <td>
                    <?=$this->contentArray[$i]['prenom'];?>
                </td>
                <td><a href="/administrateur/gestionUser?ind=<?php echo $i;?>#menuVoir"><i class="far fa-eye"></i></a>
                </td>
                <td><a href="/administrateur/gestionUser?ind=<?php echo $i;?>#menuEdit"><i
                            class="fas fa-user-edit"></i></a></td>
                <td><a href="/administrateur/gestionUser?ind=<?php echo $i;?>#menuDelete"><i
                            class="fas fa-trash-alt"></i></a></td>
            </tr>
            <?php 
                }else {?>
                <tr>
                <td>
                    <?=$this->contentArray[$i]['idUtilisateur'];?>
                </td>

                <td>
                    <?=$this->contentArray[$i]['nom'];?>
                </td>
                <td>
                    <?=$this->contentArray[$i]['prenom'];?>
                </td>
                <td><a href="/administrateur/gestionUser?ind=<?php echo $i;?>#menuVoir"><i class="far fa-eye"></i></a>
                </td>
                <td style="background-color: rgb(121, 3, 3);color:white;";>Admin</td>
                <td style="background-color: rgb(116, 3, 3);color:white;";>Admin</td>
            </tr>


        <?php
                }
            }?>
        </tbody>
    </table>

</div>






<div id="menuAjout" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/gestionUser" class="closebtn">×</a>
            <h2>Ajout d'utilisateur</h2>

            <div>
                <form class="formInformationsAdd" action="ajoutUser" method="post">
                    <div>
                        <label for="nom">Nom :</label>
                        <input type="text" name="nom" pattern="[A-Za-z-]{1,}" maxlength="40"
                            title="- seulement les lettres et les tirêts sont acceptés" placeholder="entrez le nom"
                            autocapitalize="on" required><br>
                    </div>
                    <div>
                        <label for="prenom">Prénom :</label>
                        <input type="text" name="prenom" pattern="[A-Za-z-]{1,}" maxlength="40"
                            title="- seulement les lettres et les tirêts sont acceptés" placeholder="entrez le prenom"
                            required>
                    </div>
                    <div>
                        <label for="login">Login :</label>
                        <input type="text" minlength="5" name="login" pattern="[a-zA-Z0-9]{1,}" maxlength="40"
                            title="- seulement les lettres et les chiffres sont acceptés" placeholder="entrez le login"
                            required>
                    </div>
                    <div>
                        <label for="password">Password :</label>
                        <input id="mypass" type="password" name="password" minlength="6" maxlength="40"
                            placeholder="entrez le mot de passe" required>
                    </div>

                    <div>
                        <label for="mail">Adresse mail :</label>
                        <input type="text" name="mail" maxlength="40"
                        pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="xxxx@xxxxx.xxx"
                            placeholder="entrez l'adresse mail" required>
                    </div>
                    <div>
                        <label for="questSec">Question secrète :</label>
                        <input type="text" minlength="5" name="questSec" maxlength="40"
                            placeholder="entrez la question secrète" required>
                    </div>
                    <div>
                        <label for="repSec">Réponse secrète :</label>

                        <input type="text" minlength="5" name="repSec" maxlength="40"
                            placeholder="entrez la réponse secrète" required>
                    </div>
                    <div>
                        <label for="tel">Téléphone :</label>
                        <input type="tel" minlength="10" maxlength="15" pattern="[0-9]{1,}"
                            title="format chiffres, 10 à 15" name="telephone"
                            placeholder="entrez votre numéro de téléphone" required>
                    </div>
                    <div>
                        <label for="adresse">Adresse :</label>
                        <input type="text" maxlength="48" name="adresse" placeholder="entrez votre adresse" required>
                    </div>
                    <div>
                        <input id="addUserBtn" type="submit" value="Ajouter l'utilisateur">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<div id="menuVoir" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/gestionUser" class="closebtn">×</a>
            <h2>Informations utilisateur</h2>
            <?php
           if(isset($_GET['ind'])){
                    $user=array();
                    if(isset($this->contentArray[$_GET['ind']])){
                    $user=$this->contentArray[$_GET['ind']];
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
                        <label for="login">Login :</label>
                        <input value="<?php echo $user['login'];?>" readonly>
                    </div>
                    <div>
                        <label for="password">Password :</label>
                        <input value="<?php echo $user['password'];?>" readonly>
                    </div>

                    <div>
                        <label for="mail">Adresse mail :</label>
                        <input value="<?php echo $user['mail'];?>" readonly>
                    </div>
                    <div>
                        <label for="questSec">Question secrète :</label>
                        <input value="<?php echo $user['questionSecrete'];?>" readonly>
                    </div>
                    <div>
                        <label for="repSec">Réponse secrète :</label>

                        <input value="<?php echo $user['reponseSecrete'];?>" readonly>
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


<div id="menuDelete" class="modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <a href="/administrateur/gestionUser" class="closebtn">×</a>
            <div>
                <h2>Delete</h2>
                <?php
                if(isset($_GET['ind'])){
                         $user=array();
                         if(isset($this->contentArray[$_GET['ind']])){
                         $user=$this->contentArray[$_GET['ind']];
                         ?>
                <div>
                    <p>Confirmation de suppression ?</p>
                </div>

                <div>
                    <form class="formInformationsAdd" action="deleteUser" method="post">
                        <div>
                            <label for="nom">Mon nom :</label>
                            <input value="<?php echo $user['nom'];?>" readonly><br>
                        </div>
                        <div>
                            <label for="prenom">Mon prénom :</label>
                            <input value="<?php echo $user['prenom'];?>" readonly>
                        </div>
                        <div>
                            <label for="login">Login :</label>
                            <input type="text" name="login" value="<?php echo $user['login'];?>" readonly>
                        </div>
                        <div>
                            <label for="password">Password :</label>
                            <input value="<?php echo $user['password'];?>" readonly>
                        </div>

                        <div>
                            <label for="mail">Adresse mail :</label>
                            <input value="<?php echo $user['mail'];?>" readonly>
                        </div>
                        <div>
                            <label for="questSec">Question secrète :</label>
                            <input value="<?php echo $user['questionSecrete'];?>" readonly>
                        </div>
                        <div>
                            <label for="repSec">Réponse secrète :</label>

                            <input value="<?php echo $user['reponseSecrete'];?>" readonly>
                        </div>
                        <div>
                            <label for="tel">Téléphone :</label>
                            <input value="<?php echo $user['tel'];?>" readonly>
                        </div>
                        <div>
                            <label for="adresse">Adresse :</label>
                            <input value="<?php echo $user['adresse'];?>" readonly>
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
            <a href="/administrateur/gestionUser" class="closebtn">×</a>
            <h2>Edition d'utilisateur</h2>

            <?php
            if(isset($_GET['ind'])){
                     $user=array();
                     if(isset($this->contentArray[$_GET['ind']])){
                     $user=$this->contentArray[$_GET['ind']];
                     ?>
            <div>
                <form class="formInformationsAdd" action="editUser" method="post">
                    <div>
                        <label for="id">Identifiant :</label>
                        <input style="background-color:grey" ="id" type="text" name="id" value="<?php echo $user['idUtilisateur']; ?>" readonly><br>
                    </div>
                    
                    <div>
                        <label for="login">Login :</label>
                        <input style="background-color:grey" type="text" minlength="5" name="login" value="<?php echo $user['login']; ?>" readonly>
                    </div>
                    <div>
                        <label for="nom">Nom :</label>
                        <input id="nameInfo" type="text" name="nom" pattern="[A-Za-z-]{1,}" maxlength="40"
                            title="- seulement les lettres et les tirêts sont acceptés"
                            value="<?php echo $user['nom']; ?>"><br>
                    </div>
                    <div>
                        <label for="prenom">Prénom :</label>
                        <input id="prenomInfo" type="text" name="prenom" pattern="[A-Za-z-]{1,}" maxlength="40"
                            title="- seulement les lettres et les tirêts sont acceptés"
                            value="<?php echo $user['prenom']; ?>"><br>
                    </div>
                    <div>
                        <label for="mail">Adresse mail :</label>
                        <input type="text" name="mail" maxlength="40"
                        pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="xxxx@xxxxx.xxx"
                            value="<?php echo $user['mail']; ?>" required>
                    </div>
                    <div>
                        <label for="questSec">Question secrète :</label>
                        <input type="text" minlength="5" name="questSec" maxlength="40"
                            value="<?php echo $user['questionSecrete']; ?>" required>
                    </div>
                    <div>
                        <label for="repSec">Réponse secrète :</label>

                        <input type="text" minlength="5" name="repSec" maxlength="40"
                            value="<?php echo $user['reponseSecrete']; ?>" required>
                    </div>
                    <div>
                        <label for="tel">Téléphone :</label>
                        <input type="tel" minlength="10" maxlength="15" pattern="[0-9]{1,}"
                            title="format chiffres, 10 à 15" name="telephone" value="<?php echo $user['tel']; ?>"
                            required>
                    </div>
                    <div>
                        <label for="adresse">Adresse :</label>
                        <input type="text" maxlength="48" name="adresse" value="<?php echo $user['adresse']; ?>"
                            required>
                    </div>
                    <div>
                        <input id="modifBtn" type="submit" value="Confirmer le changement">
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