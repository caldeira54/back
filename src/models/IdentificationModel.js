const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./UserModel');
const Course = require('./CourseModel');

const Identification = sequelize.define('Identification', {
    teacher: {
        type: DataTypes.STRING,
        allowNull: false
    },
    course: {
        type: DataTypes.STRING,
        allownull: false
    },
    year: {
        type: DataTypes.STRING,
        allownull: false
    },
    team: {
        type: DataTypes.STRING,
        allownull: false
    },
    discipline: {
        type: DataTypes.STRING,
        allownull: false
    },
    totalWorkload: {
        type: DataTypes.NUMBER,
        allownull: false
    },
    period: {
        type: DataTypes.STRING,
        allownull: false
    },
    courseProgram: {
        type: DataTypes.STRING,
        allownull: false
    },
    objective: {
        type: DataTypes.STRING,
        allownull: false
    },
    scope: {
        type: DataTypes.STRING,
        allownull: false
    }
}, {
    tableName: 'Identification'
});

User.hasMany(Identification, {
    foreignKey: 'idUser'
});

Course.hasOne(Identification, {
    foreignKey: 'idCourse'
});

module.exports = Identification;