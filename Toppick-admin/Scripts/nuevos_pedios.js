'use strict'
function plantilla_nuevo_producto(numero){
    
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

    //columna 2
    let colum2 = document.createElement("div");
    colum2.className = "columna";
    parte1.appendChild(colum2);

    //boton verde aceptar
    let botonVerde = document.createElement("button");
    botonVerde.className = "botonVerde";
    botonVerde.innerHTML = "Aceptar";
    colum2.appendChild(botonVerde);

    //fila 2 de clase parte
    let parte2 = document.createElement("div");
    parte2.className = "parte";
    pedido.append(parte2);

    //columna 1 fila 2
    let colum12 = document.createElement("div");
    colum12.className = "columna";
    parte2.appendChild(colum12);

    //boton azul ver detalles
    let botonAzul = document.createElement("button");
    botonAzul.className = "botonAzul";
    botonAzul.innerHTML = "Ver detalles";
    colum12.appendChild(botonAzul);

    //columna 2
    let colum22 = document.createElement("div");
    colum22.className = "columna";
    parte2.appendChild(colum22);

    //boton rojo rechazar
    let botonRojo = document.createElement("button");
    botonRojo.className = "botonRojo";
    botonRojo.innerHTML = "Rechazar";
    colum22.appendChild(botonRojo);

    
    console.log(divPedido);
    return fragmento;
    
}

function nuevoPedido(numero) {
    let seccion = document.querySelector(".carta1");
    let html = plantilla_nuevo_producto(numero);
    seccion.appendChild(html);
}
/*

<div class="pedidoNuevo">
    <div class="pedido">
        <div class="parte">
            <div class="columna" style="font-size: medium;">
                <p style="justify-content: center;"><b> texto</b></p>
                <p><button class="botonAzul">Ver detalles</button></p>
            </div>

            <div id="columna" class="full">
                <button class="botonVerde">Aceptar </button>
            </div>
        </div>
    </div>
</div>
                    */
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
function nuevoPedidoCurso(params) {
    let seccion = document.querySelector(".carta2");
    let html = plantila_General(params);
    seccion.appendChild(html);
    
}

nuevoPedido(5);

nuevoPedido(4);
nuevoPedido(3);
nuevoPedido(2);
nuevoPedido(1);

