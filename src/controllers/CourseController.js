const CourseModel = require('../models/CourseModel');

class CourseController {
    async create(req, res) {
        try {
            const course = await CourseModel.create(req.body);

            return res.status(201).json(course);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao criar curso', message: err.message });
        }
    }

    async update(req, res) {
        const { id } = req.params;

        try {
            const [updated] = await CourseModel.update(req.body, { where: { id } });

            if (updated) {
                const updatedCourse = await CourseModel.findByPk(id);
                return res.status(200).json(updatedCourse);
            }

            return res.status(404).json({ error: 'Curso não encontrada' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao atualizar o curso' });
        }
    }

    async all(req, res) {
        try {
            const courses = await CourseModel.findAll({
                order: [['name', 'ASC']]
            });

            return res.status(200).json(courses);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao buscar cursos', message: err.message });
        }
    }

    async delete(req, res) {
        const { id } = req.params;

        try {
            const deleted = await CourseModel.destroy({ where: { id } });

            if (deleted)
                return res.status(204).send();

            return res.status(404).json({ error: 'Curso não encontrado' });
        } catch (err) {
            return res.status(500).json({ error: 'Erro ao excluir o curso', message: err.message });
        }
    }

    async show(req, res) {
        const { id } = req.params;

        try {
            const course = await CourseModel.findByPk(id);

            return res.status(200).json(course);
        } catch (err) {
            return res.status(500).json({ erro: 'Não encontrado' });
        }
    }
}

module.exports = new CourseController();