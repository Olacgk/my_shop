import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:test_commerce_app/dbModel/products.dart';

class GestAPI {
  
  Future<List<Product>> getProducts() async {
    var response = await http.get(Uri.parse('http://127.0.0.1:5000/api/produit/products'));
    if(response.statusCode == 200) {
      var result = jsonDecode(response.body);
      List jsonResponse = result["products"] as List;
      return jsonResponse.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}