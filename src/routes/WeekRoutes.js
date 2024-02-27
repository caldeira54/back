const express = require('express');
const router = express.Router();

const WeekController = require('../controllers/WeekController');
const WeekValidation = require('../middlewares/WeekValidation');

router.post('/', WeekValidation, WeekController.create);
router.post('/autoCreate', WeekController.autoCreate);
router.put('/:id', WeekController.update);
router.get('/all/:idIdentification', WeekController.all);
router.get('/:id', WeekController.show);
router.delete('/:idIdentification', WeekController.delete);

module.exports = router;