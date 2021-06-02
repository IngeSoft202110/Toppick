const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
const validation = require('../../utils/middleware/validationHandler');
const {
    productIdSchema,
    createProductSchema,
    updateProductSchema,
    productIventarioSchema,
    carritoSchema
} = require('../../utils/schemas/producto');

const { isLoggedIn } = require('../../utils/auth/auth');
//APP

//lista todos los productos
router.get('/',isLoggedIn,function(req, res,next) {
    controller.listarProductos()
    .then(productos=>{
        response.success(req,res,productos,200);
    }).catch((e)=>{
        next(e);
    });
});


//lista un producto por id
router.get('/:id',function(req, res,next) {
    const id = req.params.id;
    controller.listarProductobyId(id)
    .then(productos=>{
        response.success(req,res,productos,200);
    }).catch((e)=>{
        next(e);
    });
});


//lista los acompañantes de un producto por id
router.get('/acompanamientos/:id',isLoggedIn,function(req,res,next){
    const id = req.params.id;
    controller.listarAcompanantesProductoById(id)
    .then(acompanantes=>{
        response.success(req,res,acompanantes,200);
    }).catch((e)=>{
        next(e);
    });

});



//lista los productos de un combo dado su id
router.get('/combo/:id',isLoggedIn,function(req,res,next) {
    const id = req.params.id;
    controller.listarProductosComboById(id)
    .then(productos=>{
        response.success(req,res,productos,200);
    }).catch((e)=>{
        next(e);
    });
});



// ADMIN


router.post('/',validation(createProductSchema),function(req, res,next) {
    controller.crearProducto(req.body)
    .then(productos=>{
        response.success(req,res,productos,200);
    }).catch((e)=>{
        next(e);
    });
});


router.patch('/inventario/:id',validation(productIventarioSchema),function(req,res,next){
    controller.modificarInventario(req.params.id,req.body)
    .then(productos=>{
        response.success(req,res,productos,200);
    }).catch((e)=>{
        next(e);
    });
});






module.exports = router;