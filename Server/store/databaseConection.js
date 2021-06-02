const mysql = require('mysql');
const { promisify }= require('util');

const { database } = require('../config');

const pool = mysql.createPool(database);

pool.getConnection((err, connection) => {
  if (err) {
    if (err.code === 'PROTOCOL_CONNECTION_LOST') {
      console.error('Database connection was closed.');
    }
    if (err.code === 'ER_CON_COUNT_ERROR') {
      console.error('Database has to many connections');
    }
    if (err.code === 'ECONNREFUSED') {
      console.log(err);
      console.error('Database connection was refused');
    }
    else{
      console.error("in Databases.js",err)
    }
  }

  if (connection){
    connection.release();
    console.log('DB conectada');
  } 
  
  return;
});

// Promisify Pool Queries
pool.query = promisify(pool.query);






module.exports = pool;
