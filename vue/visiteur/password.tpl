<?php
    $this->t = "password";
?>

<section id="containMotDePasse">

    <div class="containerMotDePasse">
        <div class="motDePasse">
            <h1>Mot de passe oublié</h1>
            <form class="formMotDePasse" action="verifMotDePasse" method="post">
                <div class="row">
                    <div class="col-25">
                        <label for="login">Votre login :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" name="login" placeholder="entrez votre login" required>
                    </div>
                </div>
                <input type="submit" name="valider" placeholder="Valider">
            </form>
            <div class="row">
                <p style="color:red;">
                    <?=$this->msgError; ?>
                </p>
            </div>
        </div>
    </div>
</section>

