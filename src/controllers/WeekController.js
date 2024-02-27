const WeekModel = require('../models/WeekModel');
const HolidayModel = require('../models/HolidayModel');
const datefns = require('date-fns');
const { Op } = require('sequelize');
const WeekHoliday = require('../models/WeekHoliday');

class WeekController {
    async create(req, res) {
        try {
            const data = req.body;
            const startDate = datefns.startOfDay(datefns.parseISO(data.startDate));
            const endDate = datefns.nextFriday(startDate);

            data.endDate = endDate;

            let numberOfDays = datefns.differenceInDays(endDate, startDate) + 1;

            if (numberOfDays > 5) {
                return res.status(400).json({ error: 'A semana não pode ter mais de 5 dias' });
            }

            const holidays = await HolidayModel.findAll({
                where: {
                    date: {
                        [Op.between]: [startDate, endDate]
                    }
                }
            });

            numberOfDays -= holidays.length;

            data.numberOfDays = numberOfDays;

            // Verifica se já existem semanas com o mesmo idIdentification
            const existingWeeks = await WeekModel.findAll({
                where: { idIdentification: data.idIdentification },
                order: [['weekOrder', 'DESC']],
                limit: 1, // Pega a última semana com base no weekOrder
            });

            if (existingWeeks.length > 0) {
                const lastWeek = existingWeeks[0];
                data.weekOrder = lastWeek.weekOrder + 1;
            } else {
                data.weekOrder = 1; // Se não houver semanas anteriores, inicia com 1
            }

            // Cria a nova semana
            const newWeek = await WeekModel.create(data);

            // Se houver feriados, cria as associações na tabela WeekHoliday
            if (holidays.length > 0) {
                for (const holiday of holidays) {
                    await WeekHoliday.create({
                        WeekId: newWeek.id,
                        HolidayId: holiday.id,
                    });
                }
            }

            return res.status(201).json(newWeek);
        } catch (error) {
            return res.status(500).json({ error: 'Erro a criar semana', message: error.message });
        }
    }

    async autoCreate(req, res) {
        try {
            let startDate;
            let endDate;
            let weekQuantity = 0;

            if (req.body.endDate) {
                endDate = datefns.startOfDay(datefns.parseISO(req.body.endDate));
                startDate = datefns.startOfDay(datefns.parseISO(req.body.startDate));

                // Calcula o número de semanas entre as datas de início e término
                const numberOfWeeks = datefns.differenceInWeeks(endDate, startDate);
                console.log('numberOfWeeks', numberOfWeeks)

                if (numberOfWeeks < 0) {
                    return res.status(400).json({ error: 'A data de término deve ser maior que a data de início' });
                }

                // Cria as semanas
                for (let i = 0; i <= numberOfWeeks; i++) {
                    const currentStartDate = datefns.addWeeks(startDate, i);
                    const currentEndDate = datefns.addDays(datefns.addWeeks(startDate, i), 4); // Sexta-feira

                    // Calcula o número de dias na semana (com feriados)
                    const holidays = await HolidayModel.findAll({
                        where: {
                            date: {
                                [Op.between]: [currentStartDate, currentEndDate]
                            }
                        }
                    });

                    const numberOfDays = datefns.differenceInDays(currentEndDate, currentStartDate) + 1 - holidays.length;

                    const existingWeeks = await WeekModel.findAll({
                        where: { idIdentification: req.body.idIdentification },
                        order: [['weekOrder', 'DESC']],
                        limit: 1,
                    });

                    // Cria os dados da semana
                    const weekData = {
                        idIdentification: req.body.idIdentification,
                        startDate: currentStartDate,
                        endDate: currentEndDate,
                        programContent: "",
                        methodology: "",
                        assessment: "",
                        numberClasses: req.body.numberClasses,
                        weekOrder: 1,
                        numberOfDays,
                    };

                    if (existingWeeks.length > 0) {
                        const lastWeek = existingWeeks[0];
                        weekData.weekOrder = lastWeek.weekOrder + 1;
                    } else {
                        weekData.weekOrder = 1;
                    }

                    if (holidays.length > 0) {
                        weekData.holidays = holidays.map(holiday => ({
                            id: holiday.id,
                            name: holiday.name,
                            date: holiday.date
                        }));
                    }

                    // Crie a semana
                    const week = await WeekModel.create(weekData);

                    if (holidays.length > 0) {
                        for (const holiday of holidays) {
                            await WeekHoliday.create({
                                WeekId: week.id,
                                HolidayId: holiday.id,
                            });
                        }
                    }
                }

                weekQuantity = numberOfWeeks + 1;
            } else {
                const startDate = datefns.startOfDay(datefns.parseISO(req.body.startDate));

                // Regra: Encontre a próxima sexta-feira
                const endDate = datefns.nextFriday(startDate);

                let numberOfDays = datefns.differenceInDays(endDate, startDate) + 1;

                const holidays = await HolidayModel.findAll({
                    where: {
                        date: {
                            [Op.between]: [startDate, endDate]
                        }
                    }
                });

                numberOfDays -= holidays.length;

                let weekData = {
                    idIdentification: req.body.idIdentification,
                    startDate,
                    endDate,
                    programContent: "",
                    methodology: "",
                    assessment: "",
                    numberClasses: req.body.numberClasses,
                    weekOrder: 1,
                    numberOfDays: numberOfDays,
                };

                if (holidays.length > 0) {
                    weekData.holidays = holidays.map(holiday => ({
                        id: holiday.id,
                        name: holiday.name,
                        date: holiday.date
                    }));
                }

                const week = await WeekModel.create(weekData);

                if (holidays.length > 0) {
                    for (const holiday of holidays) {
                        await WeekHoliday.create({
                            WeekId: week.id,
                            HolidayId: holiday.id,
                        });
                    }
                }

                weekQuantity = 1;
            }
            return res.status(201).json({ message: 'Semana(s) criada(s) com sucesso!', weeks: weekQuantity });

        } catch (error) {
            return res.status(500).json({ error: 'Erro ao criar semanas', message: error.message });
        }
    }

    async update(req, res) {
        const { id } = req.params;

        try {
            const week = await WeekModel.findByPk(id);

            if (!week)
                return res.status(404).json({ error: 'Semana não encontrada' });

            const data =
            {
                programContent: req.body.programContent,
                methodology: req.body.methodology,
                assessment: req.body.assessment,
                numberClasses: req.body.numberClasses,
            }

            const [updated] = await WeekModel.update(data, { where: { id: id } });

            if (updated == 1) {
                const week = await WeekModel.findByPk(id);
                return res.status(200).json(week.dataValues);
            }

            return res.status(404).json({ error: 'Erro ao atualizar semana' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao atualizar a semana' });
        }
    }

    async all(req, res) {
        try {
            const idIdentification = req.params.idIdentification;
            const weeks = await WeekModel.findAll({ where: { idIdentification } });
            return res.status(200).json(weeks);
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao buscar as semanas' });
        }
    }

    async delete(req, res) {
        const { idIdentification } = req.params;

        try {
            const deleted = await WeekModel.destroy({ where: { idIdentification } });

            if (deleted) {
                return res.status(204).send();
            }

            return res.status(404).json({ error: 'Semana não encontrada' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao excluir a semana' });
        }
    }

    async show(req, res) {
        const { id } = req.params;

        try {
            const week = await WeekModel.findByPk(id);

            return res.status(200).json(week);
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao buscar a semana' });
        }
    }
}

module.exports = new WeekController();