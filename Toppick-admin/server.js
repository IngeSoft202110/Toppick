const express = require('express');
const axios = require('axios').default;
const passport = require('passport');
const cookieParser = require('cookie-parser');
const session = require("express-session");
const PassportLocal = require('passport-local').Strategy;
const app = express();
require('./Passport.js'); 

//-------------------------------------------------------
//                  Server configuration 
//------------------------------------------------------- 
//configuracion de los valores staticos
app.set('view engie', 'ejs');
app.use("/assets", express.static("assets"));
app.use("/Scripts", express.static("Scripts"));
app.use("/Css", express.static("Css"));

const PORT = process.env.PORT || 8080; // Port in which the server will be listening to requests

//----------------------------------------------------
//                     Middlewares                   
//----------------------------------------------------
app.use(express.json()); 
app.use(express.urlencoded({ extended: false })); // False, because we aren't recieving big files
//---- Passport ----
// Configure session
app.use(session({
    secret: 'TOPPICK-ADMIN', 
    resave: false, 
    saveUninitialized: false
}));
app.use(passport.initialize()); // Initialize passport
app.use(passport.session()); // Initialize passport session  

//---------------------------------------
//          Verification methods
//---------------------------------------
const isStoreAlreadyLoggedIn = (req, res, next) => {
    console.log(req.user); 
    if (req.isAuthenticated()) return res.redirect(`/pedidos/${ req.user.id }/${ req.user.username }`); 
    else return next(); 
}; 

const isStoreLoggedIn = (req, res, next) => {
    if (req.isAuthenticated()) return next(); 
    else return res.redirect('/'); 
}; 

//-------------------------------------------------------
//                  LOGIN routes
//-------------------------------------------------------
app.get('/', isStoreAlreadyLoggedIn, (req, res) => {
    res.render("inicio.ejs");
});

app.post('/login', (req, res, next) => { 
    passport.authenticate('local-login', (err, user, info) => {
        // If an error occurs
        if (err) return res.redirect('/'); 

        // If user doesn't exist in db
        if (!user) return res.redirect('/'); 

        // If user exists in the DB
        req.logIn(user, (err) => {
            if (err) return next(err); 
            else return res.redirect(`/pedidos/${ user.id }/${ user.username }`)
        }); 

    }) (req, res, next); 
}); 

//-------------------------------------------------------
//                  LOGIN routes
//-------------------------------------------------------
app.get('/cierre_Caja/:id/:name', isStoreLoggedIn, (req,res) =>{
    res.render('cierre_caja.ejs');
})

//-------------------------------------------------------
//                  HISTORIAL routes
//-------------------------------------------------------
app.get('/historial/:id/:name',(req,res) =>{
    res.render('Historial_pedidos.ejs');
})

//-------------------------------------------------------
//              UPDATE INVENTORY routes
//-------------------------------------------------------
app.get('/actualizar/:id/:name', isStoreLoggedIn, (req, res) => {
    res.render("actualizar_inventario.ejs");
});

//-------------------------------------------------------
//                  ORDERS routes
//-------------------------------------------------------
app.get('/pedidos/:id/:name', isStoreLoggedIn, (req, res) => {
    res.render("pedidos.ejs");
});

//-------------------------------------------------------
//                  Listening port  
//-------------------------------------------------------
app.listen(PORT, () => console.log(`Server listenning on port : ${PORT}`));