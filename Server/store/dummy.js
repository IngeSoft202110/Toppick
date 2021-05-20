const db = require('./data');

async function list(tabla) {
    return db[tabla] || [];
}

async function get(tabla, id) {
    let col = await list(tabla);
    if(tabla !== 'pedidos')
    return col.filter(item => item.id === id)[0] || null;
    else
    return col.filter(item => item.idPedido == id)[0] || null;
}

async function getAll(tabla, id) {
    let col = await list(tabla);
    const valor = col.filter(item => item.id === id)[0] || null;
    return (valor)?valor.productos:null;
}

async function getSchedule(tabla, id) {
    let col = await list(tabla);
    const valor = col.filter(item => item.id === id)[0] || null;
    return (valor)?valor.horario:null;
}

async function getASpecificProduct(tabla, id) {
    let listaTienda =  list(tabla);
    let nuevalista2 = listaTienda.filter( (item) => item.productos.find( p => p.id === id));
    return nuevalista2;
}

async function upsert(tabla, data) {
    if (!db[tabla]) {
        db[tabla] = [];
    }
    db[tabla].push(data);
}

async function remove(tabla, id) {
    return true;
}

async function query(tabla, q) {
    let col = await list(tabla);
    let keys = Object.keys(q);
    let key = keys[0];
    
    return col.filter(item => item[key] === q[key])[0] || null;
}


async function updateSatus(tabla,id,status,razonRechazo = ""){
    const order = await get(tabla,id);
    if(order !== null){
        order.estadoPedido = status;
        order.razonRechazo = razonRechazo;
    }
}




module.exports = {
    list,
    get,
    upsert,
    remove,
    query,
    getAll,
    getSchedule,
    getASpecificProduct,
    updateSatus
};