import 'dart:convert';
import 'dart:io';

import 'package:club_deportivo_comala_app/Forgot_Screen.dart';
import 'package:club_deportivo_comala_app/LoginResponse.dart';
import 'package:club_deportivo_comala_app/Register_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nitController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visible = false;

  Future<List<LoginResponse>> userLogin(
      String _nit, String _user, String _pass) async {
    var _baseUrl = Uri.parse("https://www.cgtecsa.com/EqRest/EqAppAut.php");
    var _data = {'Nit': '$_nit', 'Usuario': '$_user', 'Clave': '$_pass'};
    print(jsonEncode(_data));

    final http.Response response = await http.post(_baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(_data));

    if (response.statusCode == 200) {
      //print(json.decode(response.body));
      //List responseJson = json.decode(response.body);
      //return responseJson.map((e) => new LoginResponse.fromJson(e)).toList();
      //return response.body;
      throw Exception('Failed to create album.');
    } else {
      throw Exception('Faileds to create album.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Equilibrium POS'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Inicio de Sesión',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: nitController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'NIT',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: userController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Usuario',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña',
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotScreen()),
                    );
                  },
                  textColor: Colors.blue,
                  child: Text('Olvidé Contraseña'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Entrar'),
                      onPressed: () {
                        userLogin('800000001026', 'ADMIN', 'Prueba');
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('¿No tienes cuenta?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Registro',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
