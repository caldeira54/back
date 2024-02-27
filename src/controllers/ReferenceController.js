const ReferenceModel = require('../models/ReferenceModel');
const UserModel = require('../models/UserModel');

class ReferenceController {
    async create(req, res) {
        try {
            const reference = await ReferenceModel.create(req.body);

            return res.status(201).json(reference);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao criar referência', message: err.message });
        }
    }

    async update(req, res) {
        const { id } = req.params;

        try {
            const [updated] = await ReferenceModel.update(req.body, { where: { id } });

            if (updated) {
                const updatedReference = await ReferenceModel.findByPk(id);
                return res.status(200).json(updatedReference);
            }

            return res.status(404).json({ error: 'Referência não encontrada' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao atualizar a referência' });
        }
    }

    async all(req, res) {
        const { idIdentification } = req.params;

        try {
            const references = await ReferenceModel.findAll({
                where: {
                    idIdentification: idIdentification
                }
            });
            return res.status(200).json(references);
        } catch (err) {
            return res.status(500).json({ erro: 'Erro ao buscar referência', message: err.message });
        }
    }

    async delete(req, res) {
        const { idIdentification } = req.params;

        try {
            const deleted = await ReferenceModel.destroy({ where: { idIdentification } });

            if (deleted)
                return res.status(204).send();

            return res.status(404).json({ error: 'Referência não encontrada' });
        } catch (error) {
            return res.status(500).json({ error: 'Erro ao excluir a referência' });
        }
    }
}

module.exports = new ReferenceController();