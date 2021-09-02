import 'dart:convert';

import 'package:club_deportivo_comala_app/InventoryResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InventoryPage extends StatefulWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<InventoryPage> {
  InventoryResponse respuesta = new InventoryResponse();
  List<Datum> lines = [];

  void _onBottonTapped() {
    _handleSubmitted();
  }

  void _handleSubmitted() async {
    respuesta = await getInventory();
    if (respuesta.resultado == "false") {
      _showAlert(context, respuesta.error.toString(),
          "Error al Obtener el Inventario", "Intentar");
    } else {}
  }

  Future<InventoryResponse> getInventory() async {
    lines.clear();
    var queryData =
        'SELECT a.id_codigo AS CODIGO, a.producto as PRODUCTO,ifnull(SUM(b.entrada-b.salida),0) AS EXISTENCIA,  a.precio1 as PRECIO1, a.precio2 AS PRECIO2, a.precio3 AS PRECIO3, a.precio4 AS PRECIO4 FROM inventario a INNER JOIN kardexinven b ON(a.id_codigo= b.id_codigo) GROUP BY a.id_codigo';
    var _baseUrl = Uri.parse("https://www.cgtecsa.com/EqRest/EqAppQuery.php");
    var _data = {'Nit': '800000001026', 'Query': '$queryData'};

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
        lines.add(Datum.fromJson(e));
      });
    } else {
      outResponse.resultado = 'false';
      outResponse.query = _data.toString();
      outResponse.error = 'Error al recuperar el Inventario';
    }
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (lines.length == 0)
            ? Expanded(
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _onBottonTapped,
                    child: Text(
                      'Generar Listado',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
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
                          title: Container(
                            child: Text(
                                '(${lines[index].codigo.toString()}) - ${lines[index].producto.toString()}',
                                style: TextStyle(fontSize: 12)),
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
              )
      ],
    );
  }
}
