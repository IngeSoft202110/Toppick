const db = require('../../database/reseñaBD.js');


module.exports = 
{
    crearReseñaProducto: (data)=>{
        return new Promise( async(resolve, reject) => {
            try{
                await db.crearReseñaProducto(data);
                return resolve("reseña creada correctamente");
            }catch(e){
               reject(e);
            }
     });
    },

    listarReseñaProducto:(id)=>{
        return new Promise( async(resolve, reject) => {
            try{
                const listaReseñas =  await db.listarReseñaProducto(id);
                return resolve(listaReseñas);
            }catch(e){
               reject(e);
            }
     });
    },

    crearReseñaTienda:(data)=>{
        return new Promise( async(resolve, reject) => {
            try{
                await db.crearReseñaTienda(data);
                return resolve("reseña creada correctamente");
            }catch(e){
               reject(e);
            }
     });
    },

    listarReseñaTienda:(id)=>{
        return new Promise( async(resolve, reject) => {
            try{
                const listaReseñas  =  await db.listarReseñaTienda(id);
                return resolve(listaReseñas);
            }catch(e){
               reject(e);
            }
     });
    }
}