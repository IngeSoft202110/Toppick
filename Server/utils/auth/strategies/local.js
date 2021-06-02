const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const boom = require('@hapi/boom');
const pool = require('../../../store/databaseConection');
const helper = require('../../encryptHelper');


const object = {}
object.getUserByUserName = async (username) => pool.query(`SELECT * from Usuario where nombreUsuario = '${username}'`);
object.getUserById = async (id) => pool.query(`SELECT * from Usuario where IdUsuario = ${id}`);
object.updateToken = async (token,id) => pool.query(`UPDATE Cliente SET token = '${token}' WHERE IdCliente = ${id}`);  


passport.use('login',new LocalStrategy({
  usernameField: 'nombreUsuario',
  passwordField: 'contraseña',
  passReqToCallback: true,
  session: true,
},
  async function (req, username, password, done) {
    try {
      const response = await object.getUserByUserName(username);
      if(response.length == 0){return done(null, false, { message: 'Informacion incorrecta' }); }
      if (!response[0].nombreUsuario) { return done(null, false, { message: 'Informacion incorrecta' }); }
      if (!await helper.matchPassword(password,response[0].contraseña)) { return done(null, false, { message: 'Informacion incorrecta' }); }
      if(req.body.token)
      await object.updateToken(req.body.token,response[0].IdUsuario);

      return done(null, response[0]);
    } catch (error) {
      return done(boom.badImplementation("error en la autenticacion"));
    }
  }
));


passport.use('signup', new LocalStrategy({
  usernameField: 'nombreUsuario',
  passwordField: 'contraseña',
  passReqToCallback: true,
  session: true,
}, async (req, username, password, done) => {

  const { ...fullname } = req.body;
  const newUser = {};
  newUser.nombreUsuario = username;
  
  delete fullname.nombreUsuario;
  delete fullname.contraseña;


  newUser.contraseña = await helper.encryptPassword(password);
  // Saving in the Database
  try {
    await pool.query("START TRANSACTION")
    const result = await pool.query('INSERT INTO Usuario SET ? ', newUser);
    newUser.IdUsuario = result.insertId;
    fullname.IdCliente = result.insertId;
    const result2 = await pool.query('INSERT INTO Cliente SET ? ', fullname);
    await pool.query("COMMIT;");
    return done(null, newUser);
  } catch (error) {
    await pool.query("ROLLBACK;");
      if(error.code && error.code === 'ER_DUP_ENTRY')
       done(boom.badData("el nombre de usuario ya existe"));
      else
       done(boom.badImplementation("error en registro del usuario"));
  }
}));




//serializacion 
passport.serializeUser(function (user, done) {

  done(null, user.IdUsuario);
});

//deserializacion
passport.deserializeUser( async function (id, done) {
  const response = await object.getUserById(id);
  done(null, response[0]);
})




