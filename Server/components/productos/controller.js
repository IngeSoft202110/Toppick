const store = require('./store');

//App

function listarProductos() {
    return new Promise((resolve, reject) => {
        try {
            resolve(store.listarProductos());
        } catch (error) {
            reject(error);   
        }
    })
}


function listarProductobyId(id) {
    return new Promise((resolve, reject) => {
        if(!id){
            console.error('[productController] No hay id');
            return reject(new Error("faltan datos id"));
        }
        try {
            resolve(store.listarProductobyId(id));
        } catch (error) {
            reject(error);
        }
    })   
}

function listarAcompanantesProductoById(id) {
    return new Promise((resolve, reject) => {
        if(!id){
            console.error('[productController] No hay id');
            return reject(new Error("faltan datos id"));
        }
        try {
            resolve(store.listarAcompanantesProductoById(id));
        } catch (error) {
            reject(error);
        }
    })   
}



function listarProductosComboById(id) {
    return new Promise((resolve, reject) => {
        if(!id){
            console.error('[productController] No hay id');
            return reject(new Error("faltan datos id"));
        }
        try {
            resolve(store.listarProductosComboById(id));
        } catch (error) {
            reject(error);
        }
    })   
}




//Admin

function crearProducto(producto) {
    return new Promise(async (resolve, reject) => {
        try {
            if (!producto) {
                console.error('[productController] No hay producto');
                return reject(new Error("faltan datos id"));
            }
            const result = await store.crearProducto(producto);
            resolve(result);
        } catch (error) {
            return reject(error);
        }
    });
}

async function modificarInventario(id,productos) {
    return new Promise(async (resolve, reject) => {
        try {
            if (!id || !productos) {
                console.error('[productController] No hay productos a actualizar o id');
                return reject(new Error("faltan datos id"));
            }
            const result = await store.modificarInventario(id,productos);
            resolve(result);
        } catch (error) {
            return reject(error);
        }
    })
}



module.exports = {
    //app
    listarProductos,
    listarProductobyId,
    listarAcompanantesProductoById,
    listarProductosComboById,


    //admin    
    crearProducto,
    modificarInventario,
};