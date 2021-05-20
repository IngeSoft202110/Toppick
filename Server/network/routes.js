const usuario = require('../components/usuarios/network');
const tienda = require('../components/tienda/network');
const pedidos = require('../components/pedidos/network');
const productos = require('../components/productos/network');
const pagos = require('../components/pagos/network');
const resenas = require('../components/reseñas/network');
const { isLoggedIn } = require('../utils/auth/auth');

const routes = function (server) {
    server.use('/productos',isLoggedIn,productos);
    server.use('/tienda',isLoggedIn,tienda);
    server.use('/pedidos',isLoggedIn,pedidos.router);
    server.use('/pagos',isLoggedIn,pagos);
    server.use('/usuarios', usuario);
    server.use('/resena',isLoggedIn, resenas);
}

module.exports = routes;