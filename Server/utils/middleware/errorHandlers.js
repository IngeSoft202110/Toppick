const { ...config} = require("../../config.js");
const Sentry = require("@sentry/node");
const Tracing = require("@sentry/tracing");
const boom = require('@hapi/boom');
const isRequestAjaxOrApi = require('../isRequestAjaxOrApi');

Sentry.init({
  dsn: `https://${config.sentryDns}.ingest.sentry.io/${config.sentryId}`,
  tracesSampleRate: 1.0,
});


function withErrorStack(err, stack) {
  if (config.dev) {
    return { ...err, stack }; 
  }
  else{
    return {err:err.message,
            body:""};
  }
}



function wrapErrors(err, req, res, next) {
  if (!err.isBoom) {
    next(boom.badImplementation(err));
  }

  next(err);
}

function logErrors(err, req, res, next) {
  if(err.status === 500)
  console.log(err.stack);
  next(err);
}


function clientErrorHandler(err, req, res, next) {
  const {
    output: { statusCode, payload }
  } = err;
    res.status(statusCode).json(withErrorStack(payload, err.stack));
}





module.exports = {
  logErrors,
  wrapErrors,
  clientErrorHandler,
};

