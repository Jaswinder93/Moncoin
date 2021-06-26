<?php
use \Exception as Exception;
class Router{

    private $controle;
    private $action;
    public function reqRoute(){

    try{
            if (isset($_GET['controle']) & isset($_GET['action'])) {
                $controle = $_GET['controle'];
                if($controle=='visiteur'){
                    
                    $_SESSION['profil'] = array();
                    }
                $action= $_GET['action'];
            }
            else { //absence de paramètres : prévoir des valeurs par défaut
                
                $controle = isset($_SESSION['profil']['typeUtilisateur'])?$_SESSION['profil']['typeUtilisateur']:'visiteur';
                $action= "accueil";
            }

            $fileController = "controle/".$controle.".php";
            if(file_exists($fileController)){
                require_once($fileController);
            }
            else{
                throw new Exception('Page introuvable');
            }
            if(function_exists($action)){
                    $action();
            }else throw new Exception('Page non existante');
             
    }
    catch(Exception $e){
        $msgError = $e->getMessage();
        require_once("controle/erreur.php");
        erreur($msgError);
      }
    }

}
?>