const express = require('express');
const router = express.Router();

const HolidayController = require('../controllers/HolidayController');

router.post('/', HolidayController.create);
router.get('/', HolidayController.saveHolidaysToDatabase);
router.get('/all', HolidayController.all);
router.put('/:id', HolidayController.update);
router.delete('/:id', HolidayController.deleteHoliday);

module.exports = router;