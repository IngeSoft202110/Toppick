const pool = require('../store/databaseConection');
const boom = require('@hapi/boom');



async function crearMetodoDePago(info) {
    const { metodo, opcionSeleccionada } = info;
    let aux;
    let query1;
    if (opcionSeleccionada.opcion == "PSE") {
        aux = { MétodoDePago_Cliente_IdCliente: metodo.Cliente_IdCliente, numeroCuenta: opcionSeleccionada.identificador };
        query1 = `Select * from ${opcionSeleccionada.opcion} where numeroCuenta = ${aux.numeroCuenta}`;
    }
    else {
        aux = { MétodoDePago_Cliente_IdCliente: metodo.Cliente_IdCliente, numeroCelular: opcionSeleccionada.identificador };
        query1 = `Select * from ${opcionSeleccionada.opcion} where numeroCelular = ${aux.numeroCelular}`;
    }


    try {

        await pool.query("START TRANSACTION")

        const result = await pool.query(`Select * from MétodoDePago  where Cliente_IdCliente = ${metodo.Cliente_IdCliente}`);
        if (result.length <= 0) {
            await pool.query(`INSERT INTO MétodoDePago (Cliente_IdCliente,saldoTotal) values (${metodo.Cliente_IdCliente},${metodo.saldoTotal})`);
            const result2 = await pool.query(query1);
            if (result2.length <= 0)
                await pool.query(`INSERT INTO ${opcionSeleccionada.opcion}  SET ?`, aux);
            else
                throw "ya esta registrado, intente nuevamente";
        } else {
            const result = await pool.query(query1);
            if (result.length <= 0)
                await pool.query(`INSERT INTO ${opcionSeleccionada.opcion}  SET ?`, aux);
            else
                throw "ya esta registrado, intente nuevamente";
        }
        await pool.query("COMMIT;");

    } catch (error) {
        pool.query("rollback");
        if (error === "ya esta registrado, intente nuevamente")
            throw boom.conflict("ya esta registrado, intente nuevamente");
        else
            throw new Error("error en la creacion de Cierre de caja");
    }
}



async function ListarMedioPagoUsuario(id) {
    const object = {}

    object.saldoFromUser = async (id) => await pool.query(`SELECT saldoTotal FROM MétodoDePago  Where Cliente_IdCliente = ${id}`);
    object.nequiFromUser = async (id) => await pool.query(`SELECT numeroCelular FROM Nequi Where MétodoDePago_Cliente_IdCliente = ${id}`);
    object.pseFromUser = async (id) => await pool.query(`SELECT numeroCuenta FROM PSE Where MétodoDePago_Cliente_IdCliente = ${id}`);
    object.daviplataFromUser = async (id) => await pool.query(`SELECT numeroCelular FROM Daviplata  Where MétodoDePago_Cliente_IdCliente = ${id}`);

    object.superCall = async (id) => {
        const metdosPagoUsuario = {
            saldoTotal: await object.saldoFromUser(id),
            daviplata: await object.daviplataFromUser(id),
            nequi: await object.nequiFromUser(id),
            pse: await object.pseFromUser(id)
        };
        return metdosPagoUsuario;
    }

    try {
        return object.superCall(id);
    } catch (error) {
        throw new Error("error en listar los medios de pago del usuario");
    }

}


async function EditarMedioPagoUsuario(id, metodo) {

    const object = {}
    object.exist = async (id) => pool.query(`select * from MétodoDePago where Cliente_IdCliente = ${id}`);
    object.existAccount = async (id) => pool.query(`select * from ${metodo.metodo}  where MétodoDePago_Cliente_IdCliente = ${id}`);

    const a = await object.exist(id);
    const b = (metodo.metodo != "") ? await object.existAccount(id) : [{}];

    if (a.length <= 0 || b.length <= 0)
        throw boom.notAcceptable("No tienes metodos de pago registrados");

    const queries = {};
    queries.updateSaldo = (id, saldo) => `UPDATE MétodoDePago SET saldoTotal=${saldo} WHERE Cliente_IdCliente = ${id}`;
    queries.updateOtrosInfo = (id, cel, tabla) => `UPDATE ${tabla} SET numeroCelular=${cel} WHERE MétodoDePago_Cliente_IdCliente = ${id}`;
    queries.updatePSEInfo = (id, cuenta) => `UPDATE PSE SET numeroCuenta=${cuenta} WHERE MétodoDePago_Cliente_IdCliente = ${id}`;


    try {
  
        await pool.query("START TRANSACTION")
        if (metodo.saldo !== 0){
    
            await pool.query(queries.updateSaldo(id, metodo.saldo));
            if (metodo.metodo != ""){
                if (metodo.metodo === "PSE")
                    await pool.query(queries.updatePSEInfo(id, metodo.identificador));
                else
                    await pool.query(queries.updateOtrosInfo(id, metodo.identificador, metodo.metodo));
            }   
        }else{
    
            if (metodo.metodo != ""){
                if (metodo.metodo === "PSE")
                    await pool.query(queries.updatePSEInfo(id, metodo.identificador));
                else
                    await pool.query(queries.updateOtrosInfo(id, metodo.identificador, metodo.metodo));
            }  
        }
    
        await pool.query("COMMIT;");
    } catch (error) {
        pool.query("rollback");
        throw new Error("error en actualizar metodos");
    }
    
}



async function generarPago(id, valor) {
    const object = {};
    object.getMetodosPago = async (id) => pool.query(`select * from MétodoDePago where Cliente_IdCliente  = ${id}`);
    object.getSaldo = async (id) => pool.query(`select saldoTotal from MétodoDePago where Cliente_IdCliente  = ${id}`);
    object.updateSaldo = async (id, value) => pool.query(`UPDATE MétodoDePago SET saldoTotal = ${value} WHERE Cliente_IdCliente = ${id}`);
    try {
        const metodos = await object.getMetodosPago(id);
        if (metodos.length < 1) return "no hay metodos de pago registrados";
        const full = await object.getSaldo(id);
        if ((full[0].saldoTotal - valor) < 0) return "no hay fondos suficientes";
        const value = full[0].saldoTotal - valor;
        await object.updateSaldo(id, value);
    } catch (error) {
        throw new Error("error en el pago")
    }
}


module.exports = {
    crearMetodoDePago,
    ListarMedioPagoUsuario,
    EditarMedioPagoUsuario,
    generarPago
}