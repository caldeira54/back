const jwt = require('jsonwebtoken');

const UserValidation = async (req, res, next) => {
    const token = req.header('Authorization');
    console.log(token);

    if (!token) {
        return res.status(400).json({ erro: 'Token de autenticação ausente' });
    }

    try {
        const decodedToken = jwt.verify(token, 'secret');
        req.user = decodedToken;
        next();
    } catch (error) {
        return res.status(400).json({ erro: 'Token inválido' });
    }
}

module.exports = UserValidation;