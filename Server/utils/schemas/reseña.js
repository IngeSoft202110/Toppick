const Joi = require("joi");


const createResenaSchema = Joi.object({
    calificacion:  Joi.number().min(0).max(5).required(),
    descripcion:  Joi.string().min(0).max(100).required(),
});

module.exports = createResenaSchema;