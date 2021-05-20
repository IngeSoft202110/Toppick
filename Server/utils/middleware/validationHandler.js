const Joi = require("joi");
const boom = require('@hapi/boom');


function validate(data, schema) {
  const {error} = schema.validate(data);
  return error;
}

function validationHandler(schema, check = "body") {
  return function(req, res, next) {
    const error = validate(req[check], schema);
    error ? res.status(400).send(boom.badRequest(error)):next();
  };
}





module.exports = validationHandler

