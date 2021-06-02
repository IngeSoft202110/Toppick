const Joi = require("joi");
const { usuarioNombreSchema, usuarioContrasenaSchema} = require('./usuarios');


const clienteIdSchema = Joi.number();


const createClienteSchema = Joi.object({
    nombreUsuario:usuarioNombreSchema.required(),
    contraseña:usuarioContrasenaSchema.required(),
    nombreCompleto: Joi.string().max(30).required(),
    tipoDocumento: Joi.string().valid("CC","TI","CE").required(),
    idDocumento: Joi.number().min(0).max(99999999999).required(),
    celular: Joi.number().max(99999999999).required(),
    token:Joi.string().max(200).required(),
})


const updateClienteSchema = Joi.object({
    nombreCompleto: Joi.string().max(30).required(),
    tipoDocumento: Joi.string().valid("CC","TI","CE").required(),
    idDocumento: Joi.number().min(0).max(99999999999).required(),
    celular: Joi.number().max(99999999999).required(),
})

module.exports = {
    clienteIdSchema,
    createClienteSchema,
    updateClienteSchema,
}