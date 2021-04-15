# Toppick
## Descripción
Toppick busca eliminar las filas de compra de productos en los puntos de venta de la PUJ, por medio de una compra virtual y anticipada. Para esto se desarrolló la aplicación móvil Toppick App, la cual permite realizar los pedidos, y la aplicación web Toppick Admin, la cual le permite a los vendedores de los puntos de venta gestionar los pedidos.

## Toppick App
Aplicación móvil desarrollada en Flutter, cuyo lenguaje principal es Dart.
### Requisitos
- Tener instalado Flutter 2.0.3
- Utilizar un emulador de Android o iOS, o un dispositivo móvil real.
### Instalar dependencias
- <code> pub get </code>
## Toppick Admin
Aplicación web desarrollada con HTML5, CSS3 y JavaScript.
## Bases de datos
Base de datos relacional desarrollada con MySQL
### Requisitos
- MySQL Workbench
- MySQL Server
## Servidor
Servidor realizado en Node.js y express, el cual funciona para las comunicaciones entre Toppick-App, Toppick-Admin y la Base de Datos.
### Dependencias para el servidor
- <code> cd Server </code>
- <code> npm install express nodemon cors body-parser mysql </code> 
- O simplemente utilizar el comando <code> npm install </code> y el script de instalación se encargará de esto.
### Ejecutar el servidor
- <code> npm start </code>