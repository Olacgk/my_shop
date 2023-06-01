// const { Sequelize, DataTypes } = require('sequelize');

// const sequelize = new Sequelize('gestcom', 'root', '', {
//     host: 'localhost',
//     dialect: 'mysql',
//   });


// const User = sequelize.define('User', {
//     id: {
//       type: DataTypes.INTEGER,
//       primaryKey: true,
//       autoIncrement: true,
//     },
//     name: {
//       type: DataTypes.STRING,
//       allowNull: false
//     },
//     role: {
//       type: DataTypes.STRING,
//       allowNull: false
//     },
//     password: {
//         type: DataTypes.STRING,
//         allowNull: false
//     }
//   });

//   module.exports = User;

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
        enum: ['admin', 'vendor', 'comptable']
    },
    password: {
        type: String,
        required: true,
        min : 6,
        max : 1024
    },
    contrat: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'Contrats'
    }
});

users.plugin(uniqueValidator);

module.exports = mongoose.model('Users', users);