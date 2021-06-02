var boton = document.getElementById("boton");
async function validateteUser(user, password) {
    //create the specific json to the sserver post 
    try {

        var data = {
            "nombreUsuario": user,
            "contraseña": password
        }
        console.log(data);
        //retun the response of the main server 
        return await axios.post("https://toppickapp.herokuapp.com/usuarios/login", data
        ).then(res => res.data).then(err => err)
    } catch (error) {
        return { error: "error" }
    }
}
async function logeado(id) {
    return await axios({
        method: "GET",
        url: "https://toppickapp.herokuapp.com/usuarios/isLoggedIn/"+id,
    }
    ).then(res => res.data).then(err => err)
}
boton.addEventListener("click", () => {
    let username = document.getElementById("username");
    let password = document.getElementById("password");
    if (username.value == "" || password.value == "") {
        console.log(password.value)
    } else {
        console.log(password.value);
        let x = validateteUser(username.value, password.value)
            .then(res => {
                console.log(res);
                logeado().then((res) => console.log(res.body));
            });


    }
})