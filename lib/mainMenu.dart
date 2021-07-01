import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.inventory_2_outlined)),
              Tab(icon: Icon(Icons.inventory_outlined)),
              Tab(icon: Icon(Icons.ballot_outlined)),
              Tab(icon: Icon(Icons.my_library_books_outlined)),
              Tab(icon: Icon(Icons.people_alt_outlined)),
              Tab(icon: Icon(Icons.attach_money_outlined)),
              Tab(icon: Icon(Icons.perm_identity)),
            ],
          ),
          title: Center(child: Text('Equilibrium POS')),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.inventory_2_outlined),
            Icon(Icons.inventory_outlined),
            Icon(Icons.ballot_outlined),
            Icon(Icons.my_library_books_outlined),
            Icon(Icons.people_alt_outlined),
            Icon(Icons.attach_money_outlined),
            Icon(Icons.perm_identity),
          ],
        ),
      ),
    );
  }
}
