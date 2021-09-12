import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:club_deportivo_comala_app/models/Inventory_model.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<InventoryPage> {
  InventoryResponse respuesta = new InventoryResponse();
  List<Datum> lines = [];
  bool isLoading = false;

  void _onBottonTapped(String onValue) {
    _handleSubmitted(onValue);
  }

  void _handleSubmitted(String onValue) async {
    respuesta = await getInventory(onValue);
    if (respuesta.resultado == "false") {
      _showAlert(context, respuesta.error.toString(),
          "Error al Obtener el Inventario", "Intentar");
    } else {}
  }

  Future<InventoryResponse> getInventory(String onValue) async {
    lines.clear();
    var queryData =
        'SELECT a.id_codigo AS CODIGO, a.codigoe AS CODIGOE, a.producto as PRODUCTO,ifnull(SUM(b.entrada-b.salida),0) AS EXISTENCIA,  a.precio1 as PRECIO1, a.precio2 AS PRECIO2, a.precio3 AS PRECIO3, a.precio4 AS PRECIO4 FROM inventario a INNER JOIN kardexinven b ON(a.id_codigo= b.id_codigo) WHERE a.producto like "%$onValue%" GROUP BY a.id_codigo';
    var _baseUrl = Uri.parse("https://www.cgtecsa.com/EqRest/EqAppQuery.php");
    var _data = {'Nit': '800000001026', 'Query': '$queryData'};

    isLoading = true;
    print(jsonEncode(_data));
    final http.Response response = await http.post(_baseUrl,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(_data));

    InventoryResponse outResponse = new InventoryResponse();

    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      outResponse.resultado = map["resultado"];
      outResponse.error = map["error"];
      outResponse.query = map["Query"];
      //outResponse.data = map["Data"];

      map["Data"].forEach((e) {
        print(e);
        lines.add(Datum.fromJson(e));
      });
    } else {
      outResponse.resultado = 'false';
      outResponse.query = _data.toString();
      outResponse.error = 'Error al recuperar el Inventario';
    }
    print('Lineas: ${lines.length.toString()}');

    isLoading = false;
    setState(() {});
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

  Future<String> createAlert(BuildContext context) async {
    TextEditingController txtText = TextEditingController();

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa Código o Producto'),
            content: TextField(
              controller: txtText,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(txtText.text.toString());
                },
                elevation: 5.0,
                child: Text('Buscar...'),
              )
            ],
          );
        });
  }

  Future<String> createAlertInv(
      BuildContext context, String sProductCode, String sProductName) async {
    TextEditingController txtText = TextEditingController();

    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Existencias...'),
            content: Column(
              children: [
                Text('$sProductCode - $sProductName'),
              ],
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop(txtText.text.toString());
                },
                elevation: 5.0,
                child: Text('Buscar...'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Consulta de Inventario',
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
        Container(
          child: (isLoading == true)
              ? CircularProgressIndicator(
                  value: 50,
                  semanticsLabel: 'Cargando...',
                )
              : Text(''),
        ),
        (lines.length == 0)
            ? Expanded(
                child: Container(
                    // width: double.infinity,
                    // alignment: Alignment.center,
                    // child: ElevatedButton(
                    //   onPressed: _onBottonTapped,
                    //   child: Text(
                    //     'Generar Listado',
                    //     style: TextStyle(fontSize: 18, color: Colors.white),
                    //   ),
                    // ),
                    ),
              )
            : Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(2),
                  itemCount: lines.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: (index % 2 == 0)
                          ? Colors.grey[300]
                          : Colors.blue[200],
                      height: 40,
                      margin: EdgeInsets.all(20),
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            print(lines[index].codigo.toString());
                          },
                          title: Container(
                            child: Text(
                              '(${lines[index].codigo.toString()} - ${lines[index].codigoe.toString()}) - ${lines[index].producto.toString()}',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          subtitle: Card(
                              elevation: 1,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${lines[index].existencia.toString()}',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      width: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${lines[index].precio1.toString()}',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${lines[index].precio2.toString()}',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${lines[index].precio3.toString()}',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                              '${lines[index].precio4.toString()}',
                                              style: TextStyle(fontSize: 12)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    );
                  },
                ),
              ),
        Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
              onPressed: () {
                createAlert(context).then((value) {
                  _onBottonTapped(value);
                });
              },
              child: Icon(Icons.search),
              backgroundColor: Colors.green),
        )
      ],
    );
  }
}
