<?php
    $this->t = "Changement password";
?>

<section id="containChgMotDePasse">

    <div class="containerChgMotDePassee">
        <div class="motDePasse">
            <h1>Réinitialisation de mot de passe</h1>
            <form class="formChgMotDePasse" action="chgMotDePasse" method="post">
                <div class="row">
                    <div class="col-25">
                        <label for="login">Votre login* :</label>
                    </div>
                    <div class="col-75">
                        <input type="login" name="login" minlength="6" maxlength="40" visible="false" value="<?php echo $_POST['login'];?>" readonly >
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="password">Nouveau mot de passe* :</label>
                    </div>
                    <div class="col-75">
                        <input id="mypass" type="password" name="password_one" minlength="6" maxlength="40"
                            placeholder="entrez votre mot de passe" required>
                            <div class="eye"><i class="far fa-eye one"></i><i class="fas fa-eye-slash one"></i></div>
                   
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="password">Confirmation mot de passe* :</label>
                    </div>
                    <div class="col-75">
                        <input  id="mypass2" type="password" name="password_two" minlength="6" maxlength="40"
                            placeholder="entrez votre mot de passe" required>
                            <div class="eye"><i class="far fa-eye two"></i><i class="fas fa-eye-slash two"></i></div>
                   
                    </div>
        </div>
        <input type="submit" name="valider" placeholder="Valider">
        </form>
        <div class="row">
            <p style="color:red;">
                <?=$this->msgError;?>
            </p>
        </div>
    </div>
    </div>
</section>