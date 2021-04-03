/****************/
/* Dependencies */ 
/****************/
import express from 'express'; // To make our lifes eassier :)  


/************************/
/* Server configuration */
/************************/
const app = express(); 
const PORT = process.env.PORT || 8001; 
const CONNECTION_URL = ""; // Empty while the connection with MySQL is established


/***************/
/* Middlewares */
/***************/
app.use(express.json()); 


/*****************/
/* Web endpoints */
/*****************/


/*************/
/* Listenner */
/*************/
app.listen(PORT, () => console.log("Listenning on localhost:" + PORT)); 