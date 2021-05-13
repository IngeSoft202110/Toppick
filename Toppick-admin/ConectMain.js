async function validateteUser(user, password) {
    console.log("hola")
    var data = {
        user: user,
        password: password
    }
    await axios.post("/toppick/admin/login/"+user+"/"+password, data).then((response) => {
        console.log(response);
    }, (error) => {
        console.log(error);
    });
}