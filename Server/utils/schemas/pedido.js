const Joi = require("joi");
const {carritoSchema} = require('./producto')

const pedidoIdSchema = Joi.number();

const createPedidoSchema = Joi.object({
    PuntoDeVenta_idPuntodeVenta: pedidoIdSchema.required(),
    fechaCreacion: Joi.date().required(),
    costoTotal: Joi.number().min(0).max(999999).required(),
    fechaReclamo: Joi.date().required(),
    estadoPedido: Joi.string().valid('Solicitado').required(),
    razonRechazo:  Joi.string().allow(null, '').min(0).max(200).required(),
    carrito: carritoSchema.required()
});


const updatePedidoSchema = Joi.object({
    estadoPedido: Joi.string().valid("Aceptado","Rechazado","Listo","Terminado").required(),
    razonRechazo:  Joi.string().allow(null, '').min(0).max(200).required(),
});


const favoritePedidoSchema = Joi.object({
    Cliente_IdCliente: pedidoIdSchema.required(),
    Pedido_idPedido: pedidoIdSchema.required(),
    nombrePedido:Joi.string().max(20).required(),
});





module.exports = {
    pedidoIdSchema,
    createPedidoSchema,
    updatePedidoSchema,
    favoritePedidoSchema
}