const pool = require('../store/databaseConection');





async function listarUsuario(id){
    const object = {};
    object.listar = async (id) => pool.query(`select * from Cliente where IdCliente = ${id}`); 

    try {
         const response = await object.listar(id);
         return response[0];   
    } catch (error) {
        throw new Error ("error en listar usuario");
    }
}

async function editarUsuario (id,usuario)
{

    const query1 = `UPDATE  Cliente set 
    nombreCompleto = '${usuario.nombreCompleto}',
    tipoDocumento = '${usuario.tipoDocumento}',
    idDocumento = ${usuario.idDocumento},
    celular = ${usuario.celular}
    where IdCliente = ${id}`;

    const object = {};
    object.updateInfo = async (query1) => {
        await pool.query("START TRANSACTION")
        await pool.query(query1);
        await pool.query("COMMIT;");
    }


    try {
        await object.updateInfo(query1);
        return "realizada correctamente";
    } catch (error) {
        pool.query("rollback");
        throw new Error ("error en actualizar usuario");
    }
}



async function isLoggedIn(id)
{
    const response = await pool.query(`SELECT * FROM sessions WHERE data = '{"cookie":{"originalMaxAge":null,"expires":null,"httpOnly":true,"path":"/"},"passport":{"user":${id}}}' `);
    return response.length;
}




module.exports = {
    listarUsuario,
    editarUsuario,
    isLoggedIn
}