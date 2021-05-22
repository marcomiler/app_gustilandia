// import 'dart:convert';
import 'package:flutter/material.dart';

class CategoryModel {

  IconData icon;
  String categoria;

  CategoryModel(this.icon, this.categoria);

}

// CategoriaResponse categoriaResponseFromJson(String str) => CategoriaResponse.fromJson(json.decode(str));

// String categoriaResponseToJson(CategoriaResponse data) => json.encode(data.toJson());

// class CategoriaResponse {
//     CategoriaResponse({
//         this.success,
//         this.result,
//         this.message,
//         this.icon,
//     });

//     bool success;
//     List<Categoria> result;
//     String message;
//     IconData icon;

//     factory CategoriaResponse.fromJson(Map<String, dynamic> json) => CategoriaResponse(
//         success: json["success"],
//         result: json["result"] ? List<Categoria>.from(json["result"].map((x) => Categoria.fromJson(x))) : [],
//         message: json["message"],
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "result": List<dynamic>.from(result.map((x) => x.toJson())),
//         "message": message,
//     };
// }

// class Categoria {
//     Categoria({
//         this.idCategoria,
//         this.categoria,
//         this.fechaCrea,
//         this.usuarioCrea,
//         this.usuarioEdita,
//         this.estado,
//         this.fechaEdita,
//     });

//     int idCategoria;
//     String categoria;
//     DateTime fechaCrea;
//     UsuarioCrea usuarioCrea;
//     dynamic usuarioEdita;
//     int estado;
//     dynamic fechaEdita;

//     factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
//         idCategoria: json["idCategoria"],
//         categoria: json["categoria"],
//         fechaCrea: DateTime.parse(json["fechaCrea"]),
//         usuarioCrea: UsuarioCrea.fromJson(json["usuarioCrea"]),
//         usuarioEdita: json["usuarioEdita"],
//         estado: json["estado"],
//         fechaEdita: json["fechaEdita"],
//     );

//     Map<String, dynamic> toJson() => {
//         "idCategoria": idCategoria,
//         "categoria": categoria,
//         "fechaCrea": "${fechaCrea.year.toString().padLeft(4, '0')}-${fechaCrea.month.toString().padLeft(2, '0')}-${fechaCrea.day.toString().padLeft(2, '0')}",
//         "usuarioCrea": usuarioCrea.toJson(),
//         "usuarioEdita": usuarioEdita,
//         "estado": estado,
//         "fechaEdita": fechaEdita,
//     };
// }

// class UsuarioCrea {
//     UsuarioCrea({
//         this.idUsuario,
//         this.usuario,
//         this.contrasenia,
//         this.rol,
//     });

//     int idUsuario;
//     Usuario usuario;
//     Contrasenia contrasenia;
//     Rol rol;

//     factory UsuarioCrea.fromJson(Map<String, dynamic> json) => UsuarioCrea(
//         idUsuario: json["idUsuario"],
//         usuario: usuarioValues.map[json["usuario"]],
//         contrasenia: contraseniaValues.map[json["contrasenia"]],
//         rol: Rol.fromJson(json["rol"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "idUsuario": idUsuario,
//         "usuario": usuarioValues.reverse[usuario],
//         "contrasenia": contraseniaValues.reverse[contrasenia],
//         "rol": rol.toJson(),
//     };
// }

// enum Contrasenia { C000032, M000042 }

// final contraseniaValues = EnumValues({
//     "C000032": Contrasenia.C000032,
//     "M000042": Contrasenia.M000042
// });

// class Rol {
//     Rol({
//         this.idRol,
//         this.nombreRol,
//     });

//     int idRol;
//     NombreRol nombreRol;

//     factory Rol.fromJson(Map<String, dynamic> json) => Rol(
//         idRol: json["idRol"],
//         nombreRol: nombreRolValues.map[json["nombreRol"]],
//     );

//     Map<String, dynamic> toJson() => {
//         "idRol": idRol,
//         "nombreRol": nombreRolValues.reverse[nombreRol],
//     };
// }

// enum NombreRol { ALMACENERO }

// final nombreRolValues = EnumValues({
//     "almacenero": NombreRol.ALMACENERO
// });

// enum Usuario { CARLOS_MARTINEZ_LIANA, MARITSA_JIMENEZ_ALDANA }

// final usuarioValues = EnumValues({
//     "Carlos Martinez Liñana": Usuario.CARLOS_MARTINEZ_LIANA,
//     "Maritsa Jimenez Aldana": Usuario.MARITSA_JIMENEZ_ALDANA
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
