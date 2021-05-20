const store = require('./store');



/*

    APP

*/

function crearReseñaProducto(data)
{
    return new Promise((resolve, reject) => {
        try {
            resolve(store.crearReseñaProducto(data));
        } catch (error) {
            reject(error);   
        }
    })
}

function listarReseñaProducto(id)
{
    return new Promise((resolve, reject) => {
        try {
            resolve(store.listarReseñaProducto(id));
        } catch (error) {
            reject(error);   
        }
    })
}



/*

    ADMIN

*/

function crearReseñaTienda(data)
{
    return new Promise((resolve, reject) => {
        try {
            resolve(store.crearReseñaTienda(data));
        } catch (error) {
            reject(error);   
        }
    })
}

function listarReseñaTienda(id)
{
    return new Promise((resolve, reject) => {
        try {
            resolve(store.listarReseñaTienda(id));
        } catch (error) {
            reject(error);   
        }
    })
}

module.exports = 
{
    crearReseñaProducto,
    listarReseñaProducto,
    crearReseñaTienda,
    listarReseñaTienda 
}