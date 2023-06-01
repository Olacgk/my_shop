const router = require('express').Router();

const ctrl = require('../controller/userController');

router.post('/new-user', ctrl.createUser);
router.post('/login', ctrl.login)

module.exports = router;
