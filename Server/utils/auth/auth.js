const boom = require('@hapi/boom');

module.exports = {
    isLoggedIn (req, res, next) {
        if (req.isAuthenticated()) {
            return next();
        }
        next(boom.unauthorized("no esta logeado"));
    },

    isNotLoggedIn(req, res, next) {
        if (!req.isAuthenticated()) {
            return next();
        }
        next(boom.unauthorized("ya esta logeado"));
    },

};