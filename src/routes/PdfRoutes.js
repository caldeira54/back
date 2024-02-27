const express = require('express');
const router = express.Router();

const PdfController = require('../controllers/PdfController');

router.get('/:idIdentification', PdfController.generatePdf);

module.exports = router;