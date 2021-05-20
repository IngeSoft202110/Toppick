const db = require('../../database/usuariosDB');



module.exports = {
    listarUsuario:(id)=>{
        return new Promise( async (resolve, reject) => {
            try{
                const response = await db.listarUsuario(id);
                return resolve(response);
            }catch(e)
            {
                reject(e);
            }
     });
    },

    editarUsuario: (id,user)=>{
        return new Promise( async (resolve, reject) => {
            try{
                const response = await db.editarUsuario(id, user);
                return resolve(response);
            }catch(e)
            {
                reject(e);
            }
     });
    }, 

}