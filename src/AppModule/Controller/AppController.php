<?php

namespace AppModule\Controller;

use MVC\Controller\Controller;
use MVC\MVC;

/**
 * Description of AppController
 *
 * @author Ramón Serrano <ramon.calle.88@gmail.com>
 */
class AppController extends Controller
{
    
    function index(MVC $mvc)
    {
        $learnUri = $mvc->urlFor('app_learn', 'route');
        return $mvc->view()->render('App/index.php', array(
            'learnUri' => $learnUri
        ));
    }
    
    function learn(MVC $mvc)
    {
        return 'AppController::learn';
    }
    
}
