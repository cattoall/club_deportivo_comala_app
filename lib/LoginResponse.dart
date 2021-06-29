class LoginResponse {
  String? resultado;
  String? error;
  String? descrip;

  LoginResponse({this.resultado, this.error, this.descrip});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    resultado = json['resultado'];
    error = json['error'];
    descrip = json['descrip'];
  }
}
