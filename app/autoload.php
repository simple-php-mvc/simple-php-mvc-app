<?php

$loader = require_once __DIR__ . '/../vendor/autoload.php';
$loader->add('', __DIR__ . '/../src');
$loader->addClassMap(array(
    'AppMVC' => __DIR__ . '/AppMVC.php'
));