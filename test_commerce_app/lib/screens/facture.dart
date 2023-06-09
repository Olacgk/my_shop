import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test_commerce_app/dbModel/products.dart';
import 'package:test_commerce_app/gestAPI.dart';

/// Example without a datasource
class DataTable2SimpleDemo extends StatelessWidget {
  const DataTable2SimpleDemo();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erreur lors de la récupération des produits : ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Product>? products = snapshot.data;
          return products != null
              ? ContratTable(datalist: products)
              : Container();
        } else {
          return const Text('Aucun produit trouvé.');
        }
      },
    );
  }
}

class ContratTable extends StatelessWidget {
  const ContratTable({Key? key, required this.datalist}) : super(key: key);
  final List<Product> datalist;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text('Column A'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Column B'),
            ),
            DataColumn(
              label: Text('Column C'),
            ),
            DataColumn(
              label: Text('Column D'),
            ),
            DataColumn(
              label: Text('Column NUMBERS')
            ),
            DataColumn(label: Text('Data'))
          ],
          rows: datalist.map((data) {
            return DataRow(
              cells: [
                DataCell(Text(data.numProduit)),
                DataCell(Text(data.type)),
                DataCell(Text(data.marque)),
                DataCell(Text(data.numSerie)),
                DataCell(Text(data.inStock)),
                const DataCell(Center(
                  child: InkWell(
                    onTap: null,
                    child: Icon(Icons.visibility, color: Colors.black26,),
                  ),
                ))
              ],
            );
          }).toList(),),
    );
  }
}