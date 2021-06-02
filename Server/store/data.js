const db = {

    'pedidos': [

        {
            "idPedido": 1,
            "puntoVenta": 0,
            "idCliente": 0,
            "costoTotal": 60000,
            "fechaCreacion": "1990-06-30 08:03:00",
            "fechaReclamo": "1990-06-30 08:03:00",
            "estadoPedido": "solicitado",
            "razonRechazo": "",
            "carrito": [

                {
                    "idProducto": 1,
                    "cantidadPedido": 5,
                    "comentarios": "",
                    "Acompañaminetos": [
                        { "idAcompañamiento": 5 },
                        { "idAcompañamiento": 6 }
                    ]
                },

                {
                    "idProducto": 2,
                    "cantidadPedido": 5,
                    "comentarios": ""
                },

                {
                    "idProducto": 3,
                    "cantidadPedido": 5,
                    "comentarios": ""
                }

            ]
        },

        {
            "idPedido": 2,
            "puntoVenta": 0,
            "idCliente": 0,
            "costoTotal": 60000,
            "fechaCreacion": "1990-06-30 08:03:00",
            "fechaReclamo": "1990-06-30 08:03:00",
            "estadoPedido": "solicitado",
            "razonRechazo": "",
            "carrito": [

                {
                    "idProducto": 1,
                    "cantidadPedido": 5,
                    "comentarios": "",
                    "Acompañaminetos": [
                        { "idAcompañamiento": 5 },
                        { "idAcompañamiento": 6 }
                    ]
                },

                {
                    "idProducto": 2,
                    "cantidadPedido": 5,
                    "comentarios": ""
                },

                {
                    "idProducto": 3,
                    "cantidadPedido": 5,
                    "comentarios": ""
                }

            ]
        }

    ],
    'productos': [
        {
            "id": "1",
            "nombreProducto": "papas",
            "descripcion": "paquete de papas",
            "precio": "2000",
            "tiempoPreparacion": "0",
            "calificacion": "5",
            "urlImagen": "urlFicticia.com",
            "categoria": "empaquetados",
            "tipo": "ninguno"
        },
        {
            "id": "2",
            "nombreProducto": "papas2",
            "descripcion": "paquete de papas2",
            "precio": "2000",
            "tiempoPreparacion": "0",
            "calificacion": "5",
            "urlImagen": "urlFicticia.com",
            "categoria": "empaquetados",
            "tipo": "ninguno"
        },
        {
            "id": "3",
            "nombreProducto": "papas3",
            "descripcion": "paquete de papas3",
            "precio": "2000",
            "tiempoPreparacion": "0",
            "calificacion": "5",
            "urlImagen": "urlFicticia.com",
            "categoria": "empaquetados",
            "tipo": "ninguno"
        },
        {
            "id": "5",
            "nombreProducto": "ponque",
            "descripcion": "paquete de ponque",
            "precio": "2000",
            "tiempoPreparacion": "0",
            "calificacion": "5",
            "urlImagen": "urlFicticia.com",
            "categoria": "empaquetados",
            "tipo": "ninguno"
        },
    ],
    "tiendas": [

        {
            "id": "1",
            "nombrePuntoDeVenta": "tienda1",
            "tipoPuntoVenta": "kiosko",
            "descripcion": "tienda1",
            "urlUbicacion": "urlUbicacion",
            "Estado": "abierto",
            "calificacion": "4.5",
            "urlImagen": "urlFakexdxd",
            "horario": [
                {
                    "nombreDia": "lunes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "martes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "mirecoles",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "jueves",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                }
            ],
            "productos": [
                {
                    "id": "1",
                    "nombreProducto": "papas",
                    "descripcion": "paquete de papas",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "2",
                    "nombreProducto": "papas2",
                    "descripcion": "paquete de papas2",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "3",
                    "nombreProducto": "papas3",
                    "descripcion": "paquete de papas3",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                }
            ]
        },
        {
            "id": "2",
            "nombrePuntoDeVenta": "tienda1",
            "tipoPuntoVenta": "kiosko",
            "descripcion": "tienda1",
            "urlUbicacion": "urlUbicacion",
            "Estado": "abierto",
            "calificacion": "4.5",
            "urlImagen": "urlFakexdxd",
            "horario": [
                {
                    "nombreDia": "lunes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "martes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "mirecoles",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "jueves",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                }
            ],
            "productos": [
                {
                    "id": "1",
                    "nombreProducto": "papas",
                    "descripcion": "paquete de papas",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "2",
                    "nombreProducto": "papas2",
                    "descripcion": "paquete de papas2",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "3",
                    "nombreProducto": "papas3",
                    "descripcion": "paquete de papas3",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                }
            ]
        },
        {
            "id": "3",
            "nombrePuntoDeVenta": "tienda1",
            "tipoPuntoVenta": "kiosko",
            "descripcion": "tienda1",
            "urlUbicacion": "urlUbicacion",
            "Estado": "abierto",
            "calificacion": "4.5",
            "urlImagen": "urlFakexdxd",
            "horario": [
                {
                    "nombreDia": "lunes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "martes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "mirecoles",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "jueves",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                }
            ],
            "productos": [
                {
                    "id": "1",
                    "nombreProducto": "papas",
                    "descripcion": "paquete de papas",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "2",
                    "nombreProducto": "papas2",
                    "descripcion": "paquete de papas2",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "3",
                    "nombreProducto": "papas3",
                    "descripcion": "paquete de papas3",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                }
            ]
        },
        {
            "id": "4",
            "nombrePuntoDeVenta": "tienda1",
            "tipoPuntoVenta": "kiosko",
            "descripcion": "tienda1",
            "urlUbicacion": "urlUbicacion",
            "Estado": "abierto",
            "calificacion": "4.5",
            "urlImagen": "urlFakexdxd",
            "horario": [
                {
                    "nombreDia": "lunes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "martes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "mirecoles",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "jueves",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                }
            ],
            "productos": [
                {
                    "id": "1",
                    "nombreProducto": "papas",
                    "descripcion": "paquete de papas",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "2",
                    "nombreProducto": "papas2",
                    "descripcion": "paquete de papas2",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
                {
                    "id": "3",
                    "nombreProducto": "papas3",
                    "descripcion": "paquete de papas3",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                }
            ]
        },
        {
            "id": "5",
            "nombrePuntoDeVenta": "tienda5",
            "tipoPuntoVenta": "kiosko",
            "descripcion": "tienda5",
            "urlUbicacion": "urlUbicacion",
            "Estado": "abierto",
            "calificacion": "4.5",
            "urlImagen": "urlFakexdxd",
            "horario": [
                {
                    "nombreDia": "lunes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "martes",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "mirecoles",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                },
                {
                    "nombreDia": "jueves",
                    "horaApertura": "7:00",
                    "horaCierre ": "20:00"
                }
            ],
            "productos": [
                {
                    "id": "5",
                    "nombreProducto": "ponque",
                    "descripcion": "paquete de ponque",
                    "precio": "2000",
                    "tiempoPreparacion": "0",
                    "calificacion": "5",
                    "urlImagen": "urlFicticia.com",
                    "categoria": "empaquetados",
                    "tipo": "ninguno"
                },
            ]
        },

    ]

};


module.exports = db;