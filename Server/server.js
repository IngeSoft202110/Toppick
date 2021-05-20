const express = require('express');
const cors = require("cors");
const helmet = require('helmet');
const boom = require('@hapi/boom');
const session = require('express-session');
const cookieParser = require('cookie-parser');
const MySQLStore = require('express-mysql-session')(session);
const passport = require('passport');
const { initializeSockets } = require('./components/pedidos/network')
const path = require('path');
const router = require('./network/routes');
const { ...config } = require("./config");
const socketIO = require('socket.io');

const {
  logErrors,
  wrapErrors,
  clientErrorHandler,
} = require("./utils/middleware/errorHandlers");// app


const app = express();

const server = app.listen(config.port, () => {
  console.log(`Listening http://localhost:${server.address().port}`);
})


const io = socketIO(server, {
  cors: {
    origin: '*',
  }
});


require('./utils/auth/strategies/local');

initializeSockets(io);



app.use(cors());
app.use(helmet());

app.use(express.json());
app.use(express.json());
app.use(cookieParser(config.secret));
app.use(express.urlencoded({ extended: true }));


app.use(require('morgan')('combined'));
app.use(session({
  secret: config.secret,
  resave: false,
  saveUninitialized: false,
  store: new MySQLStore(config.database)
}));


app.use(passport.initialize());
app.use(passport.session());




router(app);


//app.use('/static', express.static(path.join(__dirname,"public")));
app.get('/socketFile', (req, res) => {
  res.sendFile(__dirname + '/public/socket.io.js');
});

app.use(function (req, res, next) {
  const {
    output: { statusCode, payload }
  } = boom.notFound();
  res.status(statusCode).json(payload);
});

app.use(logErrors);
app.use(wrapErrors);
app.use(clientErrorHandler);
