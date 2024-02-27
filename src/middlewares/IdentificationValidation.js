const IdentificationModel = require('../models/IdentificationModel');

const IdentificationValidation = async (req, res, next) => {
    const { idUser, course, year, team, discipline, totalWorkload, period, serie, courseProgram, objective, scope } = req.body;

    if (!course)
        return res.status(400).json({ error: 'Curso é obrigatório!' });
    else if (!year)
        return res.status(400).json({ error: 'Ano é obrigatório!' });
    else if (!team)
        return res.status(400).json({ error: 'Turma é obrigatório!' });
    else if (!discipline)
        return res.status(400).json({ error: 'Disciplina é obrigatória!' });
    else if (!totalWorkload)
        return res.status(400).json({ error: 'Carga horária total é obrigatória!' });
    else if (!period)
        return res.status(400).json({ error: 'Período é obrigatório!' });
    else if (!courseProgram)
        return res.status(400).json({ error: 'Ementa é obrigatória!' });
    else if (!objective)
        return res.status(400).json({ error: 'Objetivo é obrigatório!' });
    else if (!scope)
        return res.status(400).json({ error: 'Abrangência é obrigatório!' });
    else if (!idUser)
        return res.status(400).json({ error: 'Usuário é obrigatório!' });
    else
        next();
}

module.exports = IdentificationValidation;