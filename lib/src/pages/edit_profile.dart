import 'package:app_gustilandia/src/utils/my_progress_dialog.dart';
import 'package:app_gustilandia/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import 'package:app_gustilandia/src/model/distrito_model.dart';
import 'package:app_gustilandia/src/services/cliente_service.dart';
import 'package:app_gustilandia/src/services/distrito_service.dart';
import 'package:app_gustilandia/src/services/validation_edit_client_service.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> keyEditProfile = new GlobalKey();
  Distrito objDistrito;

  @override
  Widget build(BuildContext context) {
    final validateService = Provider.of<ValidationEditClientService>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 7,
        title: Text(
          "Editar Perfil",
          style: TextStyle(
            color: Colors.redAccent.shade200,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: keyEditProfile,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            _titleProfile(),
            SizedBox(height: 15),
            _inputFullName(validateService),
            SizedBox(height: 15),
            _inputEmail(validateService),
            SizedBox(height: 15),
            _inputDNI(validateService),
            SizedBox(height: 15),
            _inputPhone(validateService),
            SizedBox(height: 15),
            _dropDownDistrict(validateService),
            SizedBox(height: 15),
            _inputDirection(validateService),
            SizedBox(height: 15),
            _inputReference(validateService),
            SizedBox(height: 15),
            _buttonEditProfile(validateService),
            SizedBox(height: 10),
            _buttonCancelProfile(context),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void _fnEditProfile() async {
    final clientService = Provider.of<ClienteService>(context, listen: false);
    final validateService =
        Provider.of<ValidationEditClientService>(context, listen: false);
    ProgressDialog _progressDialog =
        MyProgressDialog.createProgressDialog(context, "Espere un momento...");
    if (!keyEditProfile.currentState.validate()) return;
    keyEditProfile.currentState.save();

    final phone = validateService.phone.value;
    final email = validateService.email.value;
    final direction = validateService.direction.value;
    final fullName = validateService.fullName.value;
    final idDistrito = int.parse(validateService.idDistrito.value);
    final dni = validateService.dni.value;
    final reference = validateService.reference.value;

    _progressDialog.show();
    bool editProfile = await clientService.editClient(
        phone, email, direction, idDistrito, fullName, dni, reference);
    if (!editProfile) {
      _progressDialog.hide();
      mostrarAlerta(context, clientService.messageError);
    } else {
      _progressDialog.hide();
      Navigator.pushReplacementNamed(context, 'profile');
    }
  }

  Widget _titleProfile() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        'Usted puede editar la información de su perfil completando el formulario con sus datos personales y guardando los cambios.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black54,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _inputFullName(ValidationEditClientService validate) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
      ),
      //cursorColor: Colors.redAccent.shade100,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      onChanged: (String value) {
        validate.changeFullName(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.fullName.error,
        labelText: "Nombre completo",
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.person),
        prefixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }

  Widget _inputEmail(ValidationEditClientService validate) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
      ),
      //cursorColor: Colors.redAccent.shade100,
      keyboardType: TextInputType.emailAddress,
      onChanged: (String value) {
        validate.changeEmail(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.email.error,
        labelText: "Correo electrónico",
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.email),
        prefixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }

  Widget _inputDNI(ValidationEditClientService validate) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
      ),
      //cursorColor: Colors.redAccent.shade100,
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        validate.changeDNI(value);
      },
      maxLength: 8,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.dni.error,
        labelText: "Documento de Identidad(DNI)",
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.crop_7_5_rounded),
        prefixStyle: TextStyle(color: Colors.grey),
        counterText: "",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }

  Widget _inputDirection(ValidationEditClientService validate) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
      ),
      //cursorColor: Colors.redAccent.shade100,
      keyboardType: TextInputType.text,
      onChanged: (String value) {
        validate.changeDirection(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.direction.error,
        labelText: "Dirección",
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.location_on_outlined),
        prefixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }

  Widget _dropDownDistrict(ValidationEditClientService validate) {
    final serviceDistrito = Provider.of<DistritoService>(context);
    return Container(
      child: FutureBuilder(
          future: serviceDistrito.getDistritos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Distrito> distritos = snapshot.data;

              return DropdownButtonFormField<Distrito>(
                hint: Text("Seleccione un Distrito"),
                items:
                    distritos.map<DropdownMenuItem<Distrito>>((Distrito dist) {
                  return DropdownMenuItem<Distrito>(
                    value: dist,
                    child: Text(dist.nameDistrito),
                  );
                }).toList(),
                onChanged: (val) {
                  validate.changeDistrito(val.idDistrito);
                  setState(() {
                    objDistrito = val;
                  });
                },
                value: objDistrito,
                decoration: InputDecoration(
                  errorText: validate.idDistrito.error,
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

  Widget _inputPhone(ValidationEditClientService validate) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
      ),
      //cursorColor: Colors.redAccent.shade100,
      keyboardType: TextInputType.number,
      onChanged: (String value) {
        validate.changePhone(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.phone.error,
        labelText: "Celular",
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.phone),
        prefixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }

  Widget _inputReference(ValidationEditClientService validate) {
    return TextFormField(
      style: TextStyle(
        fontSize: 18,
      ),
      //cursorColor: Colors.redAccent.shade100,
      keyboardType: TextInputType.text,
      onChanged: (String value) {
        validate.changeReference(value);
      },
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.reference.error,
        labelText: "Referencia",
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.location_city),
        prefixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }

  Widget _buttonEditProfile(ValidationEditClientService validate) {
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
          'Guardar Cambios',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        )),
      ),
      onTap: !validate.isValid ? null : () => _fnEditProfile(),
    );
  }

  Widget _buttonCancelProfile(BuildContext contexto) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.blue,
        ),
        width: double.infinity,
        height: 50,
        child: InkWell(
            child: Text(
          'Cancelar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        )),
      ),
      onTap: () => Navigator.pushReplacementNamed(contexto, 'profile'),
    );
  }
}
