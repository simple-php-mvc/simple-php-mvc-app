<?php

require_once __DIR__ . '/../app/autoload.php';

$mvc = new AppMVC(array(
    'debug' => false
));

$mvc->run();