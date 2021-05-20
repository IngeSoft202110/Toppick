const db = require('../../database/pedidoDB');

const tabla = "pedidos";


module.exports = {
    listarOrdenbyId:  (id)=>{
        return new Promise( async(resolve, reject) => {
            try {
                const orden =  await db.listarOrdenbyId(id);
                return resolve(orden);
            } catch (error) {
                return reject(error);
            }

     });
    },
    crearOrden:  (orden,res)=>{
        return new Promise( async (resolve, reject) => {
            try{
                const response = await db.createOrder(orden,res);
                return resolve(response);
            }catch(e)
            {
                reject(e);
            }
     });
    },

    listarOrdenesPorIdUsuario:  (id)=>{
        return new Promise( async(resolve, reject) => {
            try {
                const ordenes =  await db.listarOrdenesPorIdUsuario(id);
                return resolve(ordenes);
            } catch (error) {
                return reject(error);
            }

     });
    },





    modificarOrden: (id,status,razonRechazo=undefined)=>{
        return new Promise( async(resolve, reject) => {
            try {
                if(razonRechazo){ const order =  await db.updateSatus(id,status,razonRechazo);return resolve(order);}
                else {const order =  await db.updateSatus(id,status);return resolve(order);}
                
            } catch (error) {
                 return reject(error);
            }
     });
    },

    listarOrdenesPorIdTienda:  (id)=>{
        return new Promise( async(resolve, reject) => {
            try {
                const ordenes =  await db.listarOrdenesPorIdTienda(id);
                return resolve(ordenes);
            } catch (error) {
                return reject(error);
            }
     });
    },
}




