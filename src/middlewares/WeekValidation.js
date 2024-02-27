const WeekValidation = async (req, res, next) => {
    const { idIdentification, startDate, endDate, programContent, methodology, assessment, numberClasses } = req.body;

    if (!startDate)
        return res.status(400).json({ error: 'Data inicial é obrigatória!' });
    else if (!programContent)
        return res.status(400).json({ error: 'Ano é obrigatório!' });
    else if (!methodology)
        return res.status(400).json({ error: 'Turma é obrigatório!' });
    else if (!assessment)
        return res.status(400).json({ error: 'Disciplina é obrigatória!' });
    else if (!numberClasses)
        return res.status(400).json({ error: 'Carga horária total é obrigatória!' });
    else if (!idIdentification)
        return res.status(400).json({ error: 'Identificação é obrigatório!' });
    else
        next();
}

module.exports = WeekValidation;