const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
/*

    APP

*/
const { isLoggedIn } = require('../../utils/auth/auth');

//listar tiendas
router.get('/',isLoggedIn,function(req, res,next) {
    controller.listarTiendas()
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});


//listar tiendas by id
router.get('/tienda/:id',isLoggedIn,function(req, res,next) {
    const id = req.params.id;
    controller.listarTiendabyId(id)
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});




// lista los horarios by id
router.get('/horario/:id',isLoggedIn,function(req, res,next) {
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
router.get('/producto/:id', isLoggedIn,function(req, res,next) {
    const id = req.params.id;
    controller.listarTiendaPorProducto(id)
    .then(tiendas=>{
        response.success(req,res,tiendas,200);
    }).catch((e)=>{
        next(e);
    });
});



//cierre de caja
router.get('/cierre/:id',function(req, res,next) {
    const id = req.params.id;
    
    controller.cierreCajaTienda(id)
    .then(cierre=>{
        response.success(req,res,cierre,200);
    }).catch((e)=>{
        next(e);
    });
});


//cerrar la tienda
router.patch('/cierreTienda/:id',function(req, res,next) {
    const id = req.params.id;
    controller.cerrarTienda(id)
    .then(cierre=>{
        response.success(req,res,cierre,200);
    }).catch((e)=>{
        next(e);
    });
});


//abrir la tienda
router.patch('/AperturaTienda/:id',function(req, res,next) {
    const id = req.params.id;
    controller.abrirTienda(id)
    .then(cierre=>{
        response.success(req,res,cierre,200);
    }).catch((e)=>{
        next(e);
    });
});







module.exports = router;