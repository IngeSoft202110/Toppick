const store = require("./store");



function listarUsuario(id) {

  return new Promise(async (resolve, reject) => {
    try {
      if (!id) {
        console.error("[usuarioController]falta el id");
        return reject(new Error("faltan datos id"));
      }
      const user = await store.listarUsuario(id);
      return resolve(user);
    } catch (error) {
      return reject(error);
    }
  });


}

function editarUsuario(id, user) {
  return new Promise(async (resolve, reject) => {
    try {
      if (!user || !id) {
        console.error("[usuarioController]falta el metodo");
        return reject(new Error("faltan datos id o cliente"));
      }
      const response = await store.editarUsuario(id, user);
      return resolve(response);
    } catch (error) {
      return reject(error);
    }
  });
}


function isLoggedIn(id) {
  return new Promise(async (resolve, reject) => {
    try {
      if (!id) {
        console.error("[usuarioController]falta el metodo");
        return reject(new Error("faltan datos id"));
      }
      const response = await store.isLoggedIn(id);
      return resolve(response);
    } catch (error) {
      return reject(error);
    }
  });
}

module.exports = {
  listarUsuario,
  editarUsuario,
  isLoggedIn
}