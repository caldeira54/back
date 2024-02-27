const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Course = sequelize.define('Course', {
    name: {
        type: DataTypes.STRING,
        allowNull: false
    }
}, {
    tableName: 'Course'
});

module.exports = Course;