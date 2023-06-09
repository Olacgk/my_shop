import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_commerce_app/dbModel/products.dart';

// Future<List<Product>> getProducts() async {
//   var response = await http.get(Uri.parse('http://127.0.0.1:5000/api/produit/products'));
//     var result = jsonDecode(response.body);
//   if(response.statusCode == 200) {
//     List jsonResponse = result["products"] as List;
//     return jsonResponse.map((e) => Product.fromJson(e)).toList();
//     // return List<Product>.from(result.map((elt)=> Product.fromJson(elt))).toList();
//   } else {
//     throw Exception(response.reasonPhrase);
//   }
// }

Future<List<Product>> getProducts() async {
  var response = await http.get(Uri.parse('http://127.0.0.1:5000/api/produit/products'));
  var result = jsonDecode(response.body);

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = result as List<dynamic>;
    return jsonResponse.map((e) => Product.fromJson(e)).toList();
  } else {
    throw Exception(response.reasonPhrase);
  }
}
