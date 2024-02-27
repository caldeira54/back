const UserModel = require('../models/UserModel');
const bcrypt = require('bcrypt');


async function login(req, res) {
    const { email, password } = req.body;
    const user = await UserModel.findOne({ where: { email } });

    if (!user) {
        return res.status(401).json({ message: 'Usuário não encontrado' });
    }

    const passwordMatch = await bcrypt.compare(password, user.password);

    if (passwordMatch) {
        return res.status(200).json({ message: 'Login bem-sucedido', userId: user.id });
    } else {
        return res.status(401).json({ message: 'Senha incorreta' });
    }
}

async function create(req, res) {
    const user = req.body;
    const hashedPassword = await bcrypt.hash(user.password, 10);
    user.password = hashedPassword;

    try {
        const registerUser = await UserModel.create(req.body);
        res.status(200).json(registerUser);
    } catch (err) {
        res.status(400).json({ erro: err.message });
    }
}

module.exports = {
    login,
    create
}