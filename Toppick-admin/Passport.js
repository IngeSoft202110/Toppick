const passport = require('passport'); 
const LocalStrategy = require('passport-local').Strategy; 
const axios = require('axios'); 

//---------------------------------------
// Serealize and Deserialize store
//---------------------------------------
passport.serializeUser((store, done) => {
    done(null, { id: store.id, username: store.username }); 
});

passport.deserializeUser((store, done) => {
    done(null, { id: store.id, username: store.username }); 
}); 

//---------------------------------------
//          Local strategies
//---------------------------------------
passport.use('local-login', new LocalStrategy({
    usernameField: 'username', 
    passwordField: 'password', 
    passReqToCallback: true
}, async (req, username, password, done) => {
    // Request store information to server
    try {
        const data = {
            "nombreUsuario": username,
            "contraseña": password
        }
        //retun the response of the main server 
        const res = await axios({
            method: "POST",
            url: "https://toppickapp.herokuapp.com/usuarios/login",
            data: data
        }); 

        // Return store information on succsessfull server response
        const store = { username: username, id: res.data.body.id };
        // req.user = store; 
        done(null, store); 

    } catch( error ) {
        // Return error if exists
        done(error); 
    }
})); 

//---------------------------------------
//          Verification methods
//---------------------------------------
const isStoreAlreadyLoggedIn = (req, res, next) => {
    if (req.isAuthenicated()) return res.redirect('/'); 
    else return next(); 
}; 

const isStoreLoggedIn = (req, res, next) => {
    if (req.isAuthenicated()) return next(); 
    else return res.redirect('/'); 
}; 