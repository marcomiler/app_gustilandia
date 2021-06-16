import 'package:app_gustilandia/src/model/distrito_model.dart';
import 'package:app_gustilandia/src/services/cliente_service.dart';
import 'package:app_gustilandia/src/services/distrito_service.dart';
import 'package:app_gustilandia/src/services/validation_add_distrit_service.dart';
import 'package:app_gustilandia/src/utils/my_progress_dialog.dart';
import 'package:app_gustilandia/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class AddDistrito extends StatefulWidget {
  AddDistrito();

  @override
  _AddDistritoState createState() => _AddDistritoState();
}

class _AddDistritoState extends State<AddDistrito> {
  GlobalKey<FormState> keyFormAddDirection = new GlobalKey();
  Distrito objDistrito;

  @override
  Widget build(BuildContext context) {
    final validationDistritoService =
        Provider.of<ValidationAddDistritoService>(context, listen: false);
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            content: Form(
              key: keyFormAddDirection,
              child: Container(
                height: 400, //variar
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0, right: 10, left: 10, bottom: 10),
                      child: Text(
                        'Al parecer no ha agregado una dirección en su perfil, por favor ingrese una dirección para registrar su compra',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    _crearDropDown(validationDistritoService),
                    SizedBox(height: 10),
                    _createDirection(validationDistritoService),
                    SizedBox(height: 10),
                    _createReference(validationDistritoService),
                    SizedBox(height: 20),
                    _buttonaddDirection(validationDistritoService)
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _crearDropDown(ValidationAddDistritoService validation) {
    final serviceDistrito = Provider.of<DistritoService>(context);
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: FutureBuilder(
          future: serviceDistrito.getDistritos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Distrito> distritos = snapshot.data;

              return DropdownButtonFormField<Distrito>(
                //key: UniqueKey(),
                hint: Text("Seleccione un Distrito"),
                items:
                    distritos.map<DropdownMenuItem<Distrito>>((Distrito dist) {
                  return DropdownMenuItem<Distrito>(
                    value: dist,
                    child: Text(dist.nameDistrito),
                  );
                }).toList(),
                onChanged: (val) {
                  validation.changeDistrito(val.idDistrito);
                  setState(() {
                    objDistrito = val;
                  });
                },
                value: objDistrito,
                decoration: InputDecoration(
                  errorText: validation.distrito.error,
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 30, minHeight: 25),
                  prefixIcon: Icon(Icons.location_on),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            } else {
              return Text("Cargando distritos...");
            }
          }),
    );
  }

  Widget _createDirection(ValidationAddDistritoService validation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        maxLines: 2,
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18),
        //cursorColor: Colors.redAccent.shade100,
        keyboardType: TextInputType.multiline,
        onChanged: (String value) {
          validation.changeDireccion(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Ingrese su dirección...',
          errorText: validation.direccion.error,
          prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
          prefixIcon: Icon(Icons.location_on_outlined),
          prefixStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
          labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _createReference(ValidationAddDistritoService validation) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 18),
        maxLines: 2,
        //cursorColor: Colors.redAccent.shade100,
        keyboardType: TextInputType.multiline,
        onChanged: (String value) {
          validation.changeReferencia(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Ingrese una referencia...',
          errorText: validation.referencia.error,
          prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
          prefixIcon: Icon(Icons.location_city),
          prefixStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
          labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _buttonaddDirection(ValidationAddDistritoService validation) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.red,
        ),
        width: double.infinity,
        height: 50,
        child: InkWell(
            child: Text(
          'Agregar dirección',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        )),
      ),
      onTap: (!validation.isValid) ? null : () => _fnAddDistrito(),
    );
  }

  void _fnAddDistrito() async {
    final clienteService = Provider.of<ClienteService>(context, listen: false);
    final validationAddDistritoService =
        Provider.of<ValidationAddDistritoService>(context, listen: false);
    ProgressDialog _progressDialog =
        MyProgressDialog.createProgressDialog(context, "");
    if (!keyFormAddDirection.currentState.validate()) return;
    keyFormAddDirection.currentState.save();

    final idDistrito = int.parse(validationAddDistritoService.distrito.value);
    final direction = validationAddDistritoService.direccion.value;
    final reference = validationAddDistritoService.referencia.value;

    _progressDialog.hide();
    bool addDistrict = await clienteService.editDirectionClient(
        idDistrito, direction, reference);
    _progressDialog.hide();
    if (!addDistrict) {
      _progressDialog.hide();
      mostrarAlerta(context, clienteService.messageError);
    } else {
      _progressDialog.hide();
      //Navigator.pop(context);//
      Navigator.of(context).pop();
    }
  }
}
