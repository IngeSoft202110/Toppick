const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
const notificacion = require('../../utils/notifications/push_notification');

const {
    pedidoIdSchema,
    createPedidoSchema,
    updatePedidoSchema
    } = require('../../utils/schemas/pedido');

const validation = require('../../utils/middleware/validationHandler');


/*

    APP

*/


const stores = {};

function initializeSockets(io)
{
     io.on('connection', socket => {
        socket.on('new_Store', idStore => {
            console.log(idStore);
          socket.storeid = idStore;
          stores[idStore] = socket;
        })
        //crea un pedido

        router.post('/',validation(createPedidoSchema), function (req, res,next) {
            const storeid = req.body.PuntoDeVenta_idPuntodeVenta;
            req.body.Cliente_IdCliente = req['user'].IdUsuario;
            controller.crearOrden(req.body,res)
                .then(idOrden => {
                    if(idOrden === "no hay fondos suficientes") response.error(req,res,"no hay fondos suficientes",400);
                    
                    socket.broadcast.emit('pedidos',req.body);
                    response.success(req,res,"creado Correctamente",201);
                }).catch((e) => {
                    next(e);
                });
            
            
        });
      });
}



//listar pedido por id
router.get('/pedido/:id', function (req, res,next) {
    const id = req.params.id;
    controller.listarOrdenbyId(id)
        .then(orden => {
            response.success(req, res, orden, 200);
        }).catch((e) => {
            next(e);
        });
});


//lista los pedidos realizados por un usuario
router.get('/usuario', function (req, res,next) {
    
    const id = req['user'].IdUsuario;
    controller.listarOrdenesPorIdUsuario(id)
        .then(orden => {
            response.success(req, res, orden, 200);
        }).catch((e) => {
            next(e);
        });
});





/*

    ADMIN

*/


//actualiza el estado de un pedido
router.patch('/pedido/:id', validation(updatePedidoSchema), function (req, res,next) {
    const id = req.params.id;
    const status = req.body.estadoPedido;
    const rejectReason = req.body.razonRechazo || "";
    controller.modificarOrden(id, status, rejectReason)
        .then(token => {
            notificacion.notificarAUnUsuario(token,status);
            response.success(req, res, "se realizo la actualizacion correctamente", 200);
        }).catch((e) => {
            next(e);
        });
});




//listar Historial pedidos del dia 

router.get( '/tienda', function (req, res,next) {
    const id = req['user'].IdUsuario;
    console.log(id);
    controller.listarOrdenesPorIdTienda(id)
        .then(ordenes => {
            response.success(req, res, ordenes, 200);
        }).catch((e) => {
            next(e);
        });
});








module.exports = {router,initializeSockets};

