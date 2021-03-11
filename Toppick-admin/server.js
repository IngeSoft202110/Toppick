// Modules to import 
import express from 'express'; 
// -------- import data to simulate database response 
import { porConfirmar, enCurso, listos } from './Test-Data/pedidos.js'; 
console.log(porConfirmar);

// Initialice express app 
const app = express(); 

// To use static files 
app.use( express.static('public') ); 

// Set the view engine to EJS
app.set('view engine', 'ejs'); 

// Routes of the web page ------- This should be imported and the routes should be in a separate file
app.get('/', (req, res) => {
    res.render('pedidos', {
        porConfirmar : porConfirmar, 
        enCurso : enCurso, 
        listos : listos,
    })
}); 

// Port to listen 
const PORT = process.env.PORT || 3000; // Declaring a port  
app.listen(PORT, () => console.log(`Server running in ${PORT} ... Create something awesome`)); 