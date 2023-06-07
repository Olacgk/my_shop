const router = require('express').Router();

const ctrl = require('../controller/productController');

router.post('/new-product', ctrl.ajoutProduit);
router.get('/product-in-stock', ctrl.productInStock);
router.get('/products', ctrl.getAllProduit);

module.exports = router;