const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');


const facture = mongoose.Schema({
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
    lignes: [
        {
        produit: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Produits',
            required: true
        },
        quantite: {
            type: Number,
            required: true
        },
        prixUnitaire: {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'Produits',
            required: true
        }
        }
    ],
    tva: {
        type:Number,
        default: 18,
        required: true
    },
    prixNette: {
        type: Number,
        required: true
    },
    prixTTC: {
        type: Number,
        required: true
    },
    statut:{
        type: String,
        enum: ['En cours', 'Validé', 'Annulé'],
        default: 'En cours'
    },
    dateValidation: {
        type: date,
        default: Date.now
    },
    dateAnnulation: {
        type: date,
        default: Date.now
    },
    piecesJointes: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'PiecesJointes',
    },
});

facture.plugin(uniqueValidator);

module.exports = mongoose.model('Factures', facture)