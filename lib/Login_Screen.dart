import 'dart:convert';
import 'dart:io';

import 'package:club_deportivo_comala_app/Forgot_Screen.dart';
import 'package:club_deportivo_comala_app/LoginResponse.dart';
import 'package:club_deportivo_comala_app/Register_Screen.dart';
import 'package:club_deportivo_comala_app/mainMenu.dart';
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

  void _handleSubmitted(String _nit, String _user, String _pass) async {
    LoginResponse respuesta = await userLogin(_nit, _user, _pass);
    if (respuesta.resultado == "false") {
      _showAlert(context, respuesta.error.toString(), "Error al Iniciar Sesión",
          "Intentar de nuevo");
    } else {
      _showAlert(context, respuesta.descrip.toString(),
          'Bienvenido ${respuesta.nombre.toString()}', "Continuar");
    }
  }

  Future<LoginResponse> userLogin(
      String _nit, String _user, String _pass) async {
    var _baseUrl = Uri.parse("https://www.cgtecsa.com/EqRest/EqAppAut.php");
    String _base64PassEncoded = base64.encode(utf8.encode(_pass));
    var _data = {
      'Nit': '$_nit',
      'Usuario': '$_user',
      'Clave': '$_base64PassEncoded'
    };

    final http.Response response = await http.post(_baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(_data));

    LoginResponse outResponse = new LoginResponse();

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      outResponse.resultado = map["resultado"];
      outResponse.error = map["error"];
      outResponse.descrip = map["descrip"];
      outResponse.nombre = map["Nombre"];
    } else {
      outResponse.resultado = 'false';
      outResponse.error = 'Error #: ${response.statusCode}';
      outResponse.descrip = 'Error al intentar consumir el REST API';
      outResponse.nombre = '';
    }
    return outResponse;
  }

  void _showAlert(
      BuildContext context, String _error, String _title, String _boton) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(_title),
            content: Text(_error),
            actions: [
              FlatButton(
                  onPressed: () {
                    if (_boton != 'Continuar') {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => MainMenu(),
                          ),
                          (route) => false);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => MainMenu(),
                      //   ),
                      // );
                    }
                  },
                  child: Text(_boton))
            ],
          );
        });
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
                        _handleSubmitted('800000001026', 'ADMIN',
                            'Clave01*                 ');
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
