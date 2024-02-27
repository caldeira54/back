const sequelize = require('../config/database');
const { DataTypes } = require('sequelize');
const Identification = require('./IdentificationModel');
const Holiday = require('./HolidayModel');

const Week = sequelize.define('Week', {
    startDate: {
        type: DataTypes.DATE,
        allowNull: false
    },
    endDate: {
        type: DataTypes.DATE,
        allowNull: false
    },
    programContent: {
        type: DataTypes.STRING,
        allowNull: true
    },
    methodology: {
        type: DataTypes.STRING,
        allowNull: true
    },
    assessment: {
        type: DataTypes.STRING
    },
    numberClasses: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    weekOrder: {
        type: DataTypes.INTEGER,
        allowNull: true
    },
    numberOfDays: {
        type: DataTypes.INTEGER,
        allowNull: true
    }
}, {
    tableName: 'Week'
});

Identification.hasMany(Week, {
    foreignKey: 'idIdentification'
});

module.exports = Week;
