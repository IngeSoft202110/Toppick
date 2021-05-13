/****************/
/* Dependencies */
/****************/
const express = require('express');
const cors = require('cors');
const mysql = require('mysql');
const bodyParser = require('body-parser');

/************************/
/* Server configuration */
/************************/
const PORT = process.env.PORT || 3000;
const app = express();

app.use(cors()); // Get requests
app.use(bodyParser.json()); // Post requests
app.use(bodyParser.urlencoded({ extended: true })); // Post requests


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
// Get an specific order 

app.get('/toppick/admin/login/puntos-venta', (req, res) => {
    const query = "select Usuario_nombreUsuario from toppick_schema.puntodeventa;"
    //conect DB
    connection.query(query, (err, rows, fields) => {
        if (err) throw err;
        if (rows.length > 0) {
            console.log("pedticion puyntos de venta");
            res.send(rows);
        }
    })
});
app.get('/toppick/admin/:order_id', (req, res) => {
    // Url params
    const order_id = req.params.order_id;
    // Data base query 
    const query = 'SELECT idPedido,fechaReclamo,idProducto,nombreProducto,cantidadProducto, comentario '
        + 'FROM Toppick_Schema.Producto,Toppick_Schema.Pedido,Toppick_Schema.Carrito '
        + `WHERE idPedido = ${order_id} and Pedido_idPedido= ${order_id} and producto_idProducto = idProducto`;
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
                    cantidad: p.cantidadProducto,
                    comentario: p.comentario
                };
                pedido.productos.push(b);
            });

            res.send(pedido);
        }
        else res.send(undefined);

    });
});
app.post('/toppick/admin/login/:user/:password', (req, res) => {
    var user = req.params.user;
    var password = req.params.password;
    console.log("${user}")
    const query = `select Usuario_nombreUsuario,Usuario_contraseña,idPuntodeVenta
    from toppick_schema.puntodeventa 
    where Usuario_nombreUsuario = '${user}';`
    connection.query(query,(err, rows, fields)=>{
        if(rows[0].Usuario_nombreUsuario == user && rows[0].Usuario_contraseña == password )
        {

            res.send({
                id: rows[0].idPuntodeVenta,
                usuario:rows[0].Usuario_nombreUsuario
            });
        }else{
            res.send({
                id: undefined,
                usuario:undefined
            });
        }
    })

});
// Change state of an order -> TODO : Make query with store_id 
app.post('/toppick/admin/change-state-order', (req, res) => {
    // Body params
    const order_id = req.body.order_id;
    const store_id = req.body.store_id;
    const new_state = req.body.new_state || undefined;
    const reject_reazon = req.body.reject_reazon || undefined;
    // Create possible queries 
    const update_query = `UPDATE Toppick_Schema.Pedido SET estadoPedido = '${new_state}' WHERE idPedido = ${order_id}`; // When the order is not rejected
    const reject_query = `UPDATE Toppick_Schema.Pedido SET estadoPedido = '${new_state}', razonRechazo = '${reject_reazon}' WHERE idPedido = ${order_id}`; // When the order is rejected
    // Check if the the statement is a rejection or just an update of the state  
    const final_query = (!reject_reazon) ? update_query : reject_query;
    // Update tuple in DB  
    connection.query(final_query, (err) => {
        // Throw error if exists 
        if (err) throw err;
        console.log('Row updated');
    });

    // Update inventory for the products in the store if the change is 'Aproved'
    if (new_state === 'Aceptado') {
        // Get the cart info 
        const cart_info = `SELECT Producto_idProducto, CantidadProducto FROM Toppick_Schema.Carrito WHERE Pedido_idPedido = ${order_id}`;
        connection.query(cart_info, (err, result) => {
            // Throw error if exists
            if (err) throw err;
            // Save result 
            const cart = result.map((product) => { return [product.Producto_idProducto, product.CantidadProducto] });
            // Update inventory 
            cart.forEach((product) => {
                const update_inventory = `UPDATE Toppick_Schema.Catalogo SET inventario = inventario - ${product[1]} `
                    + `WHERE PuntoDeVenta_idPuntoDeVenta = ${store_id} AND Producto_idProducto = ${product[0]}`;
                connection.query(update_inventory, (err) => {
                    // Throw error if exists
                    if (err) throw err;
                    console.log('Inventory updated');
                });
            });
        });
    }

    // Send response 
    res.send('Order state changed');
});

/*****************/
/* App endpoints */
/*****************/
let order_id;
/** 
 * Function that assings the number of orders to 'order_id'
 * in that way, the created id will be : orders + 1 
 * TODO ----> Use store_id to get the number of orders given a store 
 */
function get_number_of_orders() {
    const number_of_orders = 'SELECT COUNT(*) FROM Toppick_Schema.Pedido';
    connection.query(number_of_orders, (err, result) => {
        // In case of error
        if (err) throw err;
        // Return the number of orders 
        const b = 'COUNT(*)';
        // Assign the result to the variable 'order_id'
        order_id = result[0][b];
    });
}
// Call function that searches the number of orders 
get_number_of_orders();
// Insert an order in the database
app.post('/toppick/app/insert/order', (req, res) => {
    // Increment order_id by 1
    order_id++;

    // Parameters
    const _cart = req.body.carrito; // Cart
    const order = req.body.orden; // Order 
    const _accompaniments = req.body.acompañamientos || undefined; // Accompaniments
    // Set order_id in cart
    const cart = _cart.map((product) => { return [product[0], order_id, product[2], product[3]] });
    // Set order_id in accompaniments if accompaniments exists, otherwise, set undefined
    const accompaniments = (_accompaniments) ? _accompaniments.map((accomp) => { return [accomp[0], accomp[1], order_id] }) : undefined;

    // Insert statements
    const insert_accompaniments = 'INSERT INTO Toppick_Schema.AcompañamientoXSeleccion (Especialidad_Producto_idProducto, Acompañamiento_idAcompañamiento, Carrito_Pedido_idPedido) VALUES ?';
    const insert_cart = 'INSERT INTO Toppick_Schema.Carrito (Producto_idProducto, Pedido_idPedido, CantidadProducto, comentario) VALUES ?';
    const insert_order = 'INSERT INTO Toppick_Schema.Pedido (idPedido, PuntoDeVenta_idPuntodeVenta, Cliente_idCliente, fechaCreacion, costoTotal, fechaReclamo, estadoPedido, razonRechazo) '
        + `VALUES (${order_id}, ${order[1]}, ${order[2]}, STR_TO_DATE('${order[3]}','%Y-%m-%d %T'), ${order[4]}, STR_TO_DATE('${order[5]}','%Y-%m-%d %T'), '${order[6]}', ${order[7]})`;

    // Insert 'order'
    connection.query(insert_order, (err) => {
        // Throw error if exists
        if (err) throw err;
        console.log("Order inserted");
    });
    // Insert 'cart' 
    // In order to insert more than one value, the second parameter is an array of arrays containing the information of the table  
    connection.query(insert_cart, [cart], (err) => {
        // Throw error if exists 
        if (err) throw err;
        console.log("Cart inserted");
    });
    // Insert 'accompaniments' if exists
    if (_accompaniments) {
        connection.query(insert_accompaniments, [accompaniments], (err) => {
            // If an error accours
            if (err) throw err;
            console.log("Accompaniments inserted");
        });
    }

    // Send response 
    res.send("Post request processed");
});

// Active orders of a user 
app.get('/toppick/app/active-orders-of/:user_id', (req, res) => {
    // Url params
    const user_id = req.params.user_id;
    // Data base query 
    const query = `Select idPedido, estadoPedido, costoTotal, DATE_FORMAT(fechaReclamo, '%Y-%m-%d %T') as fechaReclamo, nombrePuntoDeVenta, nombreProducto, cantidadProducto `
        + 'FROM Toppick_Schema.Pedido, Toppick_Schema.PuntoDeVenta, Toppick_Schema.Carrito, Toppick_Schema.Producto '
        + `WHERE Cliente_IdCliente = ${user_id} and idPuntoDeVenta =  PuntoDeVenta_idPuntoDeVenta and Pedido_idPedido = idPedido `
        + `and Producto_idProducto = idProducto and (estadoPedido = 'Solicitado' or estadoPedido = 'Aceptado' or estadoPedido = 'Listo')`;
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        res.json(rows);
    });
});

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
app.get('/toppick/app/schedule/for/store/:store_id', (req, res) => {
    // Url params
    const store_id = req.params.store_id;
    // Data base query 
    const query = 'SELECT idPuntoDeVenta, nombrePuntoDeVenta, nombreDia, horaApertura, horaCierre '
        + 'FROM Toppick_Schema.PuntoDeVenta, Toppick_Schema.PuntoDeVentaxHorario, Toppick_Schema.Horario, Toppick_Schema.HoraApertura, Toppick_Schema.HoraCierre, Toppick_Schema.Día '
        + `WHERE idPuntoDeVenta = ${store_id} and  PuntodeVenta_idPuntodeVenta = idPuntoDeVenta and Horario_idHorario = idHorario and HoraApertura_idHoraApertura = idHoraApertura and HoraCierre_idHoraCierre = idHoraCierre and Día_idDía = idDía`;
    // Query DB 
    connection.query(query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err;
        // Send response 
        res.json(rows);
    });
});

// Schedule for an specific product 
app.get('/toppick/app/schedule/for/product/:product_id', (req, res) => {
    // Url params
    const product_id = req.params.product_id;
    // Data base query 
    const query = 'SELECT horaInicioDisponibilidad, horaFinDisponibilidad '
        + 'FROM Toppick_Schema.Producto,  Toppick_Schema.Especialidad '
        + `WHERE idProducto = ${product_id} and Especialidad.Producto_idProducto = idProducto`;
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
    const query = 'SELECT idProducto, nombreProducto, Producto.descripcion, precio, tiempoPreparacion, Producto.calificacion, Producto.urlImagen, categoria, tipo '
        + 'FROM Toppick_Schema.Producto, Toppick_Schema.PuntoDeVenta, toppick_schema.Catalogo '
        + `WHERE idPuntoDeVenta = ${store_id} and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto ORDER BY categoria DESC, tipo, idProducto`;

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
    const query = 'SELECT idPuntodeVenta, Usuario_nombreUsuario, Usuario_contraseña, nombrePuntoDeVenta, tipoPuntoVenta, PuntoDeVenta.descripcion, urlUbicacion, Estado, PuntoDeVenta.calificacion, PuntoDeVenta.urlImagen '
        + 'FROM toppick_schema.producto, toppick_schema.puntodeventa, toppick_schema.catalogo '
        + `WHERE idProducto = ${product_id} and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto`;
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
    const query = 'SELECT idAcompañamiento, nombreAcompañamiento, Acompañamiento.tipo '
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
    const query = 'SELECT idProducto, nombreProducto, Producto.descripcion, precio, tiempoPreparacion, Producto.calificacion, Producto.urlImagen, categoria, tipo '
        + 'FROM Toppick_Schema.Combo, Toppick_Schema.ProductoXCombo, Toppick_Schema.Producto '
        + `WHERE toppick_schema.Combo.Producto_idProducto = ${product_id} and toppick_schema.ProductoXCombo.Producto_IdProducto = idProducto `
        + 'and toppick_schema.ProductoXCombo.Combo_Producto_idProducto = toppick_schema.Combo.Producto_idProducto';
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