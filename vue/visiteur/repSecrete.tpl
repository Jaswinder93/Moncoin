<?php
    $this->t = "Réponse secrète";
?>

<section id="containMotDePasse">

    <div class="containerMotDePasse">
        <div class="motDePasse">
            <h1>Mot de passe oublié</h1>
            <form class="formMotDePasse" action="verifRepSec" method="post">
                <div class="row">
                    <div class="col-25">
                        <label for="login">Votre login* :</label>
                    </div>
                    <div class="col-75">
                        <input type="login" name="login" minlength="6" maxlength="40" visible="false"
                            value="<?php echo $_POST['login'];?>" readonly>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="questSec">Votre question secrète :</label>
                    </div>
                    <div class="col-75">
                        <label style="color:green;" ="questSec"><?=$this->contentArray['questionSecrete'];?></label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="repSec">Votre réponse secrète :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" name="repSec" placeholder="entrez votre réponse secrète" required>
                    </div>
                </div>
                <input type="submit" name="valider" placeholder="Valider">
            </form>
            <div class="row">
                <p style="color:red;">
                    <?=$this->msgError;
                    ?>
                </p>
            </div>
        </div>
    </div>
</section>