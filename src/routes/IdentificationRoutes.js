const express = require('express');
const router = express.Router();

const IdentificationController = require('../controllers/IdentificationController');
const IdentificationValidation = require('../middlewares/IdentificationValidation');

router.post('/', IdentificationValidation, IdentificationController.create);
router.put('/:id', IdentificationValidation, IdentificationController.update);
router.get('/all', IdentificationController.all);
router.delete('/:id', IdentificationController.delete);
router.get('/:idUser', IdentificationController.showTeacher);
router.get('/all/:idUser', IdentificationController.allTeacher);
router.get('/recordCount/:idUser', IdentificationController.recordCount);
router.get('/show/:id', IdentificationController.show);

module.exports = router;