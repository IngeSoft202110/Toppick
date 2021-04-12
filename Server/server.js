"use strict"
/****************/
/* Dependencies */
/****************/
var express = require('express');
var cors = require('cors');
var mysql = require('mysql');

/************************/
/* Server configuration */
/************************/
const PORT = process.env.PORT || 8001;
const app = express();

app.use(cors()); // Alow incomming requests
app.use(express.json()); // To handle Post requests 


/***************************/
/* Data base configuration */
/***************************/
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'julian9812',
    //password: '1234567890',
    database: 'Toppick_Schema'
});
// Connect to database
connection.connect((err) => {
    if (err) console.log("error : ", err)
    else console.log("Connection with DB, succsessful")
});


/*****************/
/* Web endpoints */
/*****************/
/*
estructura de JSON de los pedidos
{
    id:123,
    horaEntrga: 5:30pm,
    productos: [
        {
            idProducto: 1,
            nombreProducto: pescadito,
            comentarios:"cualquier cosa"
        }
    ]
}
*/
// Get a specific order info 
app.get('/toppick/admin/:order_id', (req, res) => {
    // Url params
    const order_id = req.params.order_id;
    // Data base query 
    const query = `SELECT idPedido,fechaReclamo,idProducto,nombreProducto,cantidadProducto 
    FROM Toppick_Schema.Producto,Toppick_Schema.Pedido,Toppick_Schema.Carrito 
    WHERE idPedido = ${order_id} && Pedido_idPedido= ${order_id} and producto_idProducto = idProducto `;
    // Query DB ,
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        if (rows.length > 0) {
            let fecha = new Date((rows[0].fechaReclamo));
            console.log(fecha);
            let pedido = {
                id: rows[0].idPedido,
                horaEntrega: fecha,
                productos: []
            };
            
            rows.forEach(p => {
                
                let b = {
                    idProducto: p.idProducto,
                    nombreProducto: p.nombreProducto,
                    comentarios: p.cantidadProducto.toString
                };
                pedido.productos.push(b);

            });

            res.send(pedido);
        } else
            res.send("none");

    }); 
});


/*****************/
/* App endpoints */
/*****************/
// Products from all University 
app.get('/toppick/app/products', (req, res) => {
    // Data base query 
    const query = 'SELECT * FROM Toppick_Schema.Producto';
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        res.json(rows);
    });
});

// All oppened stores in university 
app.get('/toppick/app/oppened-stores', (req, res) => {
    // Data base query 
    const query = "SELECT * FROM Toppick_Schema.PuntoDeVenta WHERE Estado = 'Abierto'";
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        res.json(rows);
    });
});

// Schedule for a store 
app.get('toppick/app/schedule/for/:store_id', (req, res) => {
    // Url params
    const store_id = req.params.store_id; 
    // Data base query 
    const query = 'SELECT idPuntoDeVenta, nombrePuntoDeVenta, nombre, horaApertura, horaCierre '
                + 'FROM toppick_schema.puntodeventa, toppick_schema.puntodeventaxhorario, toppick_schema.horario, toppick_schema.horaapertura, toppick_schema.horacierre, toppick_schema.día '
                + `WHERE idPuntoDeVenta = ${store_id} and  PuntodeVenta_idPuntodeVenta = idPuntodeventa and Horario_idHorario = idHorario `
                +       'and HoraApertura_idHoraApertura = idHoraApertura and HoraCierre_idHoraApertura = idHoraCierre and Día_idDía = idDía';
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        res.json(rows);
    });
});

// Get all stores
app.get('/toppick/app/all-stores', (req, res) => {
    // Data base query 
    const query = 'SELECT * FROM Toppick_Schema.PuntoDeVenta';
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        res.json(rows);
    });
});

// Catalog from a given store 
app.get('/toppick/app/catalog/:store_id', (req, res) => {
    const store_id = req.params.store_id;
    // Data base query 
    const query = 'SELECT idProducto, nombreProducto, precio, tiempoPreparacion, Producto.calificacion, Producto.urlImagen, categoria '
                + 'FROM toppick_schema.producto, toppick_schema.puntodeventa, toppick_schema.catalogo '
                + `WHERE idPuntoDeVenta = ${store_id} and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto`;
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        res.json(rows);
    });
});

// Stores that have a given product 
app.get('/toppick/app/stores-that-contains/:product_id', (req, res) => {
    // Url params
    const product_id = req.params.product_id;
    // Data base query 
    const query = 'SELECT idPuntodeVenta, Usuario_nombreUsuario, Usuario_contraseña, nombrePuntoDeVenta, tipoPuntoVenta, urlUbicacion, Estado, PuntoDeVenta.urlImagen '
        + 'FROM toppick_schema.producto, toppick_schema.puntodeventa, toppick_schema.catalogo '
        + `WHERE idProducto = ${product_id} and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto;`;
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response
        res.json(rows);
    });
});

// Accompaniment of a specialty 
app.get('/toppick/app/accompaniment-of-specialty/:product_id', (req, res) => {
    // Url params
    const product_id = req.params.product_id;
    // Data base query 
    const query = 'SELECT idAcompañamiento, nombreAcompañamiento, tipo '
        + 'FROM toppick_schema.Acompañamiento, toppick_schema.AcompañamientoXEspecialidad, toppick_schema.especialidad, toppick_schema.producto '
        + `WHERE idProducto = ${product_id} and Producto_IdProducto = idProducto and Especialidad_Producto_idProducto = idProducto and idacompañamiento = acompañamiento_idacompañamiento`;
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response
        res.json(rows);
    });
});

// Products of a combo  
app.get('/toppick/app/products-of-combo/:product_id', (req, res) => {
    // Url params 
    const product_id = req.params.product_id;
    // Data base query 
    const query = 'SELECT idProducto, nombreProducto, precio, tiempoPreparacion, calificacion, urlImagen, categoria '
        + 'from toppick_schema.Combo, toppick_schema.ProductoXCombo, toppick_schema.producto '
        + `where toppick_schema.Combo.Producto_idProducto = ${product_id} and toppick_schema.ProductoXCombo.Producto_IdProducto = idProducto and toppick_schema.ProductoXCombo.Combo_Producto_idProducto = toppick_schema.Combo.Producto_idProducto`;
    // Query DB 
    connection.query(query, (err, rows, fields) => {
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