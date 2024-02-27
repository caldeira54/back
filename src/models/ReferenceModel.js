const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Identification = require('./IdentificationModel');

const Reference = sequelize.define('Reference', {
    basic: {
        type: DataTypes.STRING,
        allowNull: false
    },
    additional: {
        type: DataTypes.STRING,
        allownull: false
    },
    date: {
        type: DataTypes.DATE,
        allownull: false
    }
}, {
    tableName: 'Reference'
});

Identification.hasMany(Reference, {
    foreignKey: 'idIdentification'
});

module.exports = Reference;