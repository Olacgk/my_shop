const Type = require('../model/Type');

exports.getTypes = (req, res) => {
    Type.find()
        .then(types => res.status(200).json(types))
        .catch(error => res.status(400).json({ error }));
};
