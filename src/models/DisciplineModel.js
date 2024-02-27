const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const Course = require('./CourseModel');

const Discipline = sequelize.define('Discipline', {
    name: {
        type: DataTypes.STRING,
        allowNull: false
    }
}, {
    tableName: 'Discipline'
});

Course.hasMany(Discipline, {
    foreignKey: 'idCourse'
});

module.exports = Discipline;
