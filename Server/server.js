/****************/
/* Dependencies */ 
/****************/
var express = require('express'); 
var mysql = require('mysql'); 

/************************/
/* Server configuration */
/************************/
const app = express(); 
const PORT = process.env.PORT || 8001; 


/***************************/
/* Data base configuration */
/***************************/
var connection = mysql.createConnection({
    host: 'localhost', 
    user: 'root', 
    password: '1234567890', 
    database: 'Toppick_Schema'
}); 
// Connect to database
connection.connect( () => console.log("Connection with DB, succsessful") ); 


/***************/
/* Middlewares */
/***************/
// app.use(express.json()); 


/*****************/
/* Web endpoints */
/*****************/
// Get all orders of the day (Historic)

// Get a specific order info 
app.get('/toppick/admin/:order_id', (req, res) => {
    // Url params
    const order_id = req.params.order_id; 
    // Data base query 
    const query = `SELECT * FROM Toppick_Schema.Pedido WHERE idPedido = ${order_id}`; 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Send response 
        res.send(rows); 
    });
}); 


/*****************/
/* App endpoints */
/*****************/
// Products from all University ----> READY
app.get('/toppick/app/products', (req, res) => {
    // Data base query 
    const query = 'SELECT * FROM Toppick_Schema.Producto'; 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Send response 
        res.json(rows); 
    });
}); 

// All oppened stores in university ----> READY
app.get('/toppick/app/oppened-stores', (req, res) => {
    // Data base query 
    const query = "SELECT * FROM Toppick_Schema.PuntoDeVenta WHERE Estado = 'Abierto'"; 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Send response 
        res.json(rows); 
    });
}); 

// Catalog from a given store ----> READY
app.get('/toppick/app/catalog/:store_id', (req, res) => {
    const store_id = req.params.store_id; 
    // Data base query 
    const query = 'SELECT idProducto, nombreProducto, precio, tiempoPreparacion, Producto.calificacion, Producto.urlImagen, categoria '
                + 'FROM toppick_schema.producto, toppick_schema.puntodeventa, toppick_schema.catalogo ' 
                + `WHERE idPuntoDeVenta = ${store_id} and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto`; 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Send response 
        res.json(rows); 
    });
}); 

// Stores that have a given product -----> READY
app.get('/toppick/app/stores-that-contains/:product_id', (req, res) => {
    // Url params
    const product_id = req.params.product_id; 
    // Data base query 
    const query = 'SELECT idPuntodeVenta, Usuario_nombreUsuario, Usuario_contraseña, nombrePuntoDeVenta, tipoPuntoVenta, urlUbicacion, Estado, PuntoDeVenta.urlImagen '
                + 'FROM toppick_schema.producto, toppick_schema.puntodeventa, toppick_schema.catalogo '
                + `WHERE idProducto = ${product_id} and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto;`; 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Send response
        res.json(rows); 
    });
}); 

// Accompaniment of a specialty ------> READY 
app.get('/toppick/app/accompaniment-of-specialty/:product_id', (req, res) => {
    // Url params
    const product_id = req.params.product_id; 
    // Data base query 
    const query = 'SELECT idAcompañamiento, nombreAcompañamiento, tipo '
                + 'FROM toppick_schema.Acompañamiento, toppick_schema.AcompañamientoXEspecialidad, toppick_schema.especialidad, toppick_schema.producto '
                + `WHERE idProducto = ${product_id} and Producto_IdProducto = idProducto and Especialidad_Producto_idProducto = idProducto and idacompañamiento = acompañamiento_idacompañamiento`; 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Send response
        res.json(rows); 
    });
}); 

// Products of a combo -----> READY  
app.get('/toppick/app/products-of-combo/:product_id', (req, res) => {
    // Url params 
    const product_id = req.params.product_id; 
    // Data base query 
    const query = 'SELECT idProducto, nombreProducto, precio, tiempoPreparacion, calificacion, urlImagen, categoria '
                + 'from toppick_schema.Combo, toppick_schema.ProductoXCombo, toppick_schema.producto '
                + `where toppick_schema.Combo.Producto_idProducto = ${product_id} and toppick_schema.ProductoXCombo.Producto_IdProducto = idProducto and toppick_schema.ProductoXCombo.Combo_Producto_idProducto = toppick_schema.Combo.Producto_idProducto`; 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Send response
        res.json(rows); 
    });
}); 


/*************/
/* Listenner */
/*************/
app.listen(PORT, () => console.log("Listenning on localhost:" + PORT)); 