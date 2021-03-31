'use strict'
/*
estructura de JSON de los pedidos
{
    id:123,
    horaEntrga: 5:30pm,
    productos: [
        {
            idProducto: 1,
            nombreProducto: pescadito,
            comentarios:"cualquier cosa"
        }
    ]
}
*/
var p1 = {
    id: 1,
    horaEntrega: "5:30 pm",
    productos: [
        {
            idProducto: 1,
            nombreProducto: "pescadito",
            comentario: "Sin comentario"
        }
    ]
}
var p2 = {
    id: 2,
    horaEntrega: "5:30 pm",
    productos: [
        {
            idProducto: 1,
            nombreProducto: "pescadito",
            comentario: "Sin comentario"
        },
        {
            idProducto: 5,
            nombreProducto: "carne",
            comentario: "sin salsa, papas en casquillos"
        }
    ]
}
var listaConfirmar = [];
var listaEnCurso = [];
var listaListos = [];

function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}
function listarProductos(numero) {
    let prducts;
    let lista = document.createDocumentFragment();
    let div = document.createElement("div");
    div.className = "parte";
    lista.appendChild(div);
    if (listaConfirmar.findIndex(p => p.id == numero) != -1) {
        prducts = listaConfirmar.find(p => p.id == numero);
    } else if (listaEnCurso.findIndex(p => p.id == numero) != -1) {
        prducts = listaConfirmar.find(p => p.id == numero);
    }
    else if (listaListos.findIndex(p => p.id == numero) != -1) {
        prducts = listaListos.find(p => p.id == numero);
    }
    //se crea el elemento para indicar la cantidad de productos
    let p = document.createElement("div");
    p.className = "columna";

    p.innerHTML = "Cantidad de productos :";
    p.style = "font-weight: bold;";
    div.appendChild(p);
    //se da el numero de la cantridad de producotos
    let n = document.createElement("div");
    n.className = "columna";
    n.innerHTML = prducts.productos.length;
    div.appendChild(n);

    
    let encabezado = document.createElement("div");
    encabezado.className = "parte productos";
    encabezado.style ="font-weight: bold;";
    let idProducto = document.createElement("div");
    idProducto.innerHTML = "ID";
    idProducto.className ="encabezado";
    encabezado.appendChild(idProducto);
    let nombre = document.createElement("div")
    nombre.innerHTML = "Producto";
    nombre.className ="encabezado";
    encabezado.appendChild(nombre);
    let comentario = document.createElement("div");
    comentario.innerHTML ="comentarios";
    comentario.className = "encabezado";
    encabezado.appendChild(comentario)
    lista.appendChild(encabezado);

    let productos = prducts.productos;
    productos.forEach(p => {
        let line = document.createElement("div");
        line.className = "linea interna";
        lista.appendChild(line);
        let pro = document.createElement("div");
        pro.className = "parte productos";
        let id = document.createElement("div");
        id.innerHTML = p.idProducto;
        id.className ="columna pedidos";
        pro.appendChild(id);
        let r = document.createElement("div")
        r.innerHTML = p.nombreProducto;
        r.className ="columna pedidos";
        pro.appendChild(r);
        let c = document.createElement("div");
        c.className ="columna pedidos";
        if (p.comentario == "Sin comentario") {
            c.innerHTML = "  ";
            console.log(p);
        }
        else {
            c.innerHTML = p.comentario;
        }
        pro.append(c);
        console.log(pro);
        lista.appendChild(pro);
    });
    return lista;
}
function verDetalles(papa, numero) {
    let div = document.createElement("div");
    div.className = "detalles";
    let line = document.createElement("div");
    line.className = "linea";
    div.appendChild(line);
    div.appendChild(document.createElement("br"));
    let produ = listarProductos(numero);
    div.append(produ);
    papa.append(div);
    
}
/*--------parte de nuevos pedidos---------*/
function plantilla_nuevo_producto(numero) {
    //div pedido nuevo
    let divPedido = document.createElement("div");
    divPedido.className = "pedidoNuevo";

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
    numeroPed.innerHTML = "Pedido #" + numero;
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
    //evento del boton de aceptar
    botonVerde.addEventListener("click", () => {
        nuevoPedidoCurso(numero);
        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);

    });

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
    botonAzul.addEventListener("click", () => {
        if (botonAzul.innerHTML == "Ver detalles"){
            verDetalles(pedido, numero);
            botonAzul.innerHTML = "Menos detalles";
            botonAzul.style = "font-size:small;";
            setTimeout(()=>{
                let l = pedido.lastChild;
                console.log("aca");
                console.log(l);
                l.className = "detalles activo";
            },200)
        }
        else{
            let det =pedido.lastChild;
            removeAllChildNodes(det);
            det.remove(det);
            botonAzul.innerHTML = "Ver detalles";
            botonAzul.style = "font-size:medium;";
        }
    });

    //columna 2
    let colum22 = document.createElement("div");
    colum22.className = "columna";
    parte2.appendChild(colum22);

    //boton rojo rechazar
    let botonRojo = document.createElement("button");
    botonRojo.className = "botonRojo";
    botonRojo.innerHTML = "Rechazar";
    colum22.appendChild(botonRojo);

    botonRojo.addEventListener("click", () => {
        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);
    });
    return divPedido;

}

function nuevoPedido(pedido) {
    let numero = pedido.id;
    let seccion = document.querySelector(".carta1");
    let html = plantilla_nuevo_producto(numero);
    seccion.appendChild(html);
    setTimeout(() => {
        html.className = "pedidoNuevo activo";
    }, 200);
    listaConfirmar.push(pedido);

}
/* ----------fin nuevos Pedidos--------- */

nuevoPedido(p1);
nuevoPedido(p2);/*
nuevoPedido(3);
nuevoPedido(2);
nuevoPedido(1);*/
/* --------------parte de pedidos en curso---------------*/
function plantila_General_curso(numero) {

    //div pedido nuevo
    let divPedido = document.createElement("div");
    divPedido.className = "pedidoNuevo";

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
    numeroPed.innerHTML = "Pedido #" + numero;
    colum1.appendChild(numeroPed);

    //boton azul ver detalles
    let botonAzul = document.createElement("button");
    botonAzul.className = "botonAzul";
    botonAzul.innerHTML = "Ver detalles";
    colum1.appendChild(botonAzul);
    botonAzul.addEventListener("click", () => {
        if (botonAzul.innerHTML == "Ver detalles"){
            verDetalles(pedido, numero);
            botonAzul.innerHTML = "Menos detalles";
            botonAzul.style = "font-size:small;";
            setTimeout(()=>{
                let l = pedido.lastChild;
                console.log("aca");
                console.log(l);
                l.className = "detalles activo";
            },200)
        }
        else{
            let det =pedido.lastChild;
            removeAllChildNodes(det);
            det.remove(det);
            botonAzul.innerHTML = "Ver detalles";
            botonAzul.style = "font-size:medium;";
        }
    });

    //columna 2
    let colum2 = document.createElement("div");
    colum2.className = "columna";
    parte1.appendChild(colum2);

    //boton verde aceptar
    let botonVerde = document.createElement("button");
    botonVerde.className = "botonVerde";
    botonVerde.innerHTML = "Aceptar";
    colum2.appendChild(botonVerde);

    botonVerde.addEventListener("click", () => {
        console.log("entra");
        pedidoListo(numero);
        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);

    });
    return divPedido;

}
function nuevoPedidoCurso(params) {
    let seccion = document.querySelector(".carta2");
    let html = plantila_General_curso(params);
    seccion.appendChild(html);
    setTimeout(() => {
        html.className = "pedidoNuevo activo";
    }, 200);

}
/*---------------------------*/

/*-------pedidos listos------------*/

function plantila_General_listos(numero) {
    //div pedido nuevo
    let divPedido = document.createElement("div");
    divPedido.className = "pedidoNuevo";

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
    numeroPed.innerHTML = "Pedido #" + numero;
    colum1.appendChild(numeroPed);

    //boton azul ver detalles
    let botonAzul = document.createElement("button");
    botonAzul.className = "botonAzul";
    botonAzul.innerHTML = "Ver detalles";
    colum1.appendChild(botonAzul);
    botonAzul.addEventListener("click", () => {
        if (botonAzul.innerHTML == "Ver detalles"){
            verDetalles(pedido, numero);
            botonAzul.innerHTML = "Menos detalles";
            botonAzul.style = "font-size:small;";
            setTimeout(()=>{
                let l = pedido.lastChild;
                console.log("aca");
                console.log(l);
                l.className = "detalles activo";
            },200)
        }
        else{
            let det =pedido.lastChild;
            removeAllChildNodes(det);
            det.remove(det);
            botonAzul.innerHTML = "Ver detalles";
            botonAzul.style = "font-size:medium;";
        }
    });

    //columna 2
    let colum2 = document.createElement("div");
    colum2.className = "columna";
    parte1.appendChild(colum2);

    //boton verde aceptar
    let botonVerde = document.createElement("button");
    botonVerde.className = "botonVerde";
    botonVerde.innerHTML = "Aceptar";
    colum2.appendChild(botonVerde);

    botonVerde.addEventListener("click", () => {
        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);

    });
    return divPedido;

}
function pedidoListo(params) {
    let seccion = document.querySelector(".carta3");
    let html = plantila_General_listos(params);
    seccion.appendChild(html);
    setTimeout(() => {
        html.className = "pedidoNuevo activo";
    }, 200);

}