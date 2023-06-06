const router = require('express').Router();

const ctrl = require('../controller/userController');

router.post('/new-user', ctrl.createUser);
router.post('/login', ctrl.login);
router.get('/all-users', ctrl.getAllUsers);

module.exports = router;
