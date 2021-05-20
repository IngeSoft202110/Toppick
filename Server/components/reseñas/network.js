const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
const createResenaSchema = require('../../utils/schemas/reseña'); 
const validation = require('../../utils/middleware/validationHandler');



/*

   PRODUCTO

*/


router.post('/producto/:id', validation(createResenaSchema), function(req, res) {
   const data = req.body;
   data.Cliente_IdCliente = req['user'].IdUsuario;
   data.Producto_idProducto = req.params.id;
   controller.crearReseñaProducto(data)
   .then(message=>{
       response.success(req,res,message,200);
   }).catch((e)=>{
       console.log(e);
       response.error(req,res,"Internal error",500,e);
   });
});


router.get('/producto/:id', function(req, res) {
   const id = req.params.id;
   controller.listarReseñaProducto(id)
     .then(usuario=>{
         response.success(req,res,usuario,200);
     }).catch((e)=>{
         response.error(req,res,"Internal error",500,e);
     });
});


/*

   TIENDA

*/

router.post('/tienda/:id', validation(createResenaSchema), function(req, res) {
   const data = req.body;
   data.Cliente_IdCliente = req['user'].IdUsuario;
   data.PuntoDeVenta_idPuntodeVenta = req.params.id;
   controller.crearReseñaTienda(data)
   .then(idData=>{
       response.success(req,res,idData,200);
   }).catch((e)=>{
       response.error(req,res,"Internal error",500,e);
   });
});


router.get('/tienda/:id', function(req, res) {
   const id = req.params.id;
   controller.listarReseñaTienda(id)
     .then(usuario=>{
         response.success(req,res,usuario,200);
     }).catch((e)=>{
         response.error(req,res,"Internal error",500,e);
     });
});

module.exports = router;