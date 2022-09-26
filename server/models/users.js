const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const students = new Schema({
    name: String,
    address: String,
});

module.exports = mongoose.model('Student', students);