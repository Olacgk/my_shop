const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const marque = mongoose.Schema({
    nom: {
        type: String,
        required: true,
        unique: true,
        min: 6,
        max: 255
    },
    quantite: {
        type: Number,
        required: true
    }
});

marque.plugin(uniqueValidator);

module.exports = mongoose.model('Marque', marque);