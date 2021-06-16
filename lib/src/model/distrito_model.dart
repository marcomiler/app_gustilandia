class Distrito {
  Distrito({this.idDistrito, this.nameDistrito});
  int idDistrito;
  String nameDistrito;

  //con esto solucionamos el problema del dropdown,
  //no estoy seguro si es la mejor solucion pero de momento lo es.
  //https://stackoverflow.com/questions/56111840/flutter-dropdown-value   :Abdul Moeed => autor de la respuesta
  bool operator ==(o) =>
      o is Distrito &&
      o.idDistrito == idDistrito &&
      o.nameDistrito == nameDistrito;

  Distrito.fromJson(Map<String, dynamic> json) {
    idDistrito = json["idDistrito"];
    nameDistrito = json["distrito"];
  }
}
