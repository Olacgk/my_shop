const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const produits = mongoose.Schema({
    numProduit: {
        type: String,
        required: true,
        unique: true,
        min: 6,
        max:255
    },
    numSerie: {
        type: String,
        required: true,
        unique: true,
        min:6,
        max: 255
    },
    detail: {
        type: String,
        required: true,
        min: 6,
        max: 1024
    },
    etat: {
        type: String,
        required: true,
        min: 6,
        max: 255
    },
    inStock: {
        type: Boolean,
        required: true,
        default: true
    },
    price: {
        type: Number,
        required: true,
        min: 0,
    },
    marque: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Marque',
        required: true,
    },
    type: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Type',
        required: true
    }
});

produits.plugin(uniqueValidator);

module.exports = mongoose.model('Produits', produits);