const pool = require('../store/databaseConection');




async function crearReseñaProducto(data)
{
    try {
      await  pool.query('INSERT INTO ReseñaProducto SET ?',data);
      const response = await pool.query(`Select calificacion from Producto where Producto.idProducto = ${data.Producto_idProducto}`);
      let value = response[0].calificacion || 0;
      value = (value === 0)? data.calificacion:(value + data.calificacion) / 2
      await  pool.query(`UPDATE Producto
      SET calificacion = ${value}
      WHERE Producto.idProducto = ${data.Producto_idProducto}`)
      await  pool.query("COMMIT");
    } catch (error) {
        throw new Error("error al crear la reseña");
    }
}



async function listarReseñaProducto(id)
{
    try {
           const response = await pool.query(`select nombreCompleto,calificacion,descripcion from ReseñaProducto,Cliente where Cliente.IdCliente = ReseñaProducto.Cliente_IdCliente and Producto_idProducto = ${id}`);    
           return response;
    } catch (error) {
        throw new Error("error al listar las reseñas productos");
    }
}

async function crearReseñaTienda(data)
{
    try {
      await  pool.query('INSERT INTO ReseñaPuntoDeVenta SET ?',data);
      const response = await pool.query(`Select calificacion from PuntoDeVenta where PuntoDeVenta.idPuntodeVenta = ${data.PuntoDeVenta_idPuntodeVenta}`);
      let value = response[0].calificacion || 0;
      value = (value === 0)? data.calificacion:(value + data.calificacion) / 2
      await  pool.query(`UPDATE PuntoDeVenta
      SET calificacion = ${value}
      WHERE PuntoDeVenta.idPuntodeVenta = ${data.PuntoDeVenta_idPuntodeVenta}`)
      await  pool.query("COMMIT");
    } catch (error) {
        console.log(error)
        throw new Error("error al crear la reseña");
    }
}



async function listarReseñaTienda(id)
{
    try {
           const response = await pool.query(`select nombreCompleto,calificacion,descripcion from ReseñaPuntoDeVenta,Cliente where Cliente.IdCliente = ReseñaPuntoDeVenta.Cliente_IdCliente and PuntoDeVenta_idPuntodeVenta = ${id}`);    
           return response;
    } catch (error) {
        throw new Error("error al listar las reseñas tienda");
    }
}


module.exports = {
    crearReseñaProducto,
    listarReseñaProducto,
    crearReseñaTienda,
    listarReseñaTienda
}