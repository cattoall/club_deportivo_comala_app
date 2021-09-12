import 'dart:convert';

StockResponse stockResponseFromJson(String str) =>
    StockResponse.fromJson(json.decode(str));

String stockResponseToJson(StockResponse data) => json.encode(data.toJson());

class StockResponse {
  StockResponse({
    this.resultado,
    this.error,
    this.data,
  });

  String? resultado;
  String? error;
  List<Datum>? data;

  factory StockResponse.fromJson(Map<String, dynamic> json) => StockResponse(
        resultado: json["resultado"],
        error: json["error"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "error": error,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.bodega,
    this.existencia,
  });

  String? bodega;
  String? existencia;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        bodega: json["BODEGA"],
        existencia: json["EXISTENCIA"],
      );

  Map<String, dynamic> toJson() => {
        "BODEGA": bodega,
        "EXISTENCIA": existencia,
      };
}
