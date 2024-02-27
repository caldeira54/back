const CourseValidation = async (req, res, next) => {
    const { name } = req.body;

    if (!name)
        return res.status(400).json({ error: 'Nome é obrigatório!' });
    else
        next();
}

module.exports = CourseValidation;