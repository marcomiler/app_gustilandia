// import 'dart:convert';

// productoResponseFromJson(String str) =>
// Producto.fromJson(json.decode(str)/*.map((x) => Producto.fromJson(x))*/);

// String productoResponseToJson(List<Producto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Productos{

//   List<Producto> items = [];
//   Productos();

//   Productos.fromJsonList(Map<String, dynamic> jsonList){
//     if(jsonList == null) return;
//     for(var item in jsonList){
//       final producto = new Producto.fromJson(item);
//       items.add(producto);
//     }
//   }

// }

class Producto {
  Producto({
    this.idProducto,
    this.nameProduct,
    this.descripcion,
    this.precio,
    this.imagen,
    this.stock,
    this.idUnidadMedida,
    this.idMarca,
    this.unidadMedida,
    this.nameMarca,
  });

  String uniqueId;
  int idProducto;
  String nameProduct;
  String descripcion;
  double precio;
  String imagen;
  int stock;
  int idUnidadMedida;
  int idMarca;
  String unidadMedida;
  String nameMarca;
  // int quantity;

  Producto.fromJson(Map<String, dynamic> json) {
    idProducto = json["idProducto"];
    nameProduct = json["nameProduct"];
    descripcion = json["descripcion"];
    precio = json["precio"].toDouble();
    imagen = json["imagen"];
    stock = json["stock"];
    idUnidadMedida = json["idUnidadMedida"];
    idMarca = json["idMarca"];
    unidadMedida = json["unidadMedida"];
    nameMarca = json["nameMarca"];
  }

  Map<String, dynamic> toJson() => {
        "idProducto": idProducto,
        "nameProduct": nameProduct,
        "descripcion": descripcion,
        "precio": precio,
        "imagen": imagen,
        "stock": stock,
        "idUnidadMedida": idUnidadMedida,
        "idMarca": idMarca,
        "unidadMedida": unidadMedida,
        "nameMarca": nameMarca,
  };

  getImagen(String img) {
    if (imagen == null || imagen == "") {
      return 'https://www.fabricocina.com/wp-content/uploads/2018/06/image_large.png';
    } else {
      return 'http://192.168.0.106:8085/backendgusti/files/img/producto/$img';
    }
  }
}
