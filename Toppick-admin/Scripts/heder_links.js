
var url = window.location.href;
var urlSplit = url.split('/');
var id = urlSplit[urlSplit.length - 1];
var user = urlSplit[urlSplit.length - 2];
var botonPantallaPedidos = document.getElementById("PantallaPedidos");
var botonPantallaActualizar = document.getElementById("PatnallaActualizar");
var botonPantallaHisto = document.getElementById("PantallaHisto");
var botonPantallaCierre = document.getElementById("PantallaCierre");
// var botonCerrarSesion = document.getElementById("Cerrar");
botonPantallaPedidos.addEventListener("click", () => {
    window.location.replace("http://localhost:8080/pedidos/" + user + "/" + id);
});
botonPantallaActualizar.addEventListener("click", () => { window.location.replace("http://localhost:8080/actualizar/" + user + "/" + id); });
botonPantallaHisto.addEventListener("click", () => { window.location.replace("http://localhost:8080/historial/" + user + "/" + id); });
botonPantallaCierre.addEventListener("click", () => { window.location.replace("http://localhost:8080/cierre_Caja/" + user + "/" + id); });
// botonCerrarSesion.addEventListener("click", async () => {
//     try{
//     var x = await axios({
//         method: "GET",
//         url: "https://toppickapp.herokuapp.com/usuarios/logout",
//     }).then(response => response.data);
//     if (x.data == "") {
//         window.location.replace("http://localhost:8080/");
//     } else
//         alert("Vuelva a cerrar sesion");
//     }catch(error)
//     {
//         console.log(error);
//     }

// }
// );

