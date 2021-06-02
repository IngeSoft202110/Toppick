const pool = require('../store/databaseConection');
const response = require('../network/response')
const { generarPago } = require('./pagosDB');
const boom = require('@hapi/boom');

/*

    APP

*/


//listar una orden dado su id

async function listarOrdenbyId(id) {
    try {
        const pedido = await pool.query("SELECT * FROM Pedido WHERE idPedido = ?", [id]);
        return pedido;
    } catch {
        throw boom.badImplementation("Error al listar los pedidos del usuario");
    }
}

// crea un pedido

async function createOrder(order, res) {
    let { carrito, ...ordenInfo } = order;
    if (!ordenInfo.razonRechazo) ordenInfo.razonRechazo = null;
    try {
        const response = await generarPago(ordenInfo.Cliente_IdCliente, ordenInfo.costoTotal);
        if (response === "no hay fondos suficientes" || response === "no hay metodos de pago registrados")
            throw response
    } catch (error) {
        if (error === "no hay fondos suficientes" || error === "no hay metodos de pago registrados") {
            if (error === "no hay fondos suficientes")
                throw boom.paymentRequired("no hay fondos suficientes");
            else
                throw boom.paymentRequired("no hay metodos de pago registrados");
        }
        else
            throw boom.badImplementation("error en el pago del pedido")
    }

    const object = {};

    object.insertPedido = async (ordenInfo) => await pool.query(`INSERT INTO Pedido  set ?`, ordenInfo);
    object.insertCarrito = async (car) => { await pool.query(`INSERT INTO Carrito VALUES ?`, [car]); return true; };
    object.insetAcompanamiento = async (acompanamientos) => await pool.query(`INSERT INTO AcompañamientoXSeleccion VALUES ?`, [acompanamientos]);
    let id;
    try {

        await pool.query("START TRANSACTION")
        const result = await object.insertPedido(ordenInfo);

        id = result.insertId
        carrito.forEach(p => {
            p.Pedido_idPedido = id;
            if (p.comentario === '' || !p.comentario) p.comentario = null;
        });
        const acompanamientos = mapCarrito(carrito);
        const car = carrito.map(p => [p.Producto_idProducto, p.Pedido_idPedido, p.CantidadProducto, p.comentario]);

        pool.getConnection((err, connection) => {
            if (err)
                throw new Error("error en la conexion");


            connection.query(`INSERT INTO Carrito VALUES ?`, [car], (err, result) => {
                if (err)
                    throw new Error("error en la conexion");

                if (acompanamientos.length > 0) {
                    connection.query(`INSERT INTO AcompañamientoXSeleccion VALUES ?`, [acompanamientos], (err, result) => {
                        if (err)
                            throw new Error("error en la conexion");

                        connection.commit((err) => {
                            if (err)
                                throw new Error("error en la conexion");
                        })
                    });
                }
                else {
                    connection.commit((err) => {
                        if (err)
                            throw new Error("error en la conexion");
                    })
                }
            });
        });
        await pool.query("Commit;")
    } catch (error) {
        console.log("error in DB pedido: " + error);
        pool.query("rollback");
        throw boom.badImplementation("error al crear el pedido");
    }

    console.log("el id del pedido Actual es: " + id);
    try {
        const order = await listarTodaLaOrdenPorId(id);
        console.log(order);
        return order;
    } catch (error) {
        throw boom.badImplementation("Error al listar el pedido");
    }
}


async function listarOrdenesPorIdUsuario(id) {
    const object = {}

    object.AllOrders = async (id) => await pool.query(`SELECT Pedido.idPedido,PuntoDeVenta.nombrePuntoDeVenta,Pedido.Cliente_IdCliente,Pedido.fechaCreacion,Pedido.costoTotal,Pedido.fechaReclamo,Pedido.estadoPedido,Pedido.razonRechazo  From Pedido, PuntoDeVenta  where PuntoDeVenta.idPuntodeVenta = Pedido.PuntoDeVenta_idPuntodeVenta and Pedido.Cliente_IdCliente =?`, id);
    object.AllProductsByOrder = async (id) => await pool.query(`SELECT nombreProducto,CantidadProducto FROM Carrito, Producto Where Carrito.Producto_idProducto = Producto.idProducto and Carrito.Pedido_idPedido = ?`, id);
    object.FinalOrders = async (id) => {
        const order = await object.AllOrders(id);
        for (let i = 0; i < order.length; i++) order[i].carrito = await object.AllProductsByOrder(order[i].idPedido);
        return order;
    }

    try {
        const orders = await object.FinalOrders(id);
        return orders;
    } catch (error) {
        throw boom.badImplementation("error al listar los pedidos del usuario");
    }
}

async function listarTodaLaOrdenPorId(id) {
    const object = {}

    object.AllOrders = async (id) => await pool.query(`SELECT * From Pedido where Pedido.idPedido =? `, id);
    object.AllProductsByOrder = async (id) => await pool.query(`SELECT Producto_idProducto,nombreProducto,CantidadProducto,comentario FROM Carrito, Producto Where Carrito.Producto_idProducto = Producto.idProducto and Carrito.Pedido_idPedido = ${id}`);
    object.AllTipsByProduct = async (idCarrito, idProducto) => await pool.query(`SELECT nombreAcompañamiento FROM AcompañamientoXSeleccion, Acompañamiento Where AcompañamientoXSeleccion.Carrito_Pedido_idPedido = ${idCarrito} and AcompañamientoXSeleccion.Especialidad_Producto_idProducto = ${idProducto} and AcompañamientoXSeleccion.Acompañamiento_idAcompañamiento = Acompañamiento.idAcompañamiento`);


    object.FinalOrders = async (id) => {
        const aux = await object.AllOrders(id);
        const order = aux[0]
        order.carrito = await object.AllProductsByOrder(id);
        for (let i = 0; i < order.carrito.length; i++) order.carrito[i].Acompañamientos = await object.AllTipsByProduct(id, order.carrito[i].Producto_idProducto);
        return order;
    }

    try {
        const orders = await object.FinalOrders(id);
        return orders;
    } catch (error) {
        console.log(error)
        throw boom.badImplementation("error al listar los pedidos");
    }
}



/*

    ADMIN

*/

async function updateSatus(id, status, razonRechazo = null) {

    const result = await pool.query(`Select idPedido from Pedido where idPedido = ${id}`);
    if (result.length < 1) throw boom.badData("el pedido no existe");

    try {
        await pool.query('UPDATE Pedido SET estadoPedido = ?, razonRechazo = ? WHERE idPedido = ?', [status, razonRechazo, id]);
        await pool.query("commit");

        const response = await pool.query(`Select Cliente_IdCliente from Pedido where idPedido = ${id}`);
        const token = await pool.query(`select token from Cliente  where IdCliente = ${response[0].Cliente_IdCliente}`);
        return token[0].token;
    } catch (error) {
        pool.query("rollback");
        throw boom.badImplementation("error al actualizar el estado del pedido");
    }
}


async function listarOrdenesPorIdTienda(id) {
    let ts = Date.now();
    let date_ob = new Date(ts);
    let day = date_ob.getDate();
    let month = date_ob.getMonth() + 1;
    let year = date_ob.getFullYear();

    const fechaInicial = `STR_TO_DATE('${year}-${month}-${day} 00:00:00' , '%Y-%m-%d %T')`;
    const fechaFinal = `STR_TO_DATE('${year}-${month}-${day} 23:59:59',  '%Y-%m-%d %T')`;

    const object = {}

    object.AllOrders = async (id) => await pool.query(`SELECT * From Pedido where Pedido.PuntoDeVenta_idPuntodeVenta= ${id} and Pedido.fechaCreacion between  ${fechaInicial} and ${fechaFinal}`);
    object.AllProductsByOrder = async (id) => await pool.query(`SELECT Producto_idProducto,nombreProducto,CantidadProducto,comentario FROM Carrito, Producto Where Carrito.Producto_idProducto = Producto.idProducto and Carrito.Pedido_idPedido = ${id}`);
    object.AllTipsByProduct = async (idCarrito, idProducto) => await pool.query(`SELECT nombreAcompañamiento FROM AcompañamientoXSeleccion, Acompañamiento Where AcompañamientoXSeleccion.Carrito_Pedido_idPedido = ${idCarrito} and AcompañamientoXSeleccion.Especialidad_Producto_idProducto = ${idProducto} and AcompañamientoXSeleccion.Acompañamiento_idAcompañamiento = Acompañamiento.idAcompañamiento`);


    object.FinalOrders = async (id) => {
        const order = await object.AllOrders(id);
        for (let i = 0; i < order.length; i++) {
            order[i].carrito = await object.AllProductsByOrder(order[i].idPedido);
            for (let j = 0; j < order[i].carrito.length; j++) order[i].carrito[j].Acompañaminetos = await object.AllTipsByProduct(order[i].idPedido, order[i].carrito[j].Producto_idProducto);
        }
        return order;
    }

    try {
        const orders = await object.FinalOrders(id);
        return orders;
    } catch (error) {
        console.log(error)
        throw boom.badImplementation("error al listar los pedidos de una tienda");
    }












}


module.exports = {
    listarOrdenbyId,
    createOrder,
    listarOrdenesPorIdUsuario,




    updateSatus,
    listarOrdenesPorIdTienda,
    listarTodaLaOrdenPorId
}


function mapCarrito(carrito) {
    let acompanamientos = [];
    carrito.forEach(element => {
        if (element.Acompañamientos) {
            element.Acompañamientos.forEach(a => {
                a.Especialidad_Producto_idProducto = element.Producto_idProducto;
                a.Carrito_Pedido_idPedido = element.Pedido_idPedido;
                acompanamientos.push(a);
            });
            delete element.Acompañaminetos;
        }
    });

    const resultArray = acompanamientos.map(a => [a.Especialidad_Producto_idProducto, a.Acompañamiento_idAcompañamiento, a.Carrito_Pedido_idPedido]);

    return resultArray;

}
