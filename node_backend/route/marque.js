const router = require('express').Router();

const ctrl = require('../controller/marqueController');

router.get('/marques', ctrl.getMarques);

module.exports = router;