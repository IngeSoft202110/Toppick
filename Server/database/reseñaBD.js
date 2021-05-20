const pool = require('../store/databaseConection');




async function crearReseñaProducto(data)
{
    try {
      await  pool.query('INSERT INTO ReseñaProducto SET ?',data);
      await  pool.query("COMMIT");
    } catch (error) {
        throw new Error("error al crear la reseña");
    }
}



async function listarReseñaProducto(id)
{
    try {
           const response = await pool.query('select * from ReseñaProducto where Producto_idProducto = ?',id);    
           return response;
    } catch (error) {
        throw new Error("error al listar las reseñas productos");
    }
}

async function crearReseñaTienda(data)
{
    try {
      await  pool.query('INSERT INTO ReseñaPuntoDeVenta SET ?',data);
      await  pool.query("COMMIT");
    } catch (error) {
        throw new Error("error al crear la reseña");
    }
}



async function listarReseñaTienda(id)
{
    try {
           const response = await pool.query('select * from ReseñaPuntoDeVenta where PuntoDeVenta_idPuntodeVenta = ?',id);    
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