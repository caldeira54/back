const DisciplineValidation = async (req, res, next) => {
    const { name, idCourse } = req.body;

    if (!name)
        return res.status(400).json({ error: 'Nome é obrigatório!' });
    else if (!idCourse)
        return res.status(400).json({ error: 'Curso é obrigatório!' });
    else
        next();
}

module.exports = DisciplineValidation;