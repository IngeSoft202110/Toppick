'use strict'

//obtener los puntos de venta

async function getPuntos(){
    try {
        var response = await axios.get('http://localhost:3000/toppick/admin/login/puntos-venta');
        console.log(response);
        return response.data;
        
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


