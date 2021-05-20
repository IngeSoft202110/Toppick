const Joi = require("joi");


const createUsuarioSchema = Joi.object({
    nombreUsuario: Joi.string().max(50).required(),
    contraseña: Joi.string().max(100).required(),
    token:Joi.string().max(200),
})

const updateUsuarioSchema = Joi.object({
    nombreUsuario: Joi.string().max(50).pattern(new RegExp("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@javeriana\.edu\.co$")).required(),
    contraseña: Joi.string().max(100).required(),
})



const usuarioNombreSchema = Joi.string().max(50).pattern(new RegExp("^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@javeriana\.edu\.co$"));

const usuarioContrasenaSchema = Joi.string().max(100);


module.exports = {
    createUsuarioSchema,
    usuarioNombreSchema,
    usuarioContrasenaSchema,
    updateUsuarioSchema
}