const HolidayModel = require('../models/HolidayModel');
const axios = require('axios');

async function getHolidaysFromApi() {
    try {
        const currentYear = new Date().getFullYear();
        const response = await axios.get(`https://brasilapi.com.br/api/feriados/v1/${currentYear}`);

        return response.data;
    } catch (error) {
        throw error;
    }
}

async function saveHolidaysToDatabase() {
    const holidays = await getHolidaysFromApi();

    for (const holiday of holidays) {
        try {
            await HolidayModel.create(holiday);
            console.log(`Feriado inserido com sucesso: ${holiday.name}`);
        } catch (error) {
            console.error(`Erro ao inserir feriado: ${error.message}`);
        }
    }
}

async function all(req, res) {
    try {
        const holiday = await HolidayModel.findAll();
        return res.status(200).json(holiday);
    } catch (err) {
        return res.status(500).json({ erro: 'Erro ao buscar feriados' });
    }
}

async function create(req, res) {
    try {
        const data = req.body;

        const existingHolidays = await HolidayModel.findAll({
            where: { date: data.date }
        });

        console.log('Feriados', existingHolidays);
        console.log('Quantidade de datas encontradas', existingHolidays.length);

        if (existingHolidays.length > 0)
            return res.status(401).json({ erro: 'Já existe um feriado nessa data' });

        const holiday = await HolidayModel.create(req.body);

        return res.status(201).json(holiday);
    } catch (err) {
        return res.status(500).json({ erro: 'Erro ao criar feriado', message: err.message });
    }
}

async function update(req, res) {
    const { id } = req.params;

    try {
        const [updated] = await HolidayModel.update(req.body, { where: { id } });

        if (updated) {
            const updatedHoliday = await HolidayModel.findByPk(id);
            return res.status(200).json(updatedHoliday);
        }

        return res.status(404).json({ error: 'Feriado não encontrado' });
    } catch (error) {
        return res.status(500).json({ error: 'Erro ao atualizar o feriado' });
    }
}

async function deleteHoliday(req, res) {
    const { id } = req.params;

    try {
        const deleted = await HolidayModel.destroy({ where: { id } });

        if (deleted) {
            return res.status(204).send();
        }

        return res.status(404).json({ error: 'Feriado não encontrado' });
    } catch (error) {
        return res.status(500).json({ error: 'Erro ao excluir o feriado' });
    }
}

module.exports = { saveHolidaysToDatabase, all, create, update, deleteHoliday };