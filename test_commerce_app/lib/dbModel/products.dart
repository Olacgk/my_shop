class Product {
  final String? id;
  final String numProduit;
  final String numSerie;
  final String detail;
  final String etat;
  final String inStock;
  final String type;
  final String marque;
  final double price;

  Product(
      {
        this.id,
      required this.numProduit,
      required this.numSerie,
      required this.detail,
      required this.etat,
      required this.inStock,
      required this.marque,
      required this.price,
      required this.type});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["_id"],
      numProduit: json["numProduit"],
      numSerie: json["numSerie"],
      detail: json["detail"],
      etat: json["etat"],
      inStock: json["inStock"],
      marque: json["marque"],
      price: json["price"],
      type: json["type"]);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "numProduit": numProduit,
        "numSerie": numSerie,
        "detail": detail,
        "etat": etat,
        "inStock": inStock,
        "marque": marque,
        "price": price,
        "type": type
      };
}
