// To parse this JSON data, do
//
//     final inventoryResponse = inventoryResponseFromJson(jsonString);

import 'dart:convert';

InventoryResponse inventoryResponseFromJson(String str) =>
    InventoryResponse.fromJson(json.decode(str));

String inventoryResponseToJson(InventoryResponse data) =>
    json.encode(data.toJson());

class InventoryResponse {
  InventoryResponse({this.resultado, this.data, this.error, this.query});

  String? resultado;
  List<Datum>? data;
  String? error;
  String? query;

  factory InventoryResponse.fromJson(Map<String, dynamic> json) =>
      InventoryResponse(
        resultado: json["resultado"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
        query: json["Query"],
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
        "Query": query,
      };
}

class Datum {
  Datum({
    this.codigo,
    this.producto,
    this.existencia,
    this.precio1,
    this.precio2,
    this.precio3,
    this.precio4,
  });

  String? codigo;
  String? producto;
  String? existencia;
  String? precio1;
  String? precio2;
  String? precio3;
  String? precio4;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        codigo: json["CODIGO"],
        producto: json["PRODUCTO"],
        existencia: json["EXISTENCIA"],
        precio1: json["PRECIO1"],
        precio2: json["PRECIO2"],
        precio3: json["PRECIO3"],
        precio4: json["PRECIO4"],
      );

  Map<String, dynamic> toJson() => {
        "CODIGO": codigo,
        "PRODUCTO": producto,
        "EXISTENCIA": existencia,
        "PRECIO1": precio1,
        "PRECIO2": precio2,
        "PRECIO3": precio3,
        "PRECIO4": precio4,
      };
}
