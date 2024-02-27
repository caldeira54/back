const HolidayModel = require('../models/HolidayModel');
const { isPast } = require('date-fns');

const HolidayValidation = async (req, res, next) => {
    const { date } = req.body;

    if (!date)
        return res.status(400).json({ error: 'Data é obrigatória!' });
    else {
        let exists;

        if (req.params.id) {
            if (isPast(new Date(date)))
                return res.status(400).json({ error: 'Escolha uma data e hora futura!' });

            exists = await HolidayModel.findOne({
                'id': { '$ne': req.params.id },
                'date': { '$eq': new Date(date) }
            });
        } else {
            exists = await HolidayModel.findOne({
                'date': { '$eq': new Date(date) }
            });
        }


        if (exists)
            return res.status(400).json({ error: 'Já existe um feriado cadastrado nesse dia!' });

        next();
    }
}

module.exports = HolidayValidation;