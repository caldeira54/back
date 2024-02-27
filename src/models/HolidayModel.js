const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Week = require('./WeekModel');

const Holiday = sequelize.define('Holiday', {
    name: {
        type: DataTypes.STRING,
        allowNull: false
    },
    date: {
        type: DataTypes.DATE,
        allowNull: false
    }
}, {
    tableName: 'Holiday'
});

Holiday.belongsToMany(Week, { through: 'WeekHoliday' });

module.exports = Holiday;
