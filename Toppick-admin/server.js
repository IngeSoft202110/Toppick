const express = require('express');
const axios = require('axios').default;
const passport = require('passport');
const cookieParser = require('cookie-parser');
const session = require("express-session");
const PassportLocal = require('passport-local').Strategy;
const app = express();
const path = require('path'); 
require('./Passport.js'); 

//-------------------------------------------------------
//                  Server configuration 
//------------------------------------------------------- 
//configuracion de los valores staticos
app.use(express.static(path.join(__dirname, 'public'))); 
app.set('views', __dirname + '/views');
app.set('view engie', 'ejs');

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
    if (req.isAuthenticated()) return res.redirect('/pedidos'); 
    else return next(); 
}; 

const isStoreLoggedIn = (req, res, next) => {
    if (req.isAuthenticated()) return next(); 
    else return res.redirect('/'); 
}; 

//---------------------------------------
//              Methods
//---------------------------------------
const getDate = () => {
    const today = new Date();
    return today.getDate() + ' / ' + today.getMonth() + ' / ' + today.getFullYear();
}; 

//-------------------------------------------------------
//                  LOGOUT route
//-------------------------------------------------------
app.post('/logout', async (req, res) => {
     
    // Change availavility of store in DB
    const url = `https://toppickapp.herokuapp.com/tienda/cierreTienda/${ req.user.id }`; 
    console.log('LOGOUT URL:', url); 
    axios.patch( url )
        .then( response => {
            console.log('LOGOUT server response:', response.data); 
             // Log out from store
            req.logout();
            // Return successfull redirect 
            return res.redirect('/'); 
        } )
        .catch( error => {
            console.log('ERROR:', error.data); 
            // Return error redirect 
            return res.redirect('/'); 
        } ); 
}); 

//-------------------------------------------------------
//                  LOGIN routes
//-------------------------------------------------------
app.get('/', isStoreAlreadyLoggedIn, (req, res) => {
    res.render('pages/inicio.ejs');
});

app.post('/login', async (req, res, next) => { 
    passport.authenticate('local-login', (err, user, info) => {
        // If an error occurs
        if (err) return res.redirect('/'); 

        // If user doesn't exist in db
        if (!user) return res.redirect('/'); 

        // If user exists in the DB
        req.logIn(user, async (err) => {
            // Error while loggin in
            if (err) return next(err); 
            // No error 
            else {
                // Change store state in DB  
                const url = `https://toppickapp.herokuapp.com/tienda/AperturaTienda/${ req.user.id }`; 
                console.log('LOGIN URL', url); 
                axios.patch( url )
                    .then( response => {
                        console.log('LOGIN server response :', response.data); 
                        // Return succsessfull redirect 
                        return res.redirect(`/pedidos`); 
                    } )
                    .catch( error => {
                        console.log('login error:', error.data); 
                        return res.redirect('/'); 
                    } ); 
            } 
        }); 
    }) (req, res, next); 
}); 

//-------------------------------------------------------
//                   CIERRE DE CAJA routes
//-------------------------------------------------------
app.get('/cierre_caja', isStoreLoggedIn, async (req,res) =>{

    console.log('USER', req.user); 
    try {
        const response = await axios({
            method: "get",
            url: `https://toppickapp.herokuapp.com/tienda/cierre/${ req.user.id }`
        }); 

        // Get data from response
        const totalVentas = response.data.body.total; 
        const productosMasVendidos = response.data.body.mascantidad; 
        const productosMayorGanancia = response.data.body.masingresos; 
        const dataObj = {
            fecha: getDate(), 
            ventas: totalVentas, 
            masVendidos: productosMasVendidos, 
            mayorGanancia: productosMayorGanancia
        }; 
        // Render page with information from DB
        res.render('pages/cierre_caja.ejs', dataObj); 

    } catch( error ) {
        console.log('CIERRE CAJA : Error while making request to server'); 
    } 
})

//-------------------------------------------------------
//                  HISTORIAL routes
//-------------------------------------------------------
app.get('/historial', isStoreLoggedIn, async (req,res) =>{

    try {
        const response = await axios({
            method: "get",
            url: `https://toppickapp.herokuapp.com/pedidos/tienda/${ req.user.id }`
        }); 
        console.log(response); 
        // Get data from response
        response.data.body.forEach(element => {
            console.log(element); 
        });
        // Create object that will be passed to the view
        const dataObj = {
            fecha: getDate(), 
            pedidos: response.data.body
        }; 
        // Render page with information from DB
        return res.render('pages/Historial_pedidos.ejs', dataObj); 

    } catch( error ) {
        console.log('HISTORIAL : Error while making request to server'); 
        console.log(error); 
    } 
})

//-------------------------------------------------------
//              UPDATE INVENTORY routes
//-------------------------------------------------------
app.get('/actualizar', isStoreLoggedIn, async (req, res) => {
    try {
        //Get the information products
        const response = await axios({
            method: "GET",
            url: `https://toppickapp.herokuapp.com/tienda/catalogo/${req.user.id}`
        });
        var productos = []
        productos.append
        response.data.body.forEach(element => {
            productos.push(element.nombreProducto);
        });
        dataObj = {
            productos:response.data.body,
            id:req.user.id
        };
        return res.render("pages/actualizar_inventario.ejs", dataObj);
    } catch(error){
        console.log('Actualizar : Error while making request to server'); 
        console.log(error); 
    }
});

//-------------------------------------------------------
//                  ORDERS routes
//-------------------------------------------------------
app.get('/pedidos', isStoreLoggedIn, (req, res) => {
    const info = {
        idPunto :req.user.id
    }
    console.log(info.id)
    res.render('pages/pedidos.ejs', info);
});

//-------------------------------------------------------
//                  Listening port  
//-------------------------------------------------------
app.listen(PORT, () => console.log(`Server listenning on port : ${PORT}`));