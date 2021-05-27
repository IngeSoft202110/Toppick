const express = require('express');
const axios = require('axios').default;
const passport = require('passport');
const cookieParser = require('cookie-parser');
const session = require("express-session");
const PassportLocal = require('passport-local').Strategy;
const app = express();
//configuracion de los valores staticos
app.set('view engie', 'ejs');
app.use("/assets", express.static("assets"));
app.use("/Scripts", express.static("Scripts"));
app.use("/Css", express.static("Css"));
//---------------
//conifiguracion de passport 
//---------------
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser('secret'));
app.use(session({
    secret: 'secret',
    resave: true,
    saveUninitialized: true
}));

app.use(passport.initialize());
app.use(passport.session());

//concet to main server to send information user
async function validateteUser(user, password) {
    //create the specific json to the sserver post 
    var data = {
        "nombreUsuario": user,
        "contraseña": password,
        "token": "fMIE3P36RGCXLtCwVsHUTy"
    }
    //retun the response of the main server 
    return await axios({
        method: "POST",
        url: "https://toppickapp.herokuapp.com/usuarios/login",
        data: data
    }
    ).then(res => res.data).then(err => err)
}

passport.use(new PassportLocal(function (username, password, done) {
    var user;
    //call the function to autorize the validation of the server
    return validateteUser(username, password).then((res) => {
        if (res.error == '') //if the server returns no error continue with the process 
            return done(null, { username: username, id: res.body });
        return done(null, false, { message: "incorrect password" });
    });


}));

//serializacion 
passport.serializeUser(function (user, done) {
    done(null, user.id);
});

//deserializacion
passport.deserializeUser(function (id, done) {
    done(null, { id: id });
})
app.get('/', (req, res) => {
    res.render("inicio.ejs");
});
app.get('/cierre_Caja/:id/:name',(req,res) =>{
    res.render('cierre_caja.ejs');
})
app.get('/historial/:id/:name',(req,res) =>{
    res.render('Historial_pedidos.ejs');
})
app.get('/actualizar/:id/:name', (req, res) => {
    res.render("actualizar_inventario.ejs");
});
app.get('/pedidos/:id/:name', (req, res) => {
    res.render("pedidos.ejs");
});


app.post('/login', (req, res, next) => {
    passport.authenticate('local',
        (err, user, info) => {
            if (err) {
                return next(err);
            }

            if (!user) {
                return res.redirect('/');
            }

            req.logIn(user, function (err) {
                if (err) {
                    return next(err);
                }
                res.redirect('/pedidos/' + user.username + '/' + user.id);
            });

        })(req, res, next);
});
app.listen(8080, () => console.log("server started"));

