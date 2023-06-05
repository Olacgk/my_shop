const Produit = require('../model/Produit');
const Facture = require('../model/Facture');
const Client = require('../model/Client');
const User = require('../model/User');
const PiecesJointe = require('../model/PiecesJointe');
const multer = require('multer');
const path = require('path');
const { v4: uuidv4 } = require('uuid');
const Type = require('../model/Type');
const Marque = require('../model/Marque');

// Configuration de multer pour gérer l'importation de fichiers
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = uuidv4();
    cb(null, uniqueSuffix + '-' + file.originalname);
  }
});

const upload = multer({ storage: storage });

exports.ajoutFacture = async (req, res) => {
    try {
        const { nomClient, numClient, statut, editeur, lignes, tva } = req.body;

        let client = null; // Correction : utiliser "let" au lieu de "const"

        // Vérifie si le client existe dans la base de données
        const existingClient = await Client.findOne({ nom: nomClient });
        if (existingClient) {
            client = existingClient._id;
        } else {
            const newClient = new Client({ nom: nomClient, numClient: numClient, statut: statut });
            client = await newClient.save();
        }


        // calcul du prix Nette
        let prixNette = 0;
        for (let i = 0; i < lignes.length; i++) {
            const produit = await Produit.findById(lignes[i].produit);
            prixNette += produit.price * lignes[i].quantite;
        }

        // calcul du prix TTC
        let prixTTC = prixNette + (prixNette * (tva / 100));

        // Génération du numéro de facture
        const generateInvoiceNumber = () => {
            // Obtenez la date actuelle
            const date = new Date();
            
            // Générez un numéro aléatoire entre 1000 et 9999
            const randomNumber = Math.floor(Math.random() * (9999 - 1000 + 1) + 1000);
            
            // Concaténez la date et le numéro aléatoire pour former le numéro de facture
            const factNum = `${date.getFullYear()}${date.getMonth() + 1}${date.getDate()}${randomNumber}`;
            
            return factNum;
        };

        // Importation de la pièce jointe
        upload.single('pieceJointe')(req, res, async function (err) {
          if (err instanceof multer.MulterError) {
            // Une erreur s'est produite lors de l'importation de la pièce jointe
            return res.status(500).json({ message: 'Une erreur s\'est produite lors de l\'importation de la pièce jointe.' });
          } else if (err) {
            // Une autre erreur s'est produite
            return res.status(500).json({ message: 'Une erreur s\'est produite.' });
          }

          // Vérifier si une pièce jointe a été importée
          let pieceJointeUrl = null;
          if (req.file) {
            pieceJointeUrl = req.file.path;

            const pieceJointes = new PiecesJointe({
              path: pieceJointeUrl,
              size: req.file.size,
              mimetype: req.file.mimetype
            });
            await pieceJointes.save();
          }

          const facture = new Facture({
              numContrat: generateInvoiceNumber(),
              client: client,
              editeur: editeur,
              lignes: lignes,
              tva: tva,
              prixNette: prixNette,
              prixTTC: prixTTC,
              pieceJointe: pieceJointes._id 
          });
          await facture.save();
          res.status(200).json({ message: 'Facture insérée!' });
        });
    } catch (error) {
        res.status(400).json({error})
    }
};

exports.listeFactures = async (req, res) => {
    try {
        const factures = await Facture.find().populate('client').populate('editeur').populate('pieceJointe').populate('lignes.produit');
        res.status(200).json({ factures });
    } catch (error) {
        res.status(400).json({error})
    }
};

exports.canceledFacture = async (req, res) => {
    try {
        const facture = await Facture.findById(req.params.id);
        if (facture && facture.statut == 'En cours') {
            facture.statut = 'Annulé';
            await facture.save();
            res.status(200).json({ message: 'Facture annulée!' });
        } else {
            res.status(404).json({ message: 'Facture non trouvée!' });
        }
    } catch (error) {
        res.status(400).json({error})
    }
};

exports.validerFacture = async (req, res) => {
    try {
        const facture = await Facture.findById(req.params.id);
        if (facture && facture.statut == 'En cours') {
            facture.statut = 'Validé';
            await facture.save();
            facture.lignes.forEach(async (ligne) => {
                const produit = await Produit.findById(ligne.produit);
                produit.inStock = false;
                const type = await Type.findById(produit.type);
                type.quantite -= ligne.quantite;
                const marque = await Marque.findById(produit.marque);
                marque.quantite -= ligne.quantite;
                await marque.save();
                await type.save();
                await produit.save();
            });
            res.status(200).json({ message: 'Facture validée!' });
        } else {
            res.status(404).json({ message: 'Facture non trouvée!' });
        }
    } catch (error) {
        res.status(400).json({error})
    }
};