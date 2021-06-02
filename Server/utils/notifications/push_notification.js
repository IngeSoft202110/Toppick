const admin = require("firebase-admin");


function initFirebase() {
    const serviceAccount = require("./notificaciones-toppick-firebase-adminsdk-8ty0m-da54621340.json");
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount)
      }); 
}

initFirebase();


 async function notificarAUnUsuario(token,estado)
 {  

    
    admin.messaging().send({
        token: token,
        data: {
            estadoPedido:estado
          },
          notification:{
            title:"Actualizacion de pedido",
            body:(estado !== 'Aceptado' && estado !== 'Rechazado')? `Tu pedido esta ${estado}`:`Tu pedido ha sido ${estado}`
        },
        android: {
          priority: "high",
        },
        apns: {
          payload: {
            aps: {
              contentAvailable: true,
            },
          },
          headers: {
            "apns-push-type": "background",
            "apns-priority": "5", 
            "apns-topic": "io.flutter.plugins.firebase.messaging", 
          },
        },
      }).then((response) => {
        return;
    })
    .catch((error) => {
        error.message = "error en la notificacion del usuario"  
        throw new Error(error);
    });
 }


 module.exports = {
    notificarAUnUsuario
 }