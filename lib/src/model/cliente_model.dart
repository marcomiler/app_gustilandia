class Cliente {
  Cliente({
    this.idClient,
    this.fullNameClient,
    this.idDNI,
    this.docDNI,
    this.codSunat,
    this.numberDocDNI,
    this.correoClient,
    this.celular,
    this.direccion,
    this.referencia,
    this.idDistrito,
    this.nameDistrito,
    this.idUsuario,
    this.usuario,
    this.contrasenia,
    this.idRol,
    this.nameRol,
    this.fechaCreacion,
    this.idEstado,
    this.estado,
  });

  int idClient;
  String fullNameClient;
  int idDNI;
  String docDNI;
  String codSunat;
  String numberDocDNI;
  String correoClient;
  String celular;
  String direccion;
  String referencia;
  int idDistrito;
  String nameDistrito;
  int idUsuario;
  String usuario;
  String contrasenia;
  int idRol;
  String nameRol;

  String fechaCreacion;
  int idEstado;
  String estado;

  Cliente.fromJson(Map<String, dynamic> json) {
    idClient = json["idCliente"];
    fullNameClient = json["nombreCompleto"];

    //idDNI = json["documentoIdentidad"]["idDocumentoIdentidad"];

    docDNI = json["documentoIdentidad"]["documentoIdentidad"];

    //codSunat = json["documentoIdentidad"]["codigoSunat"];
    numberDocDNI = json["numeroDocumentoIdentidad"];
    correoClient = json["correo"];
    celular = json["celular"];
    direccion = json["direccion"];
    //referencia = json["referencia"];
    //idDistrito = 0/*json["distrito"]["idDistrito"]*/;
    //nameDistrito = json["distrito"]["distrito"];
    //idUsuario = json["usuario"]["idUsuario"];
    //usuario = json["usuario"]["usuario"];
    //contrasenia = json["usuario"]["contrasenia"];
    //idRol = json["usuario"]["rol"]["idRol"];
    //nameRol = json["usuario"]["rol"]["nombreRol"];
    //fechaCreacion = json["fechaCreacion"];
    //idEstado = json["estado"]["idEstado"];
    //estado = json["estado"]["estado"];
  }
}
