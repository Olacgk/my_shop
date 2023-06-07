const User = require('../model/User');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

exports.createUser = (req, res) => {
  try {
    const { name, username, password, role } = req.body;

   bcrypt.hash(password, 10)
   .then(hash =>{
    const user = new User({
        name: name,
        username: username,
        password: hash,
        role: role
    });
    user.save()
    .then(() => res.status(201).json({ message: 'Utilisateur créé !'}))
    .catch(error => res.status(400).json({ error }));
   })
  } catch (error) {
    res.status(500).json({ error: 'Une erreur est survenue lors de la création de l\'utilisateur.', error });
  }
};

exports.login = (req, res ) => {
    try {
        const { username, password} = req.body;

        User.findOne({username})
        .then(user=>{
            if(!user || !user.active){
                return res.status(401).json({error:'Utilisateur non trouvé!'})
            }
            bcrypt.compare(password, user.password)
            .then(valide=>{
                if (!valide) {
                    return res.status(401).json({error:'Mot de passe incorrect!'})
                }
                res.status(200).json({
                    message: `Utilisateur ${user.name} connecté!`, 
                    token : jwt.sign(
                        { _id : user._id } , 
                        'RANDOM_TOKEN_SECRET' , 
                        { expiresIn : '12h' }
                    )
                });
            })
            .catch(error =>{
              return res.status(500).json({error});
            })
        })
    } catch (error) {
        return res.status(500).json({error});
    }
}

exports.getAllUsers = (req, res) => {
    User.find()
    .then(users => res.status(200).json(users))
    .catch(error => res.status(400).json({ error }));
};

exports.desactivateUser = (req, res) => {
    try {
        User.updateOne({_id: req.params.id}, {active: false})
        .then(() => res.status(200).json({ message: 'Utilisateur désactivé !'}))
        .catch(error => res.status(400).json({ error }));
    } catch (error) {
        res.status(500).json({ error: 'Une erreur est survenue lors de la désactivation de l\'utilisateur.', error });
    }
};

exports.changePassword = (req, res) => {
    try {
        const { oldPassword, password } = req.body;
        User.findOne({_id: req.params.id})
        .then(user=>{
            if(!user){
                return res.status(401).json({error:'Utilisateur non trouvé!'})
            }
            bcrypt.compare(oldPassword, user.password)
            .then(valide=>{
                if (!valide) {
                    return res.status(401).json({error:'Mot de passe incorrect!'})
                }
            })
            .catch(error =>{
              return res.status(500).json({error});
            })
        })
        bcrypt.hash(password, 10)
        .then(hash =>{
            User.updateOne({_id: req.params.id}, {password: hash})
            .then(() => res.status(200).json({ message: 'Mot de passe modifié !'}))
            .catch(error => res.status(400).json({ error }));
        })
    } catch (error) {
        res.status(500).json({ error: 'Une erreur est survenue lors de la modification du mot de passe.', error });
    }
};
