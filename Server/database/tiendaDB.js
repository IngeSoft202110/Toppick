const pool = require('../store/databaseConection');

//lista todas las tiendas abiertas
async function list() {
    try {
        const Abierto = 'Abierto';
        const tiendas = await pool.query("SELECT * FROM PuntoDeVenta WHERE Estado = ?", [Abierto]);
        return tiendas;
    } catch {
        throw new Error("error al listar las tiendas");
    }
}

//lista la tienda solicitada por el id 
async function get(id) {
    try {
        const Abierto = 'Abierto';
        const tienda = await pool.query("SELECT * FROM PuntoDeVenta  WHERE Estado = ? AND idPuntoDeVenta = ?", [Abierto, id]);
        return tienda;
    } catch {
        throw new Error("error al listar la tienda seleccionada");
    }
}

//devuelve el catalogo de una tienda dado su id
async function getAll(id) {
    try {
        const tienda = await pool.query(`SELECT idProducto, nombreProducto, Producto.descripcion, precio, tiempoPreparacion, Producto.calificacion, Producto.urlImagen, categoria, tipo, inventario
        FROM Producto, PuntoDeVenta, Catalogo 
        WHERE idPuntoDeVenta = ? and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto ORDER BY categoria DESC, tipo, idProducto`, [id]);
        return tienda;
    } catch {
        throw new Error("error al listar el catalogo de la tienda");
    }
}

//devuelve el horario de una tienda
async function getSchedule(id) {
    try {
        const tienda = await pool.query(`SELECT nombreDia, horaApertura, horaCierre 
        FROM PuntoDeVenta, PuntoDeVentaXHorario, Horario, HoraApertura, HoraCierre, Día 
        WHERE idPuntoDeVenta = ? and  PuntodeVenta_idPuntodeVenta = idPuntoDeVenta and 
        Horario_idHorario = idHorario and HoraApertura_idHoraApertura = idHoraApertura and 
        HoraCierre_idHoraCierre = idHoraCierre and Día_idDía = idDía`, [id]);
        return tienda;
    } catch {
        throw new Error("error al devolver el horario de la tienda");
    }
}

//devuelve una lista de tiendas dado un id de producto
async function getAStoresBySpecificProduct(id) {
    try {
        const tienda = await pool.query(
            `SELECT idPuntodeVenta, nombrePuntoDeVenta, tipoPuntoVenta, PuntoDeVenta.descripcion, 
        urlUbicacion, Estado, PuntoDeVenta.calificacion, PuntoDeVenta.urlImagen 
        FROM Producto, PuntoDeVenta, Catalogo 
        WHERE idProducto = ${id} and PuntodeVenta_idPuntodeVenta = idPuntodeventa and Producto_idProducto = idProducto`);
        return tienda;
    } catch {
        throw new Error("error al listar las tiendas dado un producto");
    }
}



async function cierreCajaTienda(id) {

    const TOTALVENDIDO = totalGanado(id);
    const MASVENDIDO = masVendidos(id);
    const MASINGRESOS = masingresos(id);

    const object = {}
    const objectResponse = {};


    try {
        object.total = async (TOTALVENDIDO) => pool.query(TOTALVENDIDO);
        object.cantidad = async (MASVENDIDO) => pool.query(MASVENDIDO);
        object.ingresos = async (MASINGRESOS) => pool.query(MASINGRESOS);
    
        const responseTotal = (await object.total(TOTALVENDIDO));
        objectResponse.total = (responseTotal[0].total) || 0;
        objectResponse.mascantidad = await object.cantidad(MASVENDIDO);
        objectResponse.masingresos = await object.ingresos(MASINGRESOS);
    
        const currenDate = getDate();
    
        await pool.query("START TRANSACTION");
        const result = await pool.query(`INSERT INTO CierredeCaja(PuntoDeVenta_idPuntodeVenta,fehaCierre,totalVentasDia) VALUES(${id},${currenDate},${objectResponse.total})`);
        const currentID = result.insertId;
    
        for (let i = 0; i < 3; i++)
            if (objectResponse.masingresos[i])
                await pool.query(`INSERT INTO ProductosMasIngresosXDia (CierredeCaja_idCierredeCaja,Producto_idProducto,totalIngresosProducto) VALUES (${currentID},${objectResponse.masingresos[i].id},${objectResponse.masingresos[i].total})`);
            
        for (let i = 0; i < 3; i++)
        if (objectResponse.mascantidad[i])
        await pool.query(`INSERT INTO ProductosMasVendidosXDia (CierredeCaja_idCierredeCaja,Producto_idProducto,Unidades) VALUES (${currentID},${objectResponse.mascantidad[i].id},${objectResponse.mascantidad[i].total})`);    
        await pool.query("COMMIT;");
    
        return objectResponse;
    } catch (error) {
        pool.query("rollback");
        throw new Error("error en la creacion de Cierre de caja");
    }

}






module.exports = {
    list,
    get,
    getAll,
    getSchedule,
    getAStoresBySpecificProduct,
    cierreCajaTienda
}











function masVendidos(id) {
    const query = `WITH maximos (id,veces) AS
    (
        SELECT Carrito.Producto_idProducto, COUNT(Carrito.Producto_idProducto) as total
        from  Pedido, Carrito
        where Pedido.PuntoDeVenta_idPuntodeVenta = ${id} and Pedido.idPedido = Carrito.Pedido_idPedido
        GROUP by Carrito.Producto_idProducto
    )
    select  id,MAX(veces) as total
    FROM  maximos
    GROUP BY id
    ORDER BY  total DESC  
    lIMIT 3
    `
    return query;
}


function totalGanado(id) {
    const query = `SELECT sum(costoTotal) as total
    FROM Pedido
    where Pedido.PuntoDeVenta_idPuntodeVenta = ${id}`;
    return query;
}



function masingresos(id) {
    const query = `WITH maximos (id,veces) AS
    (
        SELECT Carrito.Producto_idProducto, COUNT(Carrito.Producto_idProducto)*Producto.precio as total
        from  Pedido, Carrito, Producto
        where Pedido.PuntoDeVenta_idPuntodeVenta = ${id} and Pedido.idPedido = Carrito.Pedido_idPedido
        and Producto.idProducto = Carrito.Producto_idProducto
        GROUP by Carrito.Producto_idProducto
    )
    select  id,MAX(veces) as total
    FROM  maximos
    GROUP BY id
    ORDER BY  total DESC  
    lIMIT 3`
    return query;
}


function getDate() {
    let ts = Date.now();
    let date_ob = new Date(ts);
    let day = date_ob.getDate();
    let month = date_ob.getMonth() + 1;
    let year = date_ob.getFullYear();
    let hour = date_ob.getHours();
    let minutes = date_ob.getMinutes();
    let seconds = date_ob.getSeconds();

    const fecha = `STR_TO_DATE('${year}-${month}-${day} ${hour}:${minutes}:${seconds}' , '%Y-%m-%d %T')`;


    return fecha;
}