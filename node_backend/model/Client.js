const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const client = mongoose.Schema({
    nom: {
        type: String,
        required: true,
        unique: true,
        min: 6,
        max: 255
    },
    numeroClient: {
        type: Number,
        required: true
    },
    statut: {
        type: String,
        enum: ['Particulier', 'Entreprise'],
        default: 'Particulier'
    },
    numContrat: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Contrats'
    }
});

client.plugin(uniqueValidator);

module.exports = mongoose.model('Client', client);