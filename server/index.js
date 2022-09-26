const express = require('express');
const app = express();
const mongoose = require('mongoose');
const userRoutes = require('./routes/users');
const cors = require('cors');
const bodyParser = require('body-parser')
app.set('PORT', process.env.PORT || 3000);

app.use([bodyParser.urlencoded({ extended: true }), express.json(), express.urlencoded({ extended: true })]);
app.use(userRoutes);
app.use(cors());
const db = mongoose.connection;

mongoose.connect('mongodb://localhost:27017/flutter_test', {
    useNewUrlParser: true,
    useUnifiedTopology: true
});

db.once("open", () => {
    console.log("Database connected")
})

app.listen(3000, () => {
    console.log("serving on port " + 3000)
})



