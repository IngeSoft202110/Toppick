const Joi = require("joi");

//id
const metodoPagoIdSchema = Joi.number();


//create
const opcionSeleccionada = Joi.object({
    opcion: Joi.string().valid("Nequi","PSE","Daviplata").required(),
    identificador: Joi.number().min(0).max(999999999999).required(),
})


const metodo = Joi.object({
    saldoTotal: Joi.number().min(0).max(99999999).required(),
})


const metodoPagoSchema = Joi.object({
    metodo: metodo.required(),
    opcionSeleccionada: opcionSeleccionada.required(),
})

//hacer Pago
const pagoSchema = Joi.object({
    valor: Joi.number().min(1).max(99999999).required(),
})

//update
const updateMetodoPagoSchema = Joi.object({
    metodo: Joi.string().valid("Nequi","PSE","Daviplata").required(),
    identificador: Joi.number().min(0).max(999999999999).required(),
    saldo:Joi.number().min(0).max(99999999).required(),
})



module.exports = {
    metodoPagoIdSchema,
    metodoPagoSchema,
    pagoSchema,
    updateMetodoPagoSchema
}