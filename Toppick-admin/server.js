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

    var data = {
        user: user,
        password: password
    }
    var ret;
    axios.post("http://localhost:3000/toppick/admin/login/" + user + "/" + password, data).then((response) => {
        ret  = response.data;
    }, (error) => {
        console.log(error);
    });
    return ret;
}

passport.use(new PassportLocal(function (username, password, done) {
    var user = validateteUser(username, password);
    
    if (user != undefined) {
        console.log(user);
        return done(null, user);
    }
    return done(null, false, { message: "incorrect password" });
}));

//serializacion 
passport.serializeUser(function (user, done) {
    done(null, user.id);
});

//deserializacion
passport.deserializeUser(function (id, done) {
    done(null, { id: 1, name: "julian" });
})
app.get('/inicio', (req, res) => {
    res.render("inicio.ejs");
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
                return res.redirect('/inicio');
            }

            req.logIn(user, function (err) {
                if (err) {
                    return next(err);
                }
                //return res.redirect('/pedidos/'+user.id+'/'+user.name);
                res.redirect('/pedidos/' + user.id + '/' + user.name);
            });

        })(req, res, next);
});
app.listen(8080, () => console.log("server started"));

