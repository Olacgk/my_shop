const router = require('express').Router();

const ctrl = require('../controller/typeController');

router.get('/types', ctrl.getTypes);

module.exports = router;