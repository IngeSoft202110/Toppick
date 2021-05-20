const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
/*

    APP

*/


//listar tiendas
router.get('/',function(req, res,next) {
    controller.listarTiendas()
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});


//listar tiendas by id
router.get('/tienda/:id',function(req, res,next) {
    const id = req.params.id;
    controller.listarTiendabyId(id)
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});




// lista los horarios by id
router.get('/horario/:id',function(req, res,next) {
    const id = req.params.id;
    controller.listarHorarioTienda(id)
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});

//listar catalogo por id
router.get('/catalogo/:id',function(req, res,next) {
    const id = req.params.id;
    controller.listarTiendasProductos(id)
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});



//listar tiendas por producto
router.get('/producto/:id', function(req, res,next) {
    const id = req.params.id;
    controller.listarTiendaPorProducto(id)
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});



//cierre de caja
router.get('/cierre',function(req, res,next) {
    const id = req['user'].IdUsuario;
    
    controller.cierreCajaTienda(id)
    .then(cierre=>{
        response.success(req,res,cierre,200);
    }).catch((e)=>{
        next(e);
    });
});








module.exports = router;