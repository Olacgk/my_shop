const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

const users = mongoose.Schema({
    name: {
        type: String,
        required: true,
        min: 6,
        max: 255
    },
    username: {
        type: String,
        required: true,
        unique: true,
        min: 6,
        max: 255
    },
    role: {
        type: String,
        required: true,
        enum: ['admin', 'vendor']
    },
    password: {
        type: String,
        required: true,
        min : 6,
        max : 1024
    },
    factures: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Factures'
    },
    active: {
        type: Boolean,
        default: true
    }
});

users.plugin(uniqueValidator);

module.exports = mongoose.model('Users', users);