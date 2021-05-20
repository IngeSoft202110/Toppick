const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
const validation = require('../../utils/middleware/validationHandler');
const passport = require('passport');
const { isLoggedIn, isNotLoggedIn } = require('../../utils/auth/auth');


const {
    clienteIdSchema,
    createClienteSchema,
    updateClienteSchema,
} = require('../../utils/schemas/cliente');

const {createUsuarioSchema} = require('../../utils/schemas/usuarios');



router.post('/login', isNotLoggedIn, validation(createUsuarioSchema),passport.authenticate('login'),function(req,res,next){
    response.success(req,res,"loggeado",200);
});

router.post('/', isNotLoggedIn, validation(createClienteSchema),passport.authenticate('signup'),function(req,res,next)
{
    response.success(req,res,"registrado",200);
});



router.get('/perfil',isLoggedIn,function(req,res,next){
   const id = req['user'].IdUsuario;
   controller.listarUsuario(id)
     .then(usuario=>{
         response.success(req,res,usuario,200);
     }).catch((e)=>{
         next(e);
     });
});




router.patch('/',isLoggedIn,validation(updateClienteSchema), function(req, res,next) {
   const id = req['user'].IdUsuario
   const data = req.body;

   controller.editarUsuario(id,data)
     .then(usuario=>{
         response.success(req,res,usuario,200);
     }).catch((e)=>{
         next(e);
     });
});


router.get('/logout',isLoggedIn,function(req, res){
    req.logout();
    response.success(req,res,"logout",200);

  });


module.exports = router;