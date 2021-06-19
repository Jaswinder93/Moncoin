<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Roboto:500" />
    <link rel="stylesheet" type="text/css" href="../vue/utilisateur/style/template.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>
        <?=$t ?>
    </title>
</head>

<body id="bodyPage">
    <header id="head">
    <a href="/" id="logo">
    <img src="../vue/visiteur/img/logo.png" alt="logo"/></a>
        <div id="hamburger-content">
            <nav>
                <ul>
                    <li><a href="/utilisateur/accueil">Moncoin</a></li>
                    <li><a href="#"></i></i>Produits</a></li>
                    <li><i class="fas fa-user-edit"></i>&nbsp;<a href="#"> Gestionnaire</a></li>
                    <li><i class="fas fa-cart-plus"></i>&nbsp;<a href="#">Panier</a></li>
                </ul>
            </nav>
            <a href="/utilisateur/deconnexion" class="button button-sign-out"><i class="fas fa-sign-in-alt"></i>&nbsp;<span>deconnexion</span></a>
            <a href="/utilisateur/informations" class="button button-infos"><i class="fas fa-user-plus"></i>&nbsp;<span>Mes informations</span></a>
        </div>
        <button id="hamburger-button">&#9776;</button>
        <button id="hamburger-croix">&#9587;</button>
        <div id="humburger-overlay">
            <div id="hamburger-sidebar">
                <div id="hamburger-sidebar-header"></div>
                <div id="hamburger-sidebar-body"></div>
            </div>
        </div>
    </header>
    
    <?=$content ?>
    <!-- Site footer -->
    <footer class="site-footer">
        <button id="navHeaderFooter"><i class="fas fa-arrow-up"></i></button>
        <div class="bodyFooter">
            <div class="row">
                <h3>Categories</h3>
                <ul class="footer-links">
                    <li><a href="#">Vêtements</a></li>
                    <li><a href="#">Informatique</a></li>
                    <li><a href="#">Jardinerie</a></li>
                    <li><a href="#">Chaussures</a></li>
                    <li><a href="#">Bijoux</a></li>
                </ul>
            </div>
            <div class="row">
                <h3>A propos</h3>
                <ul class="footer-links">
                    <li><a href="/">Informations sur Moncoin</a></li>
                    <li><a href="/">A venir</a></li>
                </ul>
            </div>
            <div class="row">
                <h3>Aides</h3>
                <ul class="footer-links">
                    <li><a href="/">Contact support</a></li>
                    <li><a href="/">Coordonnées entreprise</a></li>
                </ul>
            </div>
        </div>
        <div class="bodyLogo">
            <div id="logoFooter">
                <a href="/">
                    <img src="../vue/visiteur/img/logo.png" alt="logoFooter" />
                </a>
            </div>
        </div>
        
        <p id="basFooter">Copyright &copy; Jaswinder Singh | Tanguy Amiot | Zineb Chaouche</p>

    </footer>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type="text/javascript" src="../vue/utilisateur/js/template.js"></script>
</body>

</html>