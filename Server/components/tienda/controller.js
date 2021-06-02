const store = require('./store');


function listarTiendas() {
    return new Promise((resolve, reject) => {
        try {
            resolve(store.listarTiendas());
        } catch (error) {
            return reject(error);
        }
    })
}


function listarTiendasProductos(id) {
    return new Promise((resolve, reject) => {
        try {
            resolve(store.listarTiendasProductos(id));
        } catch (error) {
            return reject(error);
        }
    })
}



function listarTiendabyId(id) {
    return new Promise((resolve, reject) => {
        try {
            if(!id){
                console.error('[tiendaController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            resolve(store.listarTiendabyId(id));
        } catch (error) {
            return reject(error);
        }
    })   
}


function listarHorarioTienda(id) {
    return new Promise((resolve, reject) => {
        try {
            if(!id){
                console.error('[tiendaController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            resolve(store.listarHorarioTienda(id));
        } catch (error) {
            return reject(error);
        }
    })   
}


function listarTiendaPorProducto(id) {
    return new Promise((resolve, reject) => {
        try {
            if(!id){
                console.error('[tiendaController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            resolve(store.listarTiendaPorProducto(id));
        } catch (error) {
            return reject(error);
        }
    })   
}

function cierreCajaTienda(id){
    return new Promise((resolve, reject) => {
        try {
            if(!id){
                console.error('[tiendaController] No hay id');
                return reject(new Error("faltan datos id"));
            }
            resolve(store.cierreCajaTienda(id));
        } catch (error) {
            return reject(error);
        }
    }) 
}


function cerrarTienda (id)  {
    return new Promise((resolve, reject) => {
        try {
            return resolve(store.cerrarTienda(id));
        } catch (e) {
            reject(e);
        }
    });
}

function abrirTienda (id)  {
    return new Promise((resolve, reject) => {
        try {
            return resolve(store.abrirTienda(id));
        } catch (e) {
            reject(e);
        }
    });
}







module.exports = {
    listarTiendas,
    listarTiendabyId,
    listarTiendasProductos,
    listarHorarioTienda,
    listarTiendaPorProducto,
    cierreCajaTienda,
    cerrarTienda,
    abrirTienda
};