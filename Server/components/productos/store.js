const db = require('../../database/productosDB');
//const tabla = "productos";


module.exports = {
    //app
    listarProductos:  ()=>{
        return new Promise(async (resolve, reject) => {
            try{
                const listaProductos =  await db.list();
                return resolve(listaProductos);
            }catch(e){
               reject(e);
            }
     });
    },

    listarProductobyId:  (id)=>{
        return new Promise( async(resolve, reject) => {
            try{
                const listaProductos =  await db.get(id);
                return resolve(listaProductos);
            }catch(e){
               reject(e);
            }
     });
    },

    listarAcompanantesProductoById:  (id)=>{
        return new Promise( async(resolve, reject) => {
            try{
                const listaAcompanamientos =  await db.getAcompaniantes(id);
                return resolve(listaAcompanamientos);
            }catch(e){
               reject(e);
            }
     });
    },

    listarProductosComboById:  (id)=>{
        return new Promise( async(resolve, reject) => {
            try{
                const listaProductos =  await db.listarProductosComboById(id);
                return resolve(listaProductos);
            }catch(e){
               reject(e);
            }
     });
    },















    //Admin
    crearProducto:  (producto)=>{
        return new Promise( async (resolve, reject) => {
            try{
                await db.createProduct(producto);
                return resolve("creado Correctamente");
            }catch(e){
               reject(e);
            }
     });
    },

    modificarInventario: (id,productos)=>{
        return new Promise( async(resolve, reject) => {
            try{
                await db.updateInevtory(id,productos);
                return resolve("actualizado Correctamente");
            }catch(e){
               reject(e);
            }
     });
    }
}