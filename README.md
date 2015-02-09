# Simple PHP-MVC

Plantilla con el Modelo Vista Controlador

### Tabla de Contenidos
- [Instalación](#instalacion)
- [Configuración](#configuracion)
- [Rutas, Vistas y Controladores](#rut-vis-cont)
- [Modelos](#modelos)
- [Rutas](#rutas)
    - [GET](#rutas-get)
    - [POST](#rutas-post)
    - [DELETE](#rutas-DELETE)
    - [PUT](#rutas-put)
    - [OPTIONS](#rutas-options)
    - [HEAD](#rutas-head)
    - [AJAX](#rutas-ajax)
    - [Grupos de rutas](#rutas-group)
- [Parámetros de rutas](#rutas-params)
- [Redireccionamiento](#redirect)
- [Proveedores o servicios](#providers)
- [Otros aspectos](#otros)
    - [controller($name = null)](#otros-controllers)
    - [model($name = null)](#otros-models)
    - [view()](#otros-view)
    - [request()](#otros-request)
    - [response()](#otros-response)
- [Pruebas Unitarias](#pruebas)
- [Ejemplo: Hola mundo](#hola-mundo)
- [Ejemplo2: Usando Modelos y Controladores](#ejemplo2)
- [Usando la consola](#usando-consola)
- [Autor](#autor)

### <a name='instalacion'></a> Instalación

#### **Instalar composer**

#### **Git clone** (recomendada)
Clonar el repositorio en [github](#"https://github.com/simple-php-mvc/simple-php-mvc"). Y luego entrar en la carpeta clonada a través del terminal y luego ejecuta **composer install** para instalar todas las dependencias del projecto en la carpeta `vendor`.

> **Nota:** esta es la forma recomendada de instalación para obtener la aplicación configurada.

#### **Composer install**

-- Crea una carpeta con el nombre de tu proyecto.
-- Entra en la carpeta que creaste y agrega un archivo composer.json con el contenido

```json
{
   "require": {
      "simple-php-mvc/simple-php-mvc": '1.6'
   }
}
```
-- Abre una terminal de tu sistema operativo y ejecuta en la carpeta del proyecto **composer install** y espera a que se instale Simple PHP MVC.

#### **Composer create-project**
Otra forma de instalar con composer es ejecutando el comando **composer install simple-php-mvc/simple-php-mvc** en la terminal de tu sistema operativo.

### <a name='configuracion'></a> Configuración
> Asegúrate de que la carpeta raíz del sistema tenga los permisos apropiados con `sudo chmod 755 -R`.

```
proyecto
|_ app/
    |_ config/
       routes.json
       routes.php
    .htaccess
    AppMVC.php
    autoload.php
    console
|_ src/
|_ vendor/
|_ web/
   .htaccess
   app.php
   app_dev.php
```
> **Importante: ** en el archivo **`app/AppMVC.php`** es la configuración de los módulos, proveedores o servicios y las rutas, y puede ser como el siguiente:

```php
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
            new \MVC\Tests\EjemploModule\EjemploModule(),
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
                    $this->getAppDir() . '/../src/MVC/Tests/EjemploModule/Entity'
                ),
                'proxy_dir'    => null
            )),
            new \MVC\Tests\Provider\MonologProvider(array(

            )),
            new \MVC\Tests\Provider\TwigProvider(array(
                'path' => $this->getAppDir() . '/../src/MVC/Tests/EjemploModule/Resources/views'
            )),
        );
        
        $providers[] = new \MVC\Tests\EjemploModule\EjemploProvider(array(
            
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
```

### <a name='rut-vis-cont'></a> Rutas, Vistas y Controladores
> 1. Rutas
>   - En el archivo **`app/config/routes.php`** o **`app/config/routes.json`** puedes configurar las acciones para las rutas que deseas configurar.
> 2. Vistas
>   - Las vistas debe ser archivos con extensión `.html` o `.php`. 
>   - Si usa un controlador para mostrar la vista, los nombres de estos archivos deben ser iguales a la accion del controlador. Ejemplo: **accion/controlador** `index`, **archivo/vista** `index.html`
>   - Los archivos deben ser guardados en la carpeta configurada en **templates_path** de la instancia de **`MVC\MVC`** con el nombre de la clase del controlador sin la palabra **Controller**. Ejemplo: **carpeta** `clase` donde clase -> ClaseController.
> 3. Controladores
>   - Se recomienda que cada controlador extienda de **`MVC\Controller\Controller`**.
>   - El retorno de cada controlador deben ser `cadenas de texto` o variables de tipo `arreglos asociativos` con valores de cualquier tipo.
>   - Para enviar varias variables a una vista, sean de cualquier tipo, el controlador debe retornar las variables dentro de la función `array()`. Ejemplo: **$variable1, $variable2, $variable3** `return array( 'variable1' => $variable1, 'variable2' => $variable2, 'variable3' => $variable3 )`

## <a name='controladores'></a> Controladores
```php
<?php

namespace ControllersNamespace;

use MVC\Controller\Controller,
    MVC\MVC,
    MVC\Server\HttpRequest;

class ClaseController extends Controller
{
   public function indexAction(MVC $mvc, HttpRequest $request)
   {
       return '<p>Resultado de la accion</p>';
   }
}
```

## <a name='modelos'></a> Modelos
Un modelo se crea de la siguiente forma:
```php
<?php
namespace ModelsNamespace;

use MVC\DataBase\Model,
    MVC\DataBase\PDO;

class Nombre_del_Modelo extends Model
{
    public function __construct(PDO $pdo)
    {
        parent::__construct($pdo, 'nombre_tabla');
    }
}
```

## <a name='rutas'></a> Rutas
Una ruta se representa como cualquier URI con métodos de consulta que se envía al servidor. 

En la carpeta `app/config` en el archivo **`routes.json`** o **`routes.php`** se configuran las rutas de la aplicación.

```json
[{
    "method": ["get", "post", "ajax"],
    "pattern": "/index",
    "action": "ControllerNamespace\\ClaseController::indexAction",
    "name": "foo_index"
},
{
    "method": ["ajax", "delete", "get", "post", "put", "head", "options"],
    "pattern": "/index2",
    "action": "ControllerNamespace\\FooController::index2Action",
    "name": "foo_index2"
}]
```
o
```php

<?php
return array(
    array(
        "method"  => ["ajax", "get", "post"],
        "pattern" => "/index",
        "action"  => "ControllerNamespace\\FooController::indexAction",
        "name"    => "foo_index"
    ),
    array(
        "method"  => ["ajax", "delete", "get", "post", "put", "head", "options"],
        "pattern" => "/index2",
        "action"  => "ControllerNamespace\\FooController::index2Action",
        "name"    => "foo_index2"
    ),
);
```

#### <a name='rutas-get'></a> GET
Usa el método **get()** de tu aplicación u objeto **MVC** para crear recursos que devuelvan una llamada a un **URI** mediante el método **HTTP GET**.
```
$mvc = new \MVC\MVC();
$mvc->get("/hello/[a:name]", function($name) {
    return "Hello $name.";
}, 'hello_get');
```
#### <a name='rutas-post'></a> POST
Usa el método **post()** de tu aplicación u objeto **MVC** para crear recursos que devuelvan una llamada a un **URI** mediante el método **HTTP POST**.
```
$mvc = new \MVC\MVC();
$mvc->post("/hello/[a:name]", function($name) {
    return "Hello $name";
}, 'hello_post');
```
#### <a name='rutas-delete'></a> DELETE
Usa el método **delete()** de tu aplicación u objeto **MVC** para crear recursos que devuelvan una llamada a un **URI** mediante el método **HTTP DELETE**.
```
$mvc = new \MVC\MVC();
$mvc->delete("/hello/[i:id]", function($id) {
    return "DELETE $id";
}, 'hello_delete');
```
#### <a name='rutas-put'></a> PUT
Usa el método **put()** de tu aplicación u objeto **MVC** para crear recursos que devuelvan una llamada a un **URI** mediante el método **HTTP PUT**.
```
$mvc = new \MVC\MVC();
$mvc->put("/hello/[i:id]", function($id) {
    return "PUT $id";
}, 'hello_put');
```
#### <a name='rutas-options'></a> OPTIONS
Usa el método **options()** de tu aplicación u objeto **MVC** para crear recursos que devuelvan una llamada a un **URI** mediante el método **HTTP OPTIONS**.
```
$mvc = new \MVC\MVC();
$mvc->options("/hello/[i:id]", function($id) {
    return "OPTIONS $id";
}, 'hello_options');
```
#### <a name='rutas-head'></a> HEAD
Usa el método **head()** de tu aplicación u objeto **MVC** para crear recursos que devuelvan una llamada a un **URI** mediante el método **HTTP HEAD**.
```
$mvc = new \MVC\MVC();
$mvc->head("/hello/[i:id]", function($id) {
    return "HEAD $id";
}, 'hello_head');
```
#### <a name='rutas-ajax'></a> AJAX
Usa el método **ajax()** de tu aplicación u objeto **MVC** para crear recursos que devuelvan una llamada a un **URI** mediante el método **HTTP AJAX**.
```php
$mvc = new \MVC\MVC();
$mvc->ajax("/hello/[i:id]", function($id) {
    return "AJAX $id";
}, 'hello_ajax');
```
## <a name='rutas-group'></a> Grupos de rutas
Usa el método group de tu aplicación u objeto **MVC** para crear recursos de rutas agrupadas. Esto es para agrupar grupos de rutas que tienen el mismo prefijo.
```php
$mvc = new \MVC\MVC();
$mvc->group("/admin", function($route) use($mvc) {
    $mvc->get($route, function() {
        return "Admin index";
    }, 'admin_index');
    $mvc->get("$route/other", function() {
        return "Admin other route.";
    }, 'admin_other');
});
```
## <a name='rutas-params'></a> Parámetros de rutas
Los tipos de variables válidos para las rutas son:

 - **[i]** Entero
 - **[a]** Alfanumerico
 - **[h]** Hexadecimal
 - **[*]** Cualquier valor

```php
$mvc = new \MVC\MVC();
$mvc->ajax("/hello/[i:id]/[a:name]", function($id, $name) {
    return "AJAX id = $id, name = $name\n";
}, 'hello_id_name');
```
## <a name='redirect'></a> Redireccionamiento
Esta función redirecciona a una ruta...
```php
$mvc = new \MVC\MVC();
$mvc->get("/", function() use($mvc){
    $mvc->redirect('/redirect');
}, 'home_redirect');
$mvc->get("/redirect", function(){
    return "Redirect\n";
}, 'redirect');
```
## <a name='providers'></a> Proveedores o servicios
Este aspecto es para registrar otros servicios independientes del Simple PHP MVC extendiendo de **`MVC\Provider\Provider`**. Por ejemplo: Doctrine Object Relational Mapper (ORM), SwiftMailer, Monolog, etc. 
```php
<?php

namespace ProvidersNamespace;

use MVC\MVC,
    MVC\Provider\Provider;

class ExampleProvider extends Provider
{
    public function __construct(array options = array())
    {
	    parent::__contruct($options);
    }
    
    public function boot(MVC $mvc)
    {
	    //Configuraciones
    }

    public function register(MVC $mvc) 
    {
        // Registro de variables de uso o de servicios
        $app->setCvpp('example.name', get_class($this));
        
    }

}
```

## <a name='otros'></a> Otros aspectos
Para usar los objetos Response, HttpRequest, View, están las siguientes funciones:

### <a name='otros-view'></a> view()
Devuelve el objeto de la vistas.
```
$mvc = new \MVC\MVC();
$view = $mvc->view();
```
### <a name='otros-request'></a> request()
Devuelve el objeto **`MVC\Server\HttpRequest.`**
```
$mvc = new \MVC\MVC();
$request = $mvc->request();
```
### <a name='otros-response'></a> response()
Devuelve el objeto \MVC\server\Response.
```
$mvc = new \MVC\MVC();
$response = $mvc->response();
```
### <a name='usando-consola'></a> Usando la consola

> Actualmente en desarrollo. Esperar la version 2.0

### <a name='autor'></a> **Autor:** 
Ramón Serrano <ramon.calle.88@gmail.com>

