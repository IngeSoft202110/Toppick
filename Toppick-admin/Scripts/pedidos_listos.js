"use strict"

function plantila_General(numero){
    let fragmento = document.createDocumentFragment();
    
    //div pedido nuevo
    let divPedido = document.createElement("div");
    divPedido.className = "pedidoNuevo";
    fragmento.appendChild(divPedido);

    // contendor de clase pedido
    let pedido = document.createElement("div");
    pedido.className = "pedido";
    divPedido.appendChild(pedido);

    //fila 1 de clase parte
    let parte1 = document.createElement("div");
    parte1.className = "parte";
    pedido.appendChild(parte1);

    //se gregan las dos columanas  de la fila 1
    //columa 1
    let colum1 = document.createElement("div");
    colum1.className = "columna";
    colum1.style.fontSize = "medium";
    parte1.appendChild(colum1);
    //numero del pedido
    let numeroPed = document.createElement("p");
    numeroPed.style.justifyContent = "center";
    numeroPed.innerHTML = "Pedido #"+ numero;
    colum1.appendChild(numeroPed);

    //boton azul ver detalles
    let botonAzul = document.createElement("button");
    botonAzul.className = "botonAzul";
    botonAzul.innerHTML = "Ver detalles";
    colum1.appendChild(botonAzul);

    //columna 2
    let colum2 = document.createElement("div");
    colum2.className = "columna";
    parte1.appendChild(colum2);

    //boton verde aceptar
    let botonVerde = document.createElement("button");
    botonVerde.className = "botonVerde";
    botonVerde.innerHTML = "Aceptar";
    colum2.appendChild(botonVerde);

    
    return fragmento;

}
function pedidoListo(params) {
    let seccion = document.querySelector(".carta3");
    let html = plantila_General(params);
    seccion.appendChild(html);
    
}