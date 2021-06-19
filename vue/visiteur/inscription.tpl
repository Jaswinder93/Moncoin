<?php
    $this->t = "Inscription";
?>


<section id="contenuPage">
<p>
<?=$this->msg; ?>
</p>
    <div class="containerInscription">
        <div class="inscription">
            <i class="fas fa-user-plus"></i>
            <h1>Inscription</h1>
            <form class="formInscription" action="verificationInscrit" method="post">
                <div class="row">
                    <div class="col-25">
                        <label for="nom">Nom :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" name="nom" pattern="[A-Za-z-]{1,}" maxlength="40"
                            title="- seulement les lettres et les tirêts sont acceptés" placeholder="entrez votre nom"
                            autocapitalize="on" required><br>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="prenom">Prenom :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" name="prenom" pattern="[A-Za-z-]{1,}" maxlength="40"
                            title="- seulement les lettres et les tirêts sont acceptés"
                            placeholder="entrez votre prenom" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="login">Login :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" minlength="5" name="login" pattern="[a-zA-Z0-9]{1,}" maxlength="40"
                            title="- seulement les lettres et les chiffres sont acceptés" placeholder="entrez un login"
                            required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="password">Password :</label>
                    </div>
                    <div class="col-75">
                        <input id="mypass" type="password" name="password" minlength="6" maxlength="40"
                            placeholder="entrez votre mot de passe" required>
                            <div class="eye"><i class="far fa-eye one"></i><i class="fas fa-eye-slash one"></i></div>
                   
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="mail">Adresse mail :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" name="mail" maxlength="40"
                            pattern="[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+.[a-zA-Z.]{2,15}" title="xxxx@xxxxx.xxx"
                            placeholder="entrez votre adresse mail" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="questSec">Question secrète :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" minlength="2" name="questSec" maxlength="40"
                            
                            placeholder="entrez votre réponse secrète" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="repSec">Réponse secrète :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" minlength="2" name="repSec" pattern="[a-zA-Z0-9-]{1,}" maxlength="40"
                            title="- Seulement les lettres, tirêts et les chiffres sont acceptés"
                            placeholder="entrez votre réponse secrète" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="tel">Téléphone :</label>
                    </div>
                    <div class="col-75">
                        <input type="tel" minlength="10" maxlength="15" pattern="[0-9]{1,}"
                            title="format chiffres, 10 à 15" name="telephone"
                            placeholder="entrez votre numéro de téléphone" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-25">
                        <label for="adresse">Adresse :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" maxlength="48" name="adresse" placeholder="entrez votre adresse"
                            required><br>
                    </div>
                </div>
                <input type="submit" name="valider" placeholder="Valider">
            </form>
            <div class="row">
            <p style="color:rgb(158, 4, 4);">
            <?=$this->msgError; ?>
        </p>
        </div>
        </div>

    </div>

    </p>
</section>
<script>

</script>