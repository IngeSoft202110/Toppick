/****************/
/* Dependencies */ 
/****************/
var express = require('express'); 
var mysql = require('mysql'); 

/************************/
/* Server configuration */
/************************/
const app = express(); 
const PORT = process.env.PORT || 8001; 
const CONNECTION_URL = ""; // Empty while the connection with MySQL is established

/***************************/
/* Data base configuration */
/***************************/
var connection = mysql.createConnection({
    host: 'localhost', 
    user: 'root', 
    password: '1234567890' 
}); 


/***************/
/* Middlewares */
/***************/
// app.use(express.json()); 


/*****************/
/* Web endpoints */
/*****************/
app.get('/toppick/admin/:order_id', (req, res) => {
    // Url params
    const order_id = req.params.order_id; 
    // Data base query 
    const query = ``; 
    let querResult; 
    // Connect to the DB 
    connection.connect( () => console.log("Data base connected") ); 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Save response 
        querResult = rows; 
        console.log("Query processed");
    });
    // Disconnect to tht DB 
    connection.end( () => console.log("Connection with DB ended") ); 
    // Send response
    res.send(querResult); 
}); 


/*****************/
/* App endpoints */
/*****************/
// Products from all University 
app.get('/toppick/app/products', (req, res) => {
    // Data base query 
    const query = 'SHOW DATABASES'; 
    let queryResult; 
    // Connect to the DB 
    connection.connect( () => console.log("Data base connected") ); 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Save response 
        queryResult = rows; 
        console.log("Query processed");
    });
    // Disconnect to tht DB 
    connection.end( () => console.log("Connection with DB ended") ); 
    // Send response 
    res.send(queryResult); 
}); 

// Oppened stores in university
app.get('/toppick/app/oppened-stores', (req, res) => {
    // Data base query 
    const query = 'SHOW DATABASES'; 
    let querResult; 
    // Connect to the DB 
    connection.connect( () => console.log("Data base connected") ); 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Save response 
        querResult = rows; 
        console.log("Query processed");
    });
    // Disconnect to tht DB 
    connection.end( () => console.log("Connection with DB ended") ); 
    // Send response
    res.send(querResult); 
}); 

// Catalog from a store
app.get('/toppick/app/catalog/:store_name', (req, res) => {
    const store_name = req.params.store_name; 
    // Data base query 
    const query = ``; 
    let querResult; 
    // Connect to the DB 
    connection.connect( () => console.log("Data base connected") ); 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Save response 
        querResult = rows; 
        console.log("Query processed");
    });
    // Disconnect to tht DB 
    connection.end( () => console.log("Connection with DB ended") ); 
    // Send response
    res.send(querResult);  
}); 

// Store that have a product in his catalog 
app.get('/toppick/app/:product_name/in/:store_name', (req, res) => {
    const store_name = req.params.store_name; 
    const product_name = req.params.product_name; 
    // Data base query 
    const query = ``; 
    let querResult; 
    // Connect to the DB 
    connection.connect( () => console.log("Data base connected") ); 
    // Query DB 
    connection.query( query, (err, rows, fields) => {
        // Throw error if exists 
        if (err) throw err; 
        // Save response 
        querResult = rows; 
        console.log("Query processed");
    });
    // Disconnect to tht DB 
    connection.end( () => console.log("Connection with DB ended") ); 
    // Send response
    res.send(querResult); 
}); 


/*************/
/* Listenner */
/*************/
app.listen(PORT, () => console.log("Listenning on localhost:" + PORT)); 