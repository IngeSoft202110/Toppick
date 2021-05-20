const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
const validation = require('../../utils/middleware/validationHandler');

const {
    metodoPagoIdSchema,
    metodoPagoSchema,
    pagoSchema,
    updateMetodoPagoSchema} = require('../../utils/schemas/metodoPago');

//crea un metodo de pago
router.post('/',validation(metodoPagoSchema), function(req, res,next) {
     const registro = req.body;
     registro['metodo'].Cliente_IdCliente = req['user'].IdUsuario;
     controller.crearMetodoDePago(registro)
     .then(idMetodoPago=>{
         response.success(req,res,idMetodoPago,200);
     }).catch((e)=>{
        next(e);
     });
});

//lista un medio de pago por usuario
router.get('/', function(req, res,next) {
    const id = req['user'].IdUsuario;
    controller.ListarMedioPagoUsuario(id)
     .then(mediosPago=>{
         response.success(req,res,mediosPago,200);
     }).catch((e)=>{
        next(e);
     });
});

//edita un medio de pago de un usuario
router.patch('/',validation(updateMetodoPagoSchema), function(req,res,next){
    controller.EditarMedioPagoUsuario(req['user'].IdUsuario,req.body)
     .then((message)=>{
         response.success(req,res,message,200);
     }).catch((e)=>{
        next(e);
     });
});


module.exports = router;