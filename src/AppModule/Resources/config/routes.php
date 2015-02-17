<?php

use MVC\Server\Route;

return array(
    new Route(array('GET', 'POST'), '/', 'AppModule\\Controller\\AppController::index', 'app_index'),
    new Route(array('GET', 'POST'), '/learn', 'AppModule\\Controller\\AppController::learn', 'app_learn'),
);