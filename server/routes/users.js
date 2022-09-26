const express = require('express');
const router = express.Router();
const { getUsers, insertUsers, deleteUsers } = require('../controller/users');

router.get('/users', getUsers);
router.post('/users', insertUsers);
router.delete('/users/:id', deleteUsers);

module.exports = router;
