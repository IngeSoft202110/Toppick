const Joi = require("joi");


const productIdSchema = Joi.number();


const productItemSchema = Joi.object({
    idProducto: productIdSchema.required(),
    nuevaCantidad: Joi.number().min(1).max(99).required(),
})


const productIventarioSchema = Joi.array().items(productItemSchema).required();


const createProductSchema = Joi.object({
    nombreProducto: Joi.string().max(60).required(),
    descripcion: Joi.string().max(200).required(),
    price: Joi.number().min(1).max(999999).required(),
    tiempoPreparacion: Joi.number().min(1).max(60).required(),
    calificacion: Joi.number().required(),
    urlImagen: Joi.string().required(),
    categoria: Joi.string().max(18).required(),
    tipo: Joi.string().max(45).required()
})


const updateProductSchema = Joi.object({
    nombreProducto: Joi.string().max(60).required(),
    descripcion: Joi.string().max(200).required(),
    price: Joi.number().min(1).max(999999).required(),
    tiempoPreparacion: Joi.number().min(1).max(60).required(),
    calificacion: Joi.number().required(),
    urlImagen: Joi.string().required(),
    categoria: Joi.string().max(18).required(),
    tipo: Joi.string().max(45).required()
})



const acompanantesSchema = Joi.object({
    Acompañamiento_idAcompañamiento:productIdSchema.required()
})


const acompanantesArraySchema = Joi.array().items(acompanantesSchema);



const carritoItemSchema = Joi.object({
    Producto_idProducto: productIdSchema.required(),
    CantidadProducto:Joi.number().min(1).max(99).required(),
    comentario:Joi.string().allow(null, '').min(0).max(500).required(),
    Acompañamientos:acompanantesArraySchema
})


const carritoSchema = Joi.array().items(carritoItemSchema);



module.exports = {
    productIdSchema,
    createProductSchema,
    updateProductSchema,
    productIventarioSchema,
    carritoSchema
}

  