const pool = require('../store/databaseConection');



/* 

    APP

*/


//lista todas los productos disponibles
async function list() {
    try {
        const productos = await pool.query("Select * from Producto");
        return productos;
    } catch(e) {
        console.log(e);
        throw new Error("error al listar los productos");
    }
}



//lista el producto solicitado por el id 
async function get(id){
    try {
        const producto = await pool.query("SELECT * FROM Producto WHERE idProducto = ?", [id]);
        return producto;
    } catch {
        throw new Error("error al listar el producto");
    }
}




//lista los acompañamientos de una especialidad
async function getAcompaniantes(id) {
    try {
        const query = `SELECT idAcompañamiento, nombreAcompañamiento, Acompañamiento.tipo 
        FROM Acompañamiento, AcompañamientoXEspecialidad, Especialidad, Producto 
        WHERE idProducto = ${id} and Producto_IdProducto = idProducto and Especialidad_Producto_idProducto = idProducto and idAcompañamiento = acompañamiento_idacompañamiento;
        `
        const acompanamientos = await pool.query(query);
        return acompanamientos;
    } catch {
        throw new Error("error al listar los acompañamientos del producto");
    }
}


//lista los productos de un combo
async function listarProductosComboById(id)
{
    try {
        const query = `SELECT  *
        FROM ProductoXCombo, Producto
        where ProductoXCombo.Producto_idProducto = Producto.idProducto And ProductoXCombo.Combo_Producto_idProducto = ?`;
        const productos = await pool.query(query,id);
        return productos;
    } catch (error) {
        console.log(error);
        throw new Error("error al listar los productos del combo");
    }
}
















/*

    ADMIN

*/ 




// crea un Producto

async function createProduct(producto) {
    try {
        await pool.query('INSERT INTO Producto set ?', [producto]);
        await pool.query("commit");
        return "insertado correctamente";
    } catch {
        pool.query("rollback");
        throw new Error("error al crear un producto");
    }
}



//Actualiza el inventario de una tienda

async function updateInevtory(id,productos){

    const object = {};

    object.updateProdcut = async (id, cantidad, idproducto) => pool.query(`UPDATE Catalogo  SET inventario = ${cantidad}  WHERE PuntoDeVenta_idPuntodeVenta = ${id} and Producto_idProducto = ${idproducto}`);

    object.FinalProducts = async (id,productos)=>{
        for (let i = 0; i < productos.length; i++)  await object.updateProdcut(id, productos[i].nuevaCantidad, productos[i].idProducto);
        return id;
    }

    try {
        const result = await object.FinalProducts(id,productos); 
        pool.query("commit");
        return result;
    } catch (error) {
        console.log(error);
        pool.query("rollback")
        throw new Error("error al actualizar el inventario");
    }
}


/*
// Actualiza un producto
async function updateProduct(producto) {
    try {
        await pool.query('UPDATE producto set ? WHERE idProducto = ?', [producto, producto.idProducto]);
        return;
    } catch {
        return new Error("[productosDB]Error interno");
    }
}
*/
//Elimina un producto

async function deleteProduct(id) {
    try {
        await pool.query('DELETE FROM producto WHERE idProducto = ?', [id]);
        return;
    } catch {
        throw new Error("error al eliminar un producto");
    }
}

module.exports = {
    list,
    get,
    getAcompaniantes,
    listarProductosComboById,


    createProduct,
    updateInevtory,
    deleteProduct
}

