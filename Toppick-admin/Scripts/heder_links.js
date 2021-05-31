
var url = window.location.href;
var urlSplit = url.split('/');
var id = urlSplit[urlSplit.length - 1];
var user = urlSplit[urlSplit.length - 2];
var botonPantallaPedidos = document.getElementById("PantallaPedidos");
var botonPantallaActualizar = document.getElementById("PatnallaActualizar");
var botonPantallaHisto = document.getElementById("PantallaHisto");
var botonPantallaCierre = document.getElementById("PantallaCierre");

botonPantallaPedidos.addEventListener("click", () => { window.location.replace('http://localhost:8080/pedidos'); });
botonPantallaActualizar.addEventListener("click", () => { window.location.replace('http://localhost:8080/actualizar'); });
botonPantallaHisto.addEventListener("click", () => { window.location.replace('http://localhost:8080/historial'); });
botonPantallaCierre.addEventListener("click", () => { window.location.replace('http://localhost:8080/cierre_caja'); });
