const express = require('express');
const response = require('../../network/response');
const controller = require('./controller');
const router = express.Router();
const validation = require('../../utils/middleware/validationHandler');
const passport = require('passport');
const { isLoggedIn, isNotLoggedIn } = require('../../utils/auth/auth');
const jwt = require('jsonwebtoken')


const {
    clienteIdSchema,
    createClienteSchema,
    updateClienteSchema,
} = require('../../utils/schemas/cliente');

const {createUsuarioSchema} = require('../../utils/schemas/usuarios');

function generateAccessToken(user) {
    return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '1d' });
  }

router.post('/login', isNotLoggedIn, validation(createUsuarioSchema),passport.authenticate('login'),function(req,res,next){
    controller.listarUsuario(req['user'].IdUsuario)
     .then(usuario=>{
        if(usuario)
        response.success(req,res,{id:req['user'].IdUsuario, name:usuario.nombreCompleto},200);
        else
        {
            const user = {id:req['user'].IdUsuario};
            const generatedToken = generateAccessToken(user);
            response.success(req,res,{id:req['user'].IdUsuario, token:generatedToken},200);
        }
     }).catch((e)=>{
         next(e);
     }); 
});

router.post('/', isNotLoggedIn, validation(createClienteSchema),passport.authenticate('signup'),function(req,res,next)
{
    controller.listarUsuario(req['user'].IdUsuario)
     .then(usuario=>{
        if(usuario)
        response.success(req,res,{id:req['user'].IdUsuario, name:req.body.nombreCompleto},200);
        else
        response.success(req,res,req['user'].IdUsuario,200);
     }).catch((e)=>{
         next(e);
     }); 
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


router.get('/isLoggedIn',function(req,res){
    if (req.isAuthenticated()) 
    response.success(req,res,{isLoggedIn:true},200);
    else
    response.success(req,res,{isLoggedIn:false},200);
})

router.get('/isLoggedIn/:id',function(req,res,next){
    const id = req.params.id;
    controller.isLoggedIn(id)
     .then(usuario=>{
         if(usuario.length)
         response.success(req,res,{isLoggedIn:true},200);
         else 
         response.success(req,res,{isLoggedIn:false},200);
     }).catch((e)=>{
         next(e);
     });
})




module.exports = router;