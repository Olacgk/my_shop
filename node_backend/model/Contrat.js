const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');


const contrats = mongoose.Schema({
    numContrat: {
        type: String,
        required: true,
        min:6,
        max: 1024
    },
    date: {
        type: date,
        default: Date.now
    },
    productId: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Produits',
        required: true
    },
    client: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Client',
        required: true
    },
    editeur: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Users',
        required: true
    },
    quantiteProduit: {
        type: Number,
        required: true
    },
    tva: {
        type:Number,
        default: 0.18,
        required: true
    },
    prixNette: {
        type: Number,
        required: true
    },
    prixTTC: {
        type: Number,
        required: true
    }
});

contrats.plugin(uniqueValidator);

module.exports = mongoose.model('Contrats', contrats)