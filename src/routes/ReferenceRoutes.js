const express = require('express');
const router = express.Router();

const ReferenceController = require('../controllers/ReferenceController');

router.post('/', ReferenceController.create);
router.put('/:id', ReferenceController.update);
router.get('/all/:idIdentification', ReferenceController.all);
router.delete('/:idIdentification', ReferenceController.delete);

module.exports = router;