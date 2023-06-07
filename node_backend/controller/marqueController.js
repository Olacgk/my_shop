const Marque = require('../model/Marque');

exports.getMarques = (req, res) => {
    Marque.find()
        .then(marques => res.status(200).json(marques))
        .catch(error => res.status(400).json({ error }));
}