import 'package:flutter/material.dart';

class MyDataTable extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Container(
              width: 200,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                ),
                onChanged: null,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Ajouter le code pour gérer le bouton d'ajout
              },
              child: Text('Add'),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Column 1')),
            DataColumn(label: Text('Column 2')),
            DataColumn(label: Text('Column 3')),
          ],
          rows: List<DataRow>.generate(
            100,
                (index) => DataRow(
              cells: [
                DataCell(Text('Row $index')),
                DataCell(Text('Row $index')),
                DataCell(Text('Row $index')),
              ],
            ),
          ),
        ),
      ),
    ]
    );
  }
}
