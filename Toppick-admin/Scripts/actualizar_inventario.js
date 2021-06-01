async function getOrders() {
    
    try {
        const response = await axios.get('https://toppickapp.herokuapp.com/usuarios/isLoggedIn');
        console.log(response.data)
        return response.data;
    } catch (error) {
        console.log(error);
    }
}
getOrders();