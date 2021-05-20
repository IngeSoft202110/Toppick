const db = require('../../database/pagosDB');


module.exports = {
    crearMetodoDePago:  (metodo)=>{
        return new Promise( async (resolve, reject) => {
            try{
                 await db.crearMetodoDePago(metodo);
                return resolve("medios de pago creados Correctamente");
            }catch(e)
            {
                reject(e);
            }
     });
    },

    ListarMedioPagoUsuario: (id)=>{
        return new Promise( async (resolve, reject) => {
            try{
                const response = await db.ListarMedioPagoUsuario(id);
                return resolve(response);
            }catch(e)
            {
                reject(e);
            }
     });
    },

    EditarMedioPagoUsuario:(id,metodo)=>{
        return new Promise( async (resolve, reject) => {
            try{
                 await db.EditarMedioPagoUsuario(id,metodo);
                return resolve("medios de pago actualizados correctamente");
            }catch(e)
            {
                reject(e);
            }
     });
    },

   /* generarPago:(id,valor)=>{
        return new Promise( async (resolve, reject) => {
            try{
                await db.generarPago(id,valor);
                return resolve("Se Realizo el cobro Correctamente");
            }catch(e)
            {
                reject(e);
            }
     });
    }*/

}