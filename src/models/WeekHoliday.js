const sequelize = require('../config/database');
const Week = require('./WeekModel');
const Holiday = require('./HolidayModel');

const WeekHoliday = sequelize.define('WeekHoliday', {});

Week.belongsToMany(Holiday, { through: WeekHoliday });
Holiday.belongsToMany(Week, { through: WeekHoliday });

module.exports = WeekHoliday;
