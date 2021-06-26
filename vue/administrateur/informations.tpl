<?php
    $this->t = "Informations personnels";
?>
<?php
$dateInsc= strtotime($_SESSION['profil']['dateInscription']);

?>
<div id="informationsPersonnels">
    <div class="classInformationsPersonnels">
        <h1>Mes informations</h1>
        <p>Vous êtes inscrit depuis le
            <?=date('d-m-Y', $dateInsc);?>
            <p style="color:green;">
            <?=$this->msg; ?>
            </p>
        <form class="formInformationsPersonnels" action="changeInformation" method="post">
            <div>
                <label for="nom">Mon nom :</label>
                <input id="nameInfo" type="text" name="nom" pattern="[A-Za-z-]{1,}" maxlength="40"
                    title="- seulement les lettres et les tirêts sont acceptés"
                    value="<?php echo $_SESSION['profil']['nom']; ?>" disabled><br>
            </div>
            <div>
                <label for="prenom">Mon prénom :</label>
                <input id="prenomInfo" type="text" name="prenom" pattern="[A-Za-z-]{1,}" maxlength="40"
                    title="- seulement les lettres et les tirêts sont acceptés"
                    value="<?php echo $_SESSION['profil']['prenom']; ?>" disabled><br>
            </div>
            <div>
                <label for="mail">Adresse mail :</label>
                <input id="mailInfo" type="text" name="mail" maxlength="40"
                    pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" title="xxxx@xxxxx.xxx"
                    value="<?php echo $_SESSION['profil']['mail'];?>" disabled><br>
            </div>
            <div>
                <label for="questSec">Question secrète :</label>
                <input id="questInfo" type="text" minlength="2" name="questSec" maxlength="40"
                    value="<?php echo $_SESSION['profil']['questionSecrete'];?>" disabled><br>
            </div>
            <div>
                <label for="repSec">Réponse secrète :</label>

                <input id="repInfo" type="text" minlength="2" name="repSec" pattern="[a-zA-Z0-9-]{1,}" maxlength="40"
                    title="- Seulement les lettres, tirêts et les chiffres sont acceptés"
                    value="<?php echo $_SESSION['profil']['reponseSecrete'];?>" disabled><br>
            </div>
            <div>
                <label for="tel">Téléphone :</label>
                <input id="telInfo" type="tel" minlength="10" maxlength="15" pattern="[0-9]{1,}"
                    title="format chiffres, 10 à 15" name="telephone" value="<?php echo $_SESSION['profil']['tel'];?>"
                    disabled><br>
            </div>
            <div>
                <label for="adresse">Adresse :</label>
                <input id="adresseInfo" type="text" maxlength="48" name="adresse"
                    value="<?php echo $_SESSION['profil']['adresse'];?>" disabled><br>
            </div>
            <div>
                <input id="modifyInfo" type="button" value="Modifier mes informations">
                <input id="saveInfo" type="hidden" value="enregistrer mes informations">
            </div>
        </form>
    </div>
</div>