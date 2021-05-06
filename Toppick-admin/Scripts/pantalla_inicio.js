'use strict'

//obtener los puntos de venta

async function getPuntos(){
    try {
        var response ;
        await fetch('http://localhost:3000/toppick/admin/login/puntos-venta')
        .then(response => response.json())
        .then(data => {
          
            response = data;
        });
        
       
        return response;
        
    }
    catch(err){
        console.log(err);
    }
}

async function setPuntosdeVenta(){
    let selector =  document.querySelector(".select-t");
    let data =  await getPuntos();
    for(var i = 0 ; i < data.length; i++){
        let option =  document.createElement("option");
        console.log(data[i]);
        option.innerHTML = data[i].Usuario_nombreUsuario;
        selector.appendChild(option);
    }
    

};
setPuntosdeVenta();


