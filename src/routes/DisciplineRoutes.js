const express = require('express');
const router = express.Router();

const DisciplineController = require('../controllers/DisciplineController');
const DisciplineValidation = require('../middlewares/DisciplineValidation');

router.post('/', DisciplineValidation, DisciplineController.create);
router.get('/all/:idCourse', DisciplineController.all);
router.put('/:id', DisciplineController.update);
router.delete('/:id', DisciplineController.delete);

module.exports = router;