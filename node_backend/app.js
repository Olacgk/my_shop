const express = require('express');
const app = express();
const mongoose = require('mongoose');
// const mysql = require('mysql');
require('dotenv/config')
const bodyParser = require('body-parser');

app.use(express.json());
app.use(bodyParser.json());
app.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content, Accept, Content-Type, Authorization');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, PATCH, OPTIONS');
  next();
});

const options = {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  };

mongoose.connect(process.env.DB_CONNECTION, options )
.then(()=> {
    console.log("Connected to DB")
})
.catch((error) => {
    console.error('Erreur lors de la connexion à MongoDB :', error);
  });


const userRoute = require('./route/user');
app.use('/api/user', userRoute);

const productRoute = require('./route/produit');
app.use('/api/produit', productRoute);

app.listen(process.env.PORT, ()=> console.log(`Listening to port ${process.env.PORT}`))
