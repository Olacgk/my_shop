const router = require('express').Router();

const ctrl = require('../controller/productController');

router.post('/new-product', ctrl.ajoutProduit);

module.exports = router;