const express = require('express');
const cors = require('cors');
const server = express();
const swaggerUi = require('swagger-ui-express');
const swaggerJson = require('./swagger.json');

const user = require('./routes/UserRoutes');
const identification = require('./routes/IdentificationRoutes');
const holiday = require('./routes/HolidayRoutes');
const week = require('./routes/WeekRoutes');
const reference = require('./routes/ReferenceRoutes');
const course = require('./routes/CourseRoutes');
const discipline = require('./routes/DisciplineRoutes');

server.use(cors());
server.use(express.json());

server.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerJson));
server.use('/user', user);
server.use('/identification', identification);
server.use('/holiday', holiday);
server.use('/week', week);
server.use('/reference', reference);
server.use('/course', course);
server.use('/discipline', discipline);

server.listen(3000, () => {
    console.log('API ONLINE');
});