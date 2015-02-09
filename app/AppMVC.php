<?php

use MVC\MVC;
use MVC\Module\Module;
use MVC\Provider\Provider;
use MVC\Server\Route;

/**
 * Description of AppMVC
 *
 * @author Ramón Serrano <ramon.calle.88@gmail.com>
 */
class AppMVC extends MVC
{
    
    /**
     * Set MVC Application Modules
     * 
     * @return Module[]
     */
    public function setModules()
    {
        $modules = array(
            new \MVC\Tests\TestModule\TestModule(),
        );
        
        return $modules;
    }
    
    /**
     * Set MVC Application Providers
     * 
     * @return Provider[]
     */
    public function setProviders()
    {
        $providers = array(
            new \MVC\DataBase\PdoProvider(array(
                'host'   => '127.0.0.1',
                'user'   => 'root',
                'passwd' => '',
                'dbname' => 'sf_etituymedio'
            )),
            new \MVC\Tests\Provider\DoctrineDBALProvider(array(
                'charset'  => null,
                'driver'   => 'pdo_mysql',
                'dbname'   => 'test',
                'host'     => 'localhost',
                'user'     => 'root',
                'password' => null,
                'port'     => null,
            )),
            new \MVC\Tests\Provider\DoctrineORMProvider(array(
                'params'       => array(
                    'charset'  => null,
                    'driver'   => 'pdo_mysql',
                    'dbname'   => 'test',
                    'host'     => 'localhost',
                    'user'     => 'root',
                    'password' => null,
                    'port'     => null,
                ),
                'dev_mode'     => false,
                'etities_type' => 'annotations',
                'path_entities' => array(
                    $this->getAppDir() . '/../src/MVC/Tests/TestModule/Entity'
                ),
                'proxy_dir'    => null
            )),
            new \MVC\Tests\Provider\MonologProvider(array(

            )),
            new \MVC\Tests\Provider\TwigProvider(array(
                'path' => $this->getAppDir() . '/../src/MVC/Tests/TestModule/Resources/views'
            )),
        );
        
        $providers[] = new \MVC\Tests\TestModule\TestProvider(array(
            
        ));
        
        return $providers;
    }
    
    /**
     * Set MVC Application Routes
     * 
     * @return Route[]
     */
    public function setRoutes()
    {
        $routes = parent::setRoutes();
        
        $routes[] = array(
            array(
                "method"  => ["ajax", "get", "post"],
                "pattern" => "/",
                "action"  => function() {
                    return 'Index';
                },
                "name"    => "index"
            )
        );
        
        return $routes;
    }
    
    /**
     * {@inheritdoc}
     */
    public function getModules()
    {
        return $this->container->getModules();
    }
}
