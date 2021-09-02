import 'dart:convert';

import 'package:club_deportivo_comala_app/ForgotResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ForgotScreen> {
  TextEditingController nitController = TextEditingController();
  TextEditingController userController = TextEditingController();

  void _handleSubmitted(String _nit, String _user) async {
    ForgotResponse respuesta = await passwordRecovery(_nit, _user);
    if (respuesta.resultado == "false") {
      _showAlert(context, respuesta.error.toString(),
          "Error al Recuperar Contraseña", "Intentar");
    } else {
      _showAlert(context, "Favor de intentar firmarte nuevamente",
          'Correo enviado a ${respuesta.nombre.toString()}', "Continuar");
    }
  }

  Future<ForgotResponse> passwordRecovery(String _nit, String _user) async {
    var _baseUrl =
        Uri.parse("https://www.cgtecsa.com/EqRest/EqAppRecupararPassword.php");
    var _data = {'Nit': '$_nit', 'Usuario': '$_user'};

    final http.Response response = await http.post(_baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(_data));

    ForgotResponse outResponse = new ForgotResponse();

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      outResponse.resultado = map["resultado"];
      outResponse.error = map["error"];
      outResponse.descrip = map["descrip"];
      outResponse.nombre = map["Nombre"];
    } else {
      outResponse.resultado = 'false';
      outResponse.descrip = 'Nit/Usuario no encontrado, intente de nuevo.';
      outResponse.nombre = '';
      outResponse.error = 'Error al recuperar contraseña';
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
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
                      'Olvidé Contraseña',
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
                    keyboardType: TextInputType.name,
                    controller: userController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Usuario',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: Text('Restablecer Contraseña'),
                      onPressed: () {
                        print(nitController.text);
                        print(userController.text);
                        _handleSubmitted(
                            nitController.text, userController.text);
                      },
                    )),
              ],
            )));
  }
}
