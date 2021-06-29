import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.resultado,
    this.error,
    this.descrip,
    this.nombre,
  });

  String? resultado;
  String? error;
  String? descrip;
  String? nombre;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        resultado: json["resultado"],
        error: json["error"],
        descrip: json["descrip"],
        nombre: json["Nombre"],
      );

  Map<String, dynamic> toJson() => {
        "resultado": resultado,
        "error": error,
        "descrip": descrip,
        "Nombre": nombre,
      };
}
