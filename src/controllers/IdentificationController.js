const IdentificationModel = require('../models/IdentificationModel');
const UserModel = require('../models/UserModel');

class IdentificationController {
    async create(req, res) {
        const { idUser } = req.body;

        try {
            const user = await UserModel.findByPk(idUser);
            const { name } = user;
            const identificationDate = {
                idUser: req.body.idUser,
                idCourse: req.body.idCourse,
                teacher: name,
                course: req.body.course,
                year: req.body.year,
                team: req.body.team,
                discipline: req.body.discipline,
                totalWorkload: req.body.totalWorkload,
                period: req.body.period,
                courseProgram: req.body.courseProgram,
                objective: req.body.objective,
                scope: req.body.scope,
            }

            const identification = await IdentificationModel.create(identificationDate);

            return res.status(201).json(identification);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao criar identificação', message: err.message });
        }
    }

    async update(req, res) {
        const { id } = req.params;

        try {
            const [updated] = await IdentificationModel.update(req.body, { where: { id } });

            if (updated) {
                const updatedIdentification = await IdentificationModel.findByPk(id);
                return res.status(200).json(updatedIdentification);
            }

            return res.status(404).json({ error: 'Identificação não encontrada' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao atualizar a identificação', message: error.message });
        }
    }

    async all(req, res) {
        try {
            const identification = await IdentificationModel.findAll();
            return res.status(200).json(identification);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao buscar identificação' });
        }
    }

    async delete(req, res) {
        const { id } = req.params;

        try {
            const deleted = await IdentificationModel.destroy({ where: { id } });

            if (deleted) {
                return res.status(204).send();
            }

            return res.status(404).json({ error: 'Semana não encontrada' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao excluir a semana' });
        }
    }

    async showTeacher(req, res) {
        const { idUser } = req.params;

        try {
            const user = await UserModel.findByPk(idUser);

            return res.status(200).json(user);
        } catch (error) {
            return res.status(500).json({ erro: 'Erro ao buscar professor' });
        }
    }

    async allTeacher(req, res) {
        const { idUser } = req.params;

        try {
            const identification = await IdentificationModel.findAll({
                where: {
                    idUser: idUser
                }
            });

            return res.status(200).json(identification);
        } catch (error) {
            return res.status(500).json({ erro: 'Erro ao buscar identificação' });
        }
    }

    async recordCount(req, res) {
        const { idUser } = req.params;

        try {
            const count = await IdentificationModel.count({
                where: { idUser: idUser }
            });

            res.json({ count });
        } catch (error) {
            res.status(500).json({ error: 'Erro ao contar registros' });
        }
    };

    async show(req, res) {
        const { id } = req.params;

        try {
            const identification = await IdentificationModel.findByPk(id);

            res.status(200).json(identification);
        } catch (error) {
            res.status(500).json({
                error: 'Não foi possível encontrar a identificação',
                message: error.message
            });
        }
    }
}

module.exports = new IdentificationController();