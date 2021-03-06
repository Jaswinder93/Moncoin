<?php
    $this->t = "Identification";
?>

<?php if(!is_null($this->msg)){?>
<p style="width:80%;text-align:center;padding:4px;margin-top:5%;margin-left:10%;border:1px solid black; background-color:rgb(255, 60, 0)"><?=$this->msg; ?></p>
<?php } ?>

<section id="contenuIdentification">
    <div class="containerIdentification">
        <div class="identification">
            <img src="../vue/visiteur/img/login.png" alt="login" />
            <h1>Identification</h1>
            <form class="formIdentification" action="verificationIdent" method="post">
                <div class="row">
                    <div class="col-25">
                        <label for="login">Login :</label>
                    </div>
                    <div class="col-75">
                        <input type="text" name="login" placeholder="entrez votre login" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-25">
                        <label for="password">Password :</label>
                    </div>
                    <div class="col-75">
                        <input id="mypass" type="password" name="password" placeholder="entrez votre mot de passe" required>
                        <div class="eye"><i class="far fa-eye one"></i><i class="fas fa-eye-slash one"></i></div>
                    </div>
                </div>
                <input type="submit" name="valider" placeholder="Valider">
            </form>
            <div class="row">
                    <a class="mdpforget" href="/visiteur/password"> Mot de passe oublié ?</a>
            
                    <p style="color:rgb(158, 4, 4);">
                        <?=$this->msgError; ?>
                    </p>
            </div>
        </div>

    </div>
    
</section>