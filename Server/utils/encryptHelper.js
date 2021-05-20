const bcrypt = require('bcrypt')

const helpers = {};

helpers.encryptPassword = async (password) => {
   const hash = await bcrypt.hash(password, 10);
   return hash;
};

helpers.matchPassword = async (password, savedPassword) => {
  try {
    const response = await bcrypt.compare(password, savedPassword);
    return response;
  } catch (e) {
    throw new Error("error en la contraseña");
  }
};

module.exports = helpers;