const express = require('express');
const router = express.Router();
const { getUsers, insertUsers, deleteUsers, updateUser } = require('../controller/users');

router.get('/users', getUsers);
router.post('/users', insertUsers);
router.delete('/users/:id', deleteUsers);
router.post('/users/:id', updateUser);

module.exports = router;
