<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="//fonts.googleapis.com/css?family=Roboto:500" />
    <link rel="stylesheet" type="text/css" href="../vue/visiteur/style/template.css" />
    <link rel="stylesheet" type="text/css" href="../vue/visiteur/style/produit.css" />
    <link rel="stylesheet" type="text/css" href="../vue/visiteur/style/footerlink.css" />
    
    <link rel="icon" type="image/png" href="../vue/visiteur/img/M.png" />
    <link rel="stylesheet" type="text/css" href="../vue/visiteur/style/formInscritIdentification.css" />
    <link rel="stylesheet" href="https://unpkg.com/flickity@2/dist/flickity.min.css">
    <link rel="stylesheet" type="text/css" href="../vue/visiteur/style/accueil.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
        integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <title>
        <?=$t ?>
    </title>
</head>

<body id="bodyPage">
    <header id="head">
        <a href="/" id="logo">

            <img src="../vue/visiteur/img/logo.png" alt="logo" />
        </a>
        <div id="hamburger-content">
            <nav >
                <ul>
                    <li><a href="/visiteur/accueil">Moncoin</a></li>
                    <li><a href="/visiteur/produit"></i></i>Produits</a></li>
                    <li><i class="fas fa-cart-plus"></i>&nbsp;<a href="/visiteur/panier">Panier</a></li>
                </ul>
            </nav>
                <a href="/visiteur/identification" class="button button-sign-in"><i
                        class="fas fa-sign-in-alt"></i>&nbsp;<span>Se connecter</span></a>
                <a href="/visiteur/inscription" class="button button-sign-up"><i
                        class="fas fa-user-plus"></i>&nbsp;<span>S'inscrire</span></a>
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
                    <li><a href="/visiteur/produit?categorie=Vêtements#bgdebut">Vêtements</a></li>
                    <li><a href="/visiteur/produit?categorie=Informatique#bgdebut">Informatique</a></li>
                    <li><a href="/visiteur/produit?categorie=Livres#bgdebut">Livres</a></li>
                    <li><a href="/visiteur/produit?categorie=Chaussures#bgdebut">Chaussures</a></li>
                    <li><a href="/visiteur/produit?categorie=Bijoux#bgdebut">Bijoux</a></li>
                    <li><a href="/visiteur/produit?categorie=Jeux-DVD#bgdebut">Jeux/DVD</a></li>
                    <li><a href="/visiteur/produit?categorie=Logiciels#bgdebut">Logiciels</a></li>
                </ul>
            </div>
            <div class="row">
                <h3>A propos</h3>
                <ul class="footer-links">
                    <li><a href="/visiteur/footer?info=infoMoncoin">Informations sur Moncoin</a></li>
                    <li><a href="/visiteur/footer?info=futur">A venir</a></li>
                </ul>
            </div>
            <div class="row">
                <h3>Aides</h3>
                <ul class="footer-links">
                    <li><a href="/visiteur/footer?info=support">Contact support</a></li>
                    <li><a href="/visiteur/footer?info=coordonnees">Coordonnées entreprise</a></li>
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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="../vue/visiteur/js/template.js"></script>
  <script src="https://unpkg.com/flickity@2/dist/flickity.pkgd.min.js"></script>

    <body>

</html>