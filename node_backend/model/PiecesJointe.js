const mongoose = require('mongoose');
const uniqueValidator = require('mongoose-unique-validator');

// Schéma de la pièce jointe
const attachmentSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true
  },
  path: {
    type: String,
    required: true
  },
  mimeType: {
    type: String,
    required: true
  },
  size: {
    type: Number,
    required: true
  },
  uploadedAt: {
    type: Date,
    default: Date.now
  }
});

attachmentSchema.plugin(uniqueValidator);

module.exports = mongoose.model('Attachment', attachmentSchema);
