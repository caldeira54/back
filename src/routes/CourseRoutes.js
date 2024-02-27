const express = require('express');
const router = express.Router();

const CourseController = require('../controllers/CourseController');
const CourseValidation = require('../middlewares/CourseValidation');

router.post('/', CourseValidation, CourseController.create);
router.get('/all', CourseController.all);
router.put('/:id', CourseValidation, CourseController.update);
router.delete('/:id', CourseController.delete);
router.get('/:id', CourseController.show);

module.exports = router;