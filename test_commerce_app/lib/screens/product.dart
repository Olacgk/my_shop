import 'package:flutter/material.dart';
import 'package:test_commerce_app/dbModel/products.dart';
import 'package:test_commerce_app/gestAPI.dart';
import 'package:test_commerce_app/screens/product_add_form.dart';

// class ProductPage extends StatefulWidget {
//   const ProductPage({Key? key}) : super(key: key);
//
//   @override
//   _ProductPageState createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           Row(
//             children: [
//               Container(
//                 width: 200,
//                 child: TextField(
//                   controller: searchController,
//                   decoration: const InputDecoration(
//                     labelText: 'Search',
//                   ),
//                   onChanged: null,
//                 ),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: () {
//                   showDialog(context: context, builder: ( BuildContext context){
//                     return const Dialog(
//                       child: null,
//                     );
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(primary: Colors.black26),
//                 child: const Text('Add'),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16.0),
//
//         ],
//       ),
//     );
//   }
// }

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  // final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          padding: const EdgeInsets.all(16),
        children:[
            Row(
            children: [
              Container(
                width: 200,
                child: const TextField(
                  // controller: searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                  ),
                  onChanged: null,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  showAddProductDialog(context);
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddProductPage()));
                },
                style: ElevatedButton.styleFrom(primary: Colors.black26),
                child: const Text('Add'),
              ),

            ],
          ),
          const SizedBox(height: 16.0),
          FutureBuilder<List<Product>>(
            future: getProducts(),
            builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Erreur lors de la récupération des produits : ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<Product>? products = snapshot.data;
                return products != null
                    ? ProductTable(datalist: products)
                    : Container();
              } else {
                return const Text('Aucun produit trouvé.');
              }
            },
          ),
        ]
      ),
    );
  }
}

class ProductTable extends StatelessWidget {
  const ProductTable({Key? key, required this.datalist}) : super(key: key);
  final List<Product> datalist;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Num. Produit')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Marque')),
          DataColumn(label: Text('Prix')),
          DataColumn(label: Text('En stock')),
          DataColumn(label: Text('Actions'))
        ],
        rows: datalist.map((data) {
          return DataRow(
            cells: [
              DataCell(Text(data.numProduit)),
              DataCell(Text(data.type)),
              DataCell(Text(data.marque)),
              DataCell(Text(data.price)),
              DataCell(Text(data.inStock)),
              const DataCell(Center(
                child: InkWell(
                  onTap: null,
                  child: Icon(Icons.more_horiz, color: Colors.black26,),
                ),
              ))
            ],
          );
        }).toList(),
      ),
    );
  }
}
