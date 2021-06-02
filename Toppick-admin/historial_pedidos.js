var listaPedidos = [];
function listarProductos(numero)
{
    let productos;
    if(listaPedidos.findIndex(p => p.id == numero) != -1){//si el pedido existe
        productos = listaPedidos.find(p => p.id == numero);
    }
    productos
}

function verDetalles(papa, numero) {
    let div = document.createElement("div");
    div.className = "detalles";
    let line = document.createElement("div");
    line.className = "linea";
    div.appendChild(line);
    div.appendChild(document.createElement("br"));
    //let produ = listarProductos(numero);
    //div.append(produ);
    papa.append(div);

}
function plantilaPedido(p) {
    let numero = p.id;
    //div pedido nuevo
    let pedido = document.createElement("div");
    pedido.className = "pedido";
    
    let numeroPedido = document.createElement("p");
    numeroPedido.className = "separador1";
    let texto = document.createElement("b");
    texto.innerHTML = "#" + numero.toString();
    numeroPedido.appendChild(texto);
    pedido.appendChild(numeroPedido);

    let pBoton = document.createElement("p");
    pBoton.className = "separador2";
    let boton = document.createElement("button");
    boton.className = "botonAzul";
    boton.innerHTML = "Ver detalles";
    boton.addEventListener("click",()=>
    {
        if (boton.innerHTML == "Ver detalles") {
            verDetalles(pedido, numero);
            boton.innerHTML = "Menos detalles";
            //boton.style = "font-size:small;";
            /*setTimeout(() => {
                let l = pedido.lastChild;
                console.log("aca");
                console.log(l);
                l.className = "detalles activo";
            }, 200)*/
        }
        else {
            let det = pedido.lastChild;
            removeAllChildNodes(det);
            det.remove(det);
            botonAzul.innerHTML = "Ver detalles";
            botonAzul.style = "font-size:medium;";
        }
    });
    pBoton.appendChild(boton);
    pedido.appendChild(pBoton);
    
    return pedido;

}
function agregarPedido(params) {
    let seccion = document.querySelector(".cajita");
    let html = plantilaPedido(params);
    seccion.appendChild(html);
    /*setTimeout(() => {
        html.className = "pedidoNuevo activo";
    }, 200);*/
}
var p = {
    id:1
};
agregarPedido(p);