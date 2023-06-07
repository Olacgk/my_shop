const Produit = require('../model/Produit');
const Type = require('../model/Type');
const Marque = require('../model/Marque');


exports.ajoutProduit = async (req, res) => {
    try {
        const { numSerie, marque, type, detail, etat, price } = req.body;

        let typeObj = null;
        let marqueObj = null;

        // Vérifie si le type existe dans la base de données
        const existingType = await Type.findOne({ nom: type });
        if (existingType) {
            existingType.quantite +=1;
            typeObj = existingType;
        } else {
            // Si le type n'existe pas, l'ajoute à la base de données
            const newType = new Type({ nom: type, quantite: 1 });
            typeObj = await newType.save();
        }

        // Vérifie si la marque existe dans la base de données
        const existingMarque = await Marque.findOne({ nom: marque });
        if (existingMarque) {
            existingMarque.quantite +=1;
            marqueObj = existingMarque;
        } else {
            // Si la marque n'existe pas, l'ajoute à la base de données
            const newMarque = new Marque({ nom: marque, quantite: 1 });
            marqueObj = await newMarque.save();
        }

        function generateProductNumber() {
            const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
            let productNumber = '';
          
            // Générer une chaîne aléatoire de longueur 8
            for (let i = 0; i < 8; i++) {
              const randomIndex = Math.floor(Math.random() * chars.length);
              productNumber += chars.charAt(randomIndex);
            }
          
            return productNumber;
          }

        const produit = new Produit({
            numProduit: generateProductNumber(),
            numSerie: numSerie,
            detail: detail,
            etat: etat,
            price: price,
            marque: marqueObj._id,
            type: typeObj._id
        })

        await produit.save();

        res.status(200).json({ message: 'Produit inséré!'})
        marqueObj.save();
        typeObj.save();

    } catch (error) {
        res.status(400).json({error})
    }
};

exports.productInStock = async (req, res) => {
    try {
      const produits = await Produit.find({ inStock: true });
      res.status(200).json(produits);
    } catch (error) {
      res.status(400).json({ error });
    }
  };

  exports.getAllProduit = async (req, res) => {
    try {
      const produits = await Produit.find()
        .populate('marque')
        .populate('type')
        .exec();
  
      const products = produits.map((produit) => {
        return {
          marque: produit.marque.nom,
          type: produit.type.nom,
          price: produit.price + 'Fcfa',
          etat: produit.etat,
          detail: produit.detail,
          numSerie: produit.numSerie,
          numProduit: produit.numProduit,
          inStock: produit.inStock ? 'Oui' : 'Non'
        };
      });
  
      res.status(200).json(products);
    } catch (error) {
      res.status(400).json({ error });
    }
  };
  