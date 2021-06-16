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
    final validateService =
        Provider.of<ValidationEditClientService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 7,
        centerTitle: true,
        title: Text(
          'Editar Perfil',
          style: TextStyle(color: Colors.redAccent.shade200),
        ),
      ),
      body: Form(
        key: keyEditProfile,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            SizedBox(height: 10),
            _inputPhone(validateService),
            SizedBox(height: 10),
            _inputEmail(validateService),
            SizedBox(height: 10),
            _inputDirection(validateService),
            SizedBox(height: 10),
            _inputFullName(validateService),
            SizedBox(height: 10),
            _dropDownDistrict(validateService),
            SizedBox(height: 10),
            _inputDNI(validateService),
            SizedBox(height: 10),
            _inputReference(validateService)
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
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.phone),
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
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.email),
        prefixStyle: TextStyle(color: Colors.grey),
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
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.location_on_outlined),
        prefixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
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
      onChanged: (String value) {
        validate.changeFullName(value);
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.fullName.error,
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.person),
        prefixStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
        labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
      ),
    );
  }

  Widget _dropDownDistrict(ValidationEditClientService validate) {
    final serviceDistrito = Provider.of<DistritoService>(context);
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
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
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.dni.error,
        prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
        prefixIcon: Icon(Icons.crop_7_5_rounded),
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
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorText: validate.reference.error,
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
          'Editar',
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
}
