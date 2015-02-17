<?php

$loader = require_once __DIR__ . '/../vendor/autoload.php';
$loader->add('MVC', __DIR__ . '/../vendor/simple-php-mvc/simple-php-mvc/src');
$loader->add('', __DIR__ . '/../src');
$loader->addClassMap(array(
    'AppMVC' => __DIR__ . '/AppMVC.php'
));