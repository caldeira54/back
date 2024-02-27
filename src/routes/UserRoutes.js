const express = require('express');
const router = express.Router();

const UserController = require('../controllers/UserController');
const UserValidation = require('../middlewares/UserValidation');

router.post('/login', UserController.login);
router.post('/', UserController.create);

module.exports = router;