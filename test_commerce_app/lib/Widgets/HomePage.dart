import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedMenu = 'Accueil'; // Menu sélectionné par défaut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grafico'),
        backgroundColor: Colors.black26,
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 200,
            color: Colors.grey[200],
            child: ListView(
              children: [
                ListTile(
                  title: Text('Accueil'),
                  selected: _selectedMenu == 'Accueil',
                  onTap: () {
                    setState(() {
                      _selectedMenu = 'Accueil';
                    });
                  },
                ),
                ListTile(
                  title: Text('Contrats'),
                  selected: _selectedMenu == 'Contrats',
                  onTap: () {
                    setState(() {
                      _selectedMenu = 'Contrats';
                    });
                  },
                ),
                ListTile(
                  title: Text('Clients'),
                  selected: _selectedMenu == 'Clients',
                  onTap: () {
                    setState(() {
                      _selectedMenu = 'Clients';
                    });
                  },
                ),
                ListTile(
                  title: Text('Produits'),
                  selected: _selectedMenu == 'Produits',
                  onTap: () {
                    setState(() {
                      _selectedMenu = 'Produits';
                    });
                  },
                ),
              ],
            ),
          ),
          // Contenu de la page en fonction du menu sélectionné
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: _buildPageContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    // Construction du contenu de la page en fonction du menu sélectionné
    switch (_selectedMenu) {
      case 'Accueil':
        return Center(
          child: Text('Page d\'accueil'),
        );
      case 'Contrats':
        return Center(
          child: Text('Page des contrats'),
        );
      case 'Clients':
        return Center(
          child: Text('Page des clients'),
        );
      case 'Produits':
        return Center(
          child: Text('Page des produits'),
        );
      default:
        return Container();
    }
  }
}
