import 'package:club_deportivo_comala_app/models/Forgot_model.dart';
import 'package:club_deportivo_comala_app/pages/ForgotPage.dart';
import 'package:club_deportivo_comala_app/pages/InventoryPage.dart';
import 'package:club_deportivo_comala_app/pages/LoginPage.dart';
import 'package:club_deportivo_comala_app/pages/MainMenuPage.dart';
import 'package:club_deportivo_comala_app/pages/RegisterPage.dart';
import 'package:club_deportivo_comala_app/pages/StockPage.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => MainMenu(), //LoginPage(),
    'register': (BuildContext context) => RegisterPage(),
    'forget': (BuildContext context) => ForgotPage(),
    'mainMenu': (BuildContext context) => MainMenu(),
    'inventory': (BuildContext context) => InventoryPage(),
    'stock': (BuildContext context) => StockPage(),
  };
}
