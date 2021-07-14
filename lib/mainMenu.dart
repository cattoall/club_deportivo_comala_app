import 'package:club_deportivo_comala_app/InventoryPage.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<MainMenu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    InventoryPage(),
    Text(
      'Index 0: Consulta de Inventario',
      style: optionStyle,
    ),
    Text(
      'Index 1: Consulta de Inventario Consolidado',
      style: optionStyle,
    ),
    Text(
      'Index 2: Ingreso de Factura',
      style: optionStyle,
    ),
    Text(
      'Index 3: Consulta de Clientes',
      style: optionStyle,
    ),
    Text(
      'Index 4: Corte de Caja',
      style: optionStyle,
    ),
    Text(
      'Index 5: Usuario',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Equilibrium POS')),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Inventario',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_outlined),
            label: 'Consolidado',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_library_books_outlined),
            label: 'Factura',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Clientes',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            label: 'Caja',
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: 'Usuario',
            backgroundColor: Colors.blueGrey,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white70,
        onTap: _onItemTapped,
      ),
    );
  }
}
