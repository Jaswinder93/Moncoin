<?php

session_start();

require_once('controle/Router.php');
$route = new Router();
$route->reqRoute();

?>