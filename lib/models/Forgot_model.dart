import 'dart:convert';

ForgotResponse forgotResponseFromJson(String str) =>
    ForgotResponse.fromJson(json.decode(str));

String forgotResponseToJson(ForgotResponse data) => json.encode(data.toJson());

class ForgotResponse {
  ForgotResponse({
    this.resultado,
    this.nombre,
    this.descrip,
    this.error,
  });

  String? resultado;
  String? nombre;
  String? descrip;
  String? error;

  factory ForgotResponse.fromJson(Map<String, dynamic> json) => ForgotResponse(
        resultado: json["resultado"],
        nombre: json["Nombre"],
        descrip: json["descrip"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "Nombre": nombre,
        "descrip": descrip,
        "error": error,
      };
}
