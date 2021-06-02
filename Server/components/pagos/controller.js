const store = require("./store");


/*

    APP

*/


//crea un metodo de pago por un  usuario 

function crearMetodoDePago(metodo) {
  return new Promise(async (resolve, reject) => {
    try {
      if (!metodo) {
        return reject(new Error("faltan datos"));
      }
      const id = await store.crearMetodoDePago(metodo);
      return resolve(id);
    } catch (error) {
      return reject(error);
    }
  });
}



function ListarMedioPagoUsuario(id) {
    return new Promise(async (resolve, reject) => {
      try {   
        if (!id) {
          console.error("[pagoController]falta el id");
          return reject(new Error("faltan datos"));
        }
        const list = await store.ListarMedioPagoUsuario(id);
        return resolve(list);
      } catch (error) {
        return reject(error);
      }
    })
}

function EditarMedioPagoUsuario(id, metodo) {
    return new Promise(async (resolve, reject) => {
      try {
        if (!metodo || !id) {
          console.error("[pagoController]falta el metodo");
          return reject(new Error("faltan datos"));
        }
        if (!metodo.metodo && metodo.metodo.length < 1 && !metodo.identificador && metodo.identificador.length < 1 && !metodo.saldo) return reject("error en los datos")
        const response = await store.EditarMedioPagoUsuario(id, metodo);
        return resolve(response);
      } catch (error) {
        return reject(error);
      }
    }); 
}



module.exports =
{
  crearMetodoDePago,
  ListarMedioPagoUsuario,
  EditarMedioPagoUsuario,
}