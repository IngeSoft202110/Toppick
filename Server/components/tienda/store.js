const db = require('../../database/tiendaDB');
const boom = require('@hapi/boom');

//const tabla = "tiendas";


module.exports = {
    listarTiendas: () => {
        return new Promise(async (resolve, reject) => {
            try {
                const listaTienda = await db.list();
                if(!listaTienda)
                    return reject(new Error("no hay tiendas"))
                else
                    return resolve(listaTienda);
            } catch (e) {
                return reject(e);
            }
        }
        );
    },

    listarTiendabyId: (id) => {
        return new Promise(async (resolve, reject) => {
            try {
                const listaTienda = await db.get(id);
                if(!listaTienda)
                    return reject(new Error("no hay tienda con ese id"))
                else
                    return resolve(listaTienda);
            } catch (e) {
                reject(e);
            }
        });
    },

    listarTiendasProductos: (id) => {
        return new Promise(async (resolve, reject) => {
            try {
                const listaProductos = await db.getAll(id);
                if (!listaProductos) reject(new Error("no hay productos"));
                return resolve(listaProductos);
            } catch (e) {
                reject(e);
            }
        });
    },
    listarHorarioTienda: (id) => {
        return new Promise(async (resolve, reject) => {
            try {
                const listaHorarios = await db.getSchedule(id);
                if (!listaHorarios) reject(new Error("No hay horarios para esta tienda"));
                return resolve(listaHorarios);
            } catch (e) {
                reject(e);
            }
        });
    },
    listarTiendaPorProducto: (id) => {
        return new Promise(async (resolve, reject) => {
            try {
                const listaTienda = await db.getAStoresBySpecificProduct(id);
                if (!listaTienda) reject(new Error("No hay tienda para este producto"));
                return resolve(listaTienda);
            } catch (e) {
                reject(e);
            }
        });
    },

    cierreCajaTienda:(id) => {
        return new Promise(async (resolve, reject) => {
            try {
                const cierre = await db.cierreCajaTienda(id);
                if (!cierre) reject(("No hay cierre de caja para esta tienda"));
                return resolve(cierre);
            } catch (e) {
                reject(e);
            }
        });
    },


    cerrarTienda: (id) => {
        return new Promise(async (resolve, reject) => {
            try {
                 await db.cerrarTienda(id);
                return resolve("cierre");
            } catch (e) {
                reject(e);
            }
        });
    },

    abrirTienda: (id) => {
        return new Promise(async (resolve, reject) => {
            try {
                 await db.abrirTienda(id);
                return resolve("apertura");
            } catch (e) {
                reject(e);
            }
        });
    },



}
