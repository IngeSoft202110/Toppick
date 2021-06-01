const store = require("./store");


/*

    APP

*/


//crea un pedido

function crearOrden(orden,res) {
    return new Promise(async (resolve, reject) => {
        try {

            if (!orden) {
                console.error("[pedidoController]falta el pedido");
                return reject(new Error("faltan datos pedido"));
            }
            const response =  await store.crearOrden(orden,res);
            return resolve(response);

        } catch (error) {
            console.log("error in controller pedido: " + error);
            return reject(error);
        }
    });
}


//listar pedido por id

function listarOrdenbyId(id) {
    return new Promise(async (resolve, reject) => {
        try {
            if (id == undefined) {
                console.error('[predidoController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            return await resolve(store.listarOrdenbyId(id));
        } catch (error) {
            return reject(error);
        }
    });
}


function listarOrdenesPorIdUsuario(id) {
    return new Promise(async (resolve, reject) => {
        try {
            if (!id) {
                console.error('[predidoController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            return await resolve(store.listarOrdenesPorIdUsuario(id));
        } catch (error) {
            return reject(error);
        }
    });
}





/*

    ADMIN

*/

function modificarOrden(id, status, razonRechazo = "") {
    return new Promise(async (resolve, reject) => {
        try {
            if (!id) {
                console.error('[predidoController] Falta de datos');
                return reject(new Error("faltan datos id"));
            }
            return await resolve(store.modificarOrden(id, status, razonRechazo));
        } catch (error) {
            return reject(error);
        }
    });
}

function listarOrdenesPorIdTienda(id) {
    return new Promise(async (resolve, reject) => {
        try {
            if (!id) {
                console.error('[predidoController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            return await resolve(store.listarOrdenesPorIdTienda(id));
        } catch (error) {
            return reject(error);
        }
    });

}

function listarTodaLaOrdenPorId(id) {
    return new Promise(async (resolve, reject) => {
        try {
            if (!id) {
                console.error('[predidoController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            return await resolve(store.listarTodaLaOrdenPorId(id));
        } catch (error) {
            return reject(error);
        }
    });

}


module.exports = {
    crearOrden,
    listarOrdenbyId,
    listarOrdenesPorIdUsuario,



    modificarOrden,
    listarOrdenesPorIdTienda,
    listarTodaLaOrdenPorId
};



