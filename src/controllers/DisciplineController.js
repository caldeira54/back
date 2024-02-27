const DisciplineModel = require('../models/DisciplineModel');

class DisciplineController {
    async create(req, res) {
        try {
            const discipline = await DisciplineModel.create(req.body);

            return res.status(201).json(discipline);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao criar disciplina', message: err.message });
        }
    }

    async update(req, res) {
        const { id } = req.params;

        try {
            const [updated] = await DisciplineModel.update(req.body, { where: { id } });

            if (updated) {
                const updatedDiscipline = await DisciplineModel.findByPk(id);
                return res.status(200).json(updatedDiscipline);
            }

            return res.status(404).json({ error: 'Disciplina não encontrada' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao atualizar a disciplina', message: error.message });
        }
    }

    async all(req, res) {
        const { idCourse } = req.params;

        try {
            const disciplines = await DisciplineModel.findAll(
                {
                    where: { idCourse },
                    order: [['name', 'ASC']]
                }
            );

            return res.status(200).json(disciplines);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao buscar disciplinas', message: err.message });
        }
    }

    async delete(req, res) {
        const { id } = req.params;

        try {
            const deleted = await DisciplineModel.destroy({ where: { id } });

            if (deleted)
                return res.status(204).send();

            return res.status(404).json({ error: 'Disciplina não encontrada' });
        } catch (err) {
            return res.status(500).json({ error: 'Erro ao excluir a disciplina', message: err.message });
        }
    }
}

module.exports = new DisciplineController();