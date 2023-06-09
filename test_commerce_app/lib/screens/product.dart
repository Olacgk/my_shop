import 'package:flutter/material.dart';
import 'package:test_commerce_app/dbModel/products.dart';
import 'package:test_commerce_app/gestAPI.dart';

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
                  showDialog(context: context, builder: ( BuildContext context){
                    return const Dialog(
                      child: null,
                    );
                  });
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
              if(snapshot.hasData) {
                List<Product>? products = snapshot.data;
                return products != null
                    ? ProductTable(datalist: products)
                    : Container();
              } else {
                  return const Center(child: CircularProgressIndicator());
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Num. Produit')),
          DataColumn(label: Text('Type')),
          DataColumn(label: Text('Marque')),
          DataColumn(label: Text('Num. Série')),
          DataColumn(label: Text('En stock')),
          DataColumn(label: Text('Actions'))
        ],
        rows: datalist.map((data) {
          return DataRow(
            cells: [
              DataCell(Text(data.numProduit ?? '')),
              DataCell(Text(data.type ?? '')),
              DataCell(Text(data.marque ?? '')),
              DataCell(Text(data.numSerie ?? '')),
              DataCell(Text(data.inStock ?? '')),
              const DataCell(Center(
                child: InkWell(
                  onTap: null,
                  child: Icon(Icons.visibility, color: Colors.black26,),
                ),
              ))
            ],
          );
        }).toList(),
      ),
    );
  }
}
