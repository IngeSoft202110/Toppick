
var idPuntoDeVenta = document.getElementById("idPunto");
idPuntoDeVenta = idPuntoDeVenta.className;

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
console.log('Nuevos pedidos llamados'); 

const socket = io('https://toppickapp.herokuapp.com');


socket.emit('new_Store', idPuntoDeVenta);
console.log(idPuntoDeVenta);

socket.on('pedidos', pedido => {
    if (pedido.PuntoDeVenta_idPuntodeVenta == parseInt(idPuntoDeVenta)) {
        console.log(pedido);
        const fechaSegundos = pedido.fechaReclamo.split("T");
        const fechaSegundos2 = fechaSegundos[1].split(".");
        let fechaReclamo = fechaSegundos2[0];
        let productos = pedido.carrito;
        let productosd = [];
        for (let i = 0; i < productos.length; i++) {
            const elemento = productos[i];
            //console.log(elemento);
            let comentario = `cantidad:  ${elemento.CantidadProducto}`;
            if (elemento["Acompañamientos"]) {
                if (elemento["Acompañamientos"].length > 0) {
                    const acompañamiento = elemento["Acompañamientos"];
                    comentario = comentario + " Adición: "
                    for (let j = 0; j < acompañamiento.length; j++) {
                        const a = acompañamiento[j];
                        console.log(a["nombreAcompañamiento"]);
                        comentario += ` ${a["nombreAcompañamiento"]},`;
                    }
                }
            }
            const aux = elemento.comentario || "No hay";
            comentario += `Comentario: ${aux},`
            const p = {
                idProducto: elemento.Producto_idProducto,
                nombreProducto: elemento.nombreProducto,
                comentarios: comentario
            };

            productosd.push(p);
        }
        console.log(productosd);
        let nuevoP = {
            id: pedido.idPedido,
            horaEntrega: fechaReclamo,
            productos: productosd
        }
        nuevoPedido(nuevoP);
    }
});



var listaConfirmar = [];
var listaEnCurso = [];
var listaListos = [];
let unidadesDisponibles = true;

/**
 * Intervalo para verificar si existen nuevos productos 
 * constantemente en la base de datos 
 */
//setInterval(() => getOrders(), 2000);

/**
 * Función que obtiene las nuevas ordenes
 */
var last_id = 1;
async function getOrders() {
    try {
        const response = await axios({
            method: "GET",
            url: `https://toppickapp.herokuapp.com/pedidos/tienda/${ idPuntoDeVenta }`
        });
        console.log(response);
        // Get data from response

        response.data.body.forEach(pedido => {
            const fechaSegundos = pedido.fechaReclamo.split("T");
            const fechaSegundos2 = fechaSegundos[1].split(".");
            let fechaReclamo = fechaSegundos2[0];
            //console.log(fechaReclamo);
            let productos = pedido.carrito;
            let productosd = [];
            for (let i = 0; i < productos.length; i++) {
                const elemento = productos[i];
                //console.log(elemento);
                let comentario = `cantidad:  ${elemento.CantidadProducto}`;
                if (elemento["Acompañamientos"]) {
                    if (elemento["Acompañamientos"].length > 0) {
                        const acompañamiento = elemento["Acompañamientos"];
                        comentario = comentario + " Adición: "
                        for (let j = 0; j < acompañamiento.length; j++) {
                            const a = acompañamiento[j];
                            console.log(a["nombreAcompañamiento"]);
                            comentario += ` ${a["nombreAcompañamiento"]} `;
                        }
                    }
                }
                const aux = elemento.comentario || "No hay";
                comentario += `Comentario: ${aux},`
                const p = {
                    idProducto: elemento.Producto_idProducto,
                    nombreProducto: elemento.nombreProducto,
                    comentarios: comentario
                };

                productosd.push(p);

            }
            let nuevoP = {
                id: pedido.idPedido,
                horaEntrega: fechaReclamo,
                productos: productosd
            }
            if (pedido.estadoPedido == "Solicitado")
                nuevoPedido(nuevoP);
            else if (pedido.estadoPedido == "Aceptado")
                nuevoPedidoCurso(nuevoP);
            else if (pedido.estadoPedido == "Listo")
                pedidoListo(nuevoP);
        });

        // Create object that will be passed to the view       

    } catch (error) {
        console.log(error);
    }
}
getOrders();

/**
 * Función que realiza una petición de tipo POST al servidor 
 * y pretende cambiar el estado de un pedido en una tienda. 
 * Recibe como parámetros la información para el cambio de un pedido 
 * y si no recibe los parámetros, los asigna por defecto 
 */
async function cambiarEstadoPedido(idPedido, nuevoEstado, razonRechazo) {
    // Declarar los parametros del cuerpo de la solicitud POST 
    console.log(nuevoEstado);
    const bodyParams = {
        "estadoPedido": nuevoEstado,
        "razonRechazo": razonRechazo
    };
    console.log(bodyParams);
    try {
        const response = await axios({
            method: "PATCH",
            url: `https://toppickapp.herokuapp.com/pedidos/pedido/${idPedido}`,
            data: bodyParams
        });
    } catch (err) {
        console.log(err);
    }

    // Realizar la solicitud PATCH al servidor 


}
// Se prueba la petición con los siguientes parámetros 
// cambiarEstadoPedido(2, 1, 'Nuevooo');  ----> Funciona 
// cambiarEstadoPedido(1, 1, 'Rech', 'No se cuentan con los alimentos suficientes');   ------> Funciona


/**
 * 
 */
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
    encabezado.style = "font-weight: bold;";
    let idProducto = document.createElement("div");
    idProducto.innerHTML = "ID";
    idProducto.className = "encabezado";
    encabezado.appendChild(idProducto);
    let nombre = document.createElement("div")
    nombre.innerHTML = "Producto";
    nombre.className = "encabezado";
    encabezado.appendChild(nombre);
    let comentario = document.createElement("div");
    comentario.innerHTML = "comentarios";
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
        id.className = "columna pedidos";
        pro.appendChild(id);
        let r = document.createElement("div")
        r.innerHTML = p.nombreProducto;
        r.className = "columna pedidos";
        pro.appendChild(r);
        let c = document.createElement("div");
        c.className = "columna pedidos";
        if (p.comentario == "Sin comentario") {
            c.innerHTML = "  ";
        }
        else {
            c.innerHTML = p.comentarios;
        }
        pro.append(c);
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
function formRechazar(papa, divPedido, p) {
    /*
    esta funcion se encarga de adicionar en la ventana del pedido un forumalario para 
    rechazar el pedido
    */
    let div = document.createElement("div");
    div.className = "detalles activo";
    let line = document.createElement("div");
    line.className = "linea rechazo";
    div.appendChild(line);
    let form = document.createElement("form");
    form.setAttribute("onsubmit", "return false;");
    let label = document.createElement("p");
    label.innerHTML = "Seleccione razón de rechazo";
    label.fontSize = "big";
    form.appendChild(label);
    let select = document.createElement("select");
    select.className = "rechazo";
    let o = document.createElement("option");
    o.innerHTML = "No hay disponibilidad";
    select.appendChild(o);
    o = document.createElement("option");
    o.innerHTML = "No hay venta en esta hora";
    select.appendChild(o);
    o = document.createElement("option");
    o.innerHTML = "Poca caliridad en los detalles";
    select.appendChild(o)
    form.appendChild(select);
    form.appendChild(document.createElement("br"));
    let submit = document.createElement("input");
    submit.type = "submit";
    submit.value = "Enviar";
    submit.className = "submitB"
    /*
    boton para confirmar el rezcho y iniciar el envio del form 
    */
    form.addEventListener("submit", () => {

        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);
        cambiarEstadoPedido(idPedido = p.id, nuevoEstado = "Rechazado", razonRechazo = select.value);
    });
    form.appendChild(submit);
    div.appendChild(form);
    papa.appendChild(div);

}
/*--------parte de nuevos pedidos---------*/
function plantilla_nuevo_producto(p) {

    /*--------------
    esta funcion se encarga de crear la ventana para el pedido nuevo(p) y luego lo retorna para
    ser insertado en la pantalla
    ----------------*/
    let numero = p.id;

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

    /*-------------------
                    boton verde aceptar
    aca es el boton donde se genera la opcion de aceptar pedido
    ------------------*/
    let botonVerde = document.createElement("button");
    botonVerde.className = "botonVerde";
    botonVerde.innerHTML = "Aceptar";
    colum2.appendChild(botonVerde);
    //evento del boton de aceptar
    botonVerde.addEventListener("click", () => {
        // Validar unidades ----> TO DO: Realizar funci'on que valide las cantidades reales 
        p.productos.forEach((producto) => {
            if (producto.cantidad > 10) {
                unidadesDisponibles = false;
            }
        });
        if (!unidadesDisponibles) {
            alert('No hay unidades suficientes en el inventario para aceptar el pedido');
            return;
        }

        nuevoPedidoCurso(p);
        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);
        cambiarEstadoPedido(idPedido = p.id, nuevoEstado = "Aceptado", razonRechazo = "");
        /* generar codigo para la notifiacion */
    });

    //fila 2 de clase parte
    let parte2 = document.createElement("div");
    parte2.className = "parte";
    pedido.append(parte2);

    //columna 1 fila 2
    let colum12 = document.createElement("div");
    colum12.className = "columna";
    parte2.appendChild(colum12);

    /*--------------------
                boton azul ver detalles
    eboton para observar los detalles de los productos que obtine el pedido
    */
    let botonAzul = document.createElement("button");
    botonAzul.className = "botonAzul";
    botonAzul.innerHTML = "Ver detalles";
    colum12.appendChild(botonAzul);
    botonAzul.addEventListener("click", () => {
        if (botonAzul.innerHTML == "Ver detalles") {
            verDetalles(pedido, numero);
            botonAzul.innerHTML = "Menos detalles";
            botonAzul.style = "font-size:small;";
            setTimeout(() => {
                let l = pedido.lastChild;
                l.className = "detalles activo";
            }, 200)
        }
        else {
            let det = pedido.lastChild;
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

    /*------------------
                        boton rojo rechazar
    Boton que se encarga de ar la opcion de rezahar el pedido mostrando
    el formulario de razon de rechazo
    -------------------*/
    let botonRojo = document.createElement("button");
    botonRojo.className = "botonRojo";
    botonRojo.innerHTML = "Rechazar";
    colum22.appendChild(botonRojo);
    botonRojo.addEventListener("click", () => {
        if (botonRojo.innerHTML == "Rechazar") {
            //funcion para hacer el formularo de rechazo
            formRechazar(pedido, divPedido, p);
            botonRojo.innerHTML = "Cancelar";
        } else {
            botonRojo.innerHTML = "Rechazar";
            let det = pedido.lastChild;
            removeAllChildNodes(det);
            det.remove(det);
        }

    });
    //fila 3
    let parte3 = document.createElement("div");
    parte3.className = "parte";
    pedido.append(parte3);
    let colum31 = document.createElement("div");
    parte3.appendChild(colum31);
    let par = document.createElement("p");
    par.innerHTML = "Hora de entrega";
    colum31.appendChild(par);

    let colum32 = document.createElement("div");
    parte3.appendChild(colum32);
    let par2 = document.createElement("p");
    let fecha = p.horaEntrega;
    par2.innerHTML = p.horaEntrega;
    colum32.appendChild(par2);

    return divPedido;

}

function nuevoPedido(pedido) {
    /*-------------------
    llega un JSON con la informacion del pedido
    luego se procede a agregar los pedidos en la pantalla  
    ---------------------*/

    /*-------------------
    Se obtiene el elemento donde se va ainsertar la ventana del pedido
    ---------------------*/
    let numero = pedido.id;
    let seccion = document.querySelector(".carta1");
    /*------------------
    la funcion plantilla nueva crea la ventanta para la informacion del pedido
    --------------------*/
    let html = plantilla_nuevo_producto(pedido);
    seccion.appendChild(html);

    /*-----------------
    intervalo para aparicion de la ventana 
    -------------------*/
    setTimeout(() => {
        html.className = "pedidoNuevo activo";
    }, 200);
    listaConfirmar.push(pedido);

}
/* ----------fin nuevos Pedidos--------- */
/*
nuevoPedido(p1);
nuevoPedido(p2);
nuevoPedido(3);
nuevoPedido(2);
nuevoPedido(1);*/
/* --------------parte de pedidos en curso---------------*/
function plantila_General_curso(p) {
    let numero = p.id;
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
        if (botonAzul.innerHTML == "Ver detalles") {
            verDetalles(pedido, numero);
            botonAzul.innerHTML = "Menos detalles";
            botonAzul.style = "font-size:small;";
            setTimeout(() => {
                let l = pedido.lastChild;
                l.className = "detalles activo";
            }, 200)
        }
        else {
            let det = pedido.lastChild;
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
    botonVerde.innerHTML = "Listo para entregar";
    colum2.appendChild(botonVerde);

    botonVerde.addEventListener("click", () => {

        pedidoListo(p);
        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);
        cambiarEstadoPedido(idPedido = p.id, nuevoEstado = "Listo", razonRechazo = "");
    });
    //fila 3
    let parte3 = document.createElement("div");
    parte3.className = "parte";
    pedido.append(parte3);
    let colum31 = document.createElement("div");
    parte3.appendChild(colum31);
    let par = document.createElement("p");
    par.innerHTML = "Hora de entrega";
    colum31.appendChild(par);

    let colum32 = document.createElement("div");
    parte3.appendChild(colum32);
    let par2 = document.createElement("p");
    let fecha = p.horaEntrega;
    par2.innerHTML = fecha;
    colum32.appendChild(par2);

    return divPedido;

}
function nuevoPedidoCurso(params) {

    /*
    Funcion que se encarga de cambiar la ventana a el estado de pedido  en curso 
    solo se ejecuta si el estado es acepado
    */
    let seccion = document.querySelector(".carta2");
    //general la ventana que se inserta en el elemento seccion 
    let html = plantila_General_curso(params);
    seccion.appendChild(html);
    setTimeout(() => {
        html.className = "pedidoNuevo activo";
    }, 200);

}
/*---------------------------*/

/*-------pedidos listos------------*/

function plantila_General_listos(p) {
    let numero = p.id;
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
        if (botonAzul.innerHTML == "Ver detalles") {
            verDetalles(pedido, numero);
            botonAzul.innerHTML = "Menos detalles";
            botonAzul.style = "font-size:small;";
            setTimeout(() => {
                let l = pedido.lastChild;
                l.className = "detalles activo";
            }, 200)
        }
        else {
            let det = pedido.lastChild;
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
    botonVerde.innerHTML = "Entregar";
    colum2.appendChild(botonVerde);

    botonVerde.addEventListener("click", () => {
        removeAllChildNodes(divPedido);
        divPedido.remove(divPedido);
        cambiarEstadoPedido(idPedido = p.id, nuevoEstado = "Terminado", razonRechazo = "");

    });
    //fila 3
    let parte3 = document.createElement("div");
    parte3.className = "parte";
    pedido.append(parte3);
    let colum31 = document.createElement("div");
    parte3.appendChild(colum31);
    let par = document.createElement("p");
    par.innerHTML = "Hora de entrega";
    colum31.appendChild(par);

    let colum32 = document.createElement("div");
    parte3.appendChild(colum32);
    let par2 = document.createElement("p");
    let fecha = p.horaEntrega;
    par2.innerHTML = fecha;
    colum32.appendChild(par2);

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
