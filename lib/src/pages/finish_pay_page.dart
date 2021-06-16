//import 'package:app_gustilandia/src/widget/add_distrito.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:app_gustilandia/src/utils/utils.dart';
import 'package:app_gustilandia/src/model/distrito_model.dart';
import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:app_gustilandia/src/services/cliente_service.dart';
import 'package:app_gustilandia/src/services/distrito_service.dart';
import 'package:app_gustilandia/src/utils/month_picker_dialog.dart';
import 'package:app_gustilandia/src/utils/my_progress_dialog.dart';
import 'package:app_gustilandia/src/services/venta_service.dart';
import 'package:app_gustilandia/src/preferences/profile_preferences.dart';
import 'package:app_gustilandia/src/services/validation_add_distrit_service.dart';
import 'package:app_gustilandia/src/services/validation_finish_shop_service.dart';

class FinishPayPage extends StatefulWidget {
  const FinishPayPage();

  @override
  _FinishPayPageState createState() => _FinishPayPageState();
}

class _FinishPayPageState extends State<FinishPayPage> {
  GlobalKey<FormState> keyFormFinishShop = new GlobalKey();
  GlobalKey<FormState> keyFormAddDirection = new GlobalKey();
  Distrito objDistrito;
  DateTime selectedDate;
  String textVal;
  //bool hasDirection;
  final int idClient = new PreferenciasUsuario().getIdClient;

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 7,
        title: Text(
          "Finaliza tu compra",
          style: TextStyle(
            color: Colors.redAccent.shade200,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        shrinkWrap: false, //para q el scroll se ajuste solo al contenido
        children: <Widget>[
          SizedBox(height: 10),
          createTable(context),
          SizedBox(height: 20),
          createCardPay(context)
        ],
      ),
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

  void _fnFinishPay(BuildContext context) async {
    final clienteService = Provider.of<ClienteService>(context, listen: false);
    final lstCliente = await clienteService.getClientById(idClient);
    final validateShopService =
        Provider.of<ValidationFinishShop>(context, listen: false);
    final shopService = Provider.of<ShopService>(context, listen: false);
    final saleService = Provider.of<VentaService>(context, listen: false);
    ProgressDialog _progressDialog =
        MyProgressDialog.createProgressDialog(context, "Espere un momento...");
    final lstProductos = shopService.itemsShop;
    if (!keyFormFinishShop.currentState.validate()) return;
    keyFormFinishShop.currentState.save();
    final cardName = validateShopService.cardName.value;
    final num1 = validateShopService.cardNumber1.value;
    final num2 = validateShopService.cardNumber2.value;
    final num3 = validateShopService.cardNumber3.value;
    final num4 = validateShopService.cardNumber4.value;
    final cardNumber = '$num1$num2$num3$num4';
    final cardExpirate = validateShopService.cardExpiration.value;
    final cardCvv = validateShopService.cardCvv.value;

    for (var item in lstCliente) {
      if (item.direccion != null && item.direccion.toString().length > 0) {
        _progressDialog.show();
        bool sale = await saleService.registerVenta(
            lstProductos, cardName, cardNumber, cardExpirate, cardCvv);
        _progressDialog.hide();
        if (!sale) {
          _progressDialog.hide();
          mostrarAlerta(context, saleService.messageError);
        } else {
          _progressDialog.hide();
          lstProductos.clear();
          Navigator.pushReplacementNamed(context, 'navigation');
        }
      } else {
        //print("todo bien");
        //_addDirection(context);
      }
    }
  }

  Widget createTable(BuildContext context) {
    final shopService = Provider.of<ShopService>(context);
    final lstProducts = shopService.itemsShop;
    List<DataRow> rows = [];

    for (int i = 0; i < lstProducts.length; ++i) {
      final products = lstProducts[i];
      rows.add(DataRow(cells: [
        DataCell(Row(
          children: [
            CircleAvatar(
              child: FadeInImage(
                height: 100.0,
                width: 80.0,
                image: new NetworkImage(
                    products.product.getImagen(products.product.imagen)),
                placeholder: AssetImage('assets/images/no-image.png'),
                fit: BoxFit.fill,
                fadeOutDuration: Duration(milliseconds: 300),
                fadeInCurve: Curves.easeInToLinear,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              '${products.product.nameProduct}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            )
          ],
        )),
        DataCell(Text('${products.quantity} ${products.product.unidadMedida}')),
        DataCell(Text(
            'S/ ${(products.quantity * products.product.precio).toStringAsFixed(2)}')),
      ]));
    }

    return Flex(
      //En este caso usaremos flex para poder expandir los elementos que lo contienen,
      //pero cuando hay mas columnas es mejor usar SingleChildScrollView para poder scrollear de forma horizontal.
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: DataTable(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 1, style: BorderStyle.solid)),
            headingRowColor: MaterialStateProperty.all(Colors.black),
            showBottomBorder: true,
            columnSpacing: 10.0,
            columns: [
              DataColumn(
                  label: Expanded(
                child: Text(
                  "Producto",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              )),
              DataColumn(
                  label:
                      Text("Cantidad", style: TextStyle(color: Colors.white))),
              DataColumn(
                  label: Text("Total", style: TextStyle(color: Colors.white)),
                  numeric: true),
            ],
            rows: rows,
          ),
        )
      ],
    );
  }

  Widget createCardPay(BuildContext context) {
    final validationService =
        Provider.of<ValidationFinishShop>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 3.0,
                offset: Offset(0.0, 2.0),
                spreadRadius: 3.0)
          ]),
      width: size.width * 0.85,
      height: 500,
      child: Form(
        key: keyFormFinishShop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleCard(),
            SizedBox(height: 10),
            _cardName(validationService),
            SizedBox(height: 10),
            _cardNumber(validationService),
            SizedBox(height: 10),
            _cardExpirationDateAndCvv(validationService),
            SizedBox(height: 10),
            Spacer(),
            _totalAmountPay(),
            SizedBox(height: 10),
            _buttonFinishPay(validationService),
          ],
        ),
      ),
    );
  }

  Widget _titleCard() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        'Por favor complete el formulario con los datos de su Tarjeta de Crédito o Débito y finalice su compra.',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.redAccent.shade400,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _cardName(ValidationFinishShop validation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "NOMBRE DE LA TARJETA",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          maxLength: 40,
          style: TextStyle(
            fontSize: 18,
          ),
          //cursorColor: Colors.redAccent.shade100,
          keyboardType: TextInputType.text,
          onChanged: (String value) {
            validation.changeCardName(value);
          },
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            errorText: validation.cardName.error,
            prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 25),
            prefixIcon: Icon(Icons.credit_card),
            prefixStyle: TextStyle(color: Colors.grey),
            hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
            counterText: "",
          ),
        ),
      ],
    );
  }

  Widget _cardNumber(ValidationFinishShop validation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "NÚMERO DE LA TARJETA",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 4,
                style: TextStyle(fontSize: 25),
                //cursorColor: Colors.redAccent.shade100,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  validation.changeCardNumber1(value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: '0000',
                    errorText: validation.cardNumber1.error,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 25.0),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                    counterText: ""),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 4,
                style: TextStyle(fontSize: 25),
                //cursorColor: Colors.redAccent.shade100,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  validation.changeCardNumber2(value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: '0000',
                    errorText: validation.cardNumber2.error,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 25.0),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                    counterText: ""),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 4,
                style: TextStyle(fontSize: 25),
                //cursorColor: Colors.redAccent.shade100,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  validation.changeCardNumber3(value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    errorText: validation.cardNumber3.error,
                    hintText: '0000',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 25.0),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                    counterText: ""),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                textAlign: TextAlign.center,
                maxLength: 4,
                style: TextStyle(fontSize: 25),
                //cursorColor: Colors.redAccent.shade100,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  validation.changeCardNumber4(value);
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: '0000',
                    errorText: validation.cardNumber4.error,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 25.0),
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                    counterText: ""),
              ),
            ),
            SizedBox(height: 10),
            //
          ],
        ),
      ],
    );
  }

  Widget _cardExpirationDateAndCvv(ValidationFinishShop validation) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "FECHA DE VENCIMIENTO",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: _inputFieldDateController,
              enableInteractiveSelection: false,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
              //cursorColor: Colors.redAccent.shade100,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                validation.changeCardExpiration(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: validation.cardExpiration.error,
                prefixIconConstraints:
                    BoxConstraints(minWidth: 30, minHeight: 25),
                prefixIcon: Icon(Icons.calendar_today),
                prefixStyle: TextStyle(color: Colors.grey),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
              ),
              onTap: () {
                FocusScope.of(context)
                    .requestFocus(new FocusNode()); //quitar el focus
                _selectDateMonth(context);
              },
            ),
          ],
        ),
      ),
      Spacer(),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\nCVV",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              enableInteractiveSelection: false,
              style: TextStyle(fontSize: 25),
              maxLength: 3,
              //cursorColor: Colors.redAccent.shade100,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                validation.changeCardCvv(value);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: validation.cardCvv.error,
                suffixIconConstraints:
                    BoxConstraints(minWidth: 30, minHeight: 25),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
                counterText: "",
                isDense: false,
                suffixIcon: Tooltip(
                  message: 'Presiona para ver la ayuda',
                  child: GestureDetector(
                    child: Icon(Icons.help),
                    onTap: () => showHelpCvv(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ]);
  }

  _selectDateMonth(BuildContext context) async {
    final validat = Provider.of<ValidationFinishShop>(context, listen: false);
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year, 1),
      lastDate: DateTime(DateTime.now().year + 5, 12),
      initialDate: DateTime.now(),
    ).then(
      (date) => setState(() {
        if (date != null && date.toString() != "") {
          var month = '';
          final year = date.year;

          date.month.toString().length == 1
              ? month = '0${date.month}'
              : month = '${date.month}';

          var year2 = year.toString().substring(2, 4);

          validat.changeCardExpiration('$month/$year2');
          _inputFieldDateController.text = '$month/$year2';
        } else {
          validat.changeCardExpiration('');
          _inputFieldDateController.text = "";
        }
      }),
    );
  }

  // Widget _finishButton(BuildContext contexto, ValidationFinishShop validation) {
  //   return InkWell(
  //     child: Text(
  //       'Pagar',
  //       style: TextStyle(
  //         fontWeight: FontWeight.bold,
  //         color: Colors.black,
  //         fontSize: 25,
  //       ),
  //       textAlign: TextAlign.center,
  //     ),
  //     onTap: (!validation.isValid) ? null : () => _fnFinishPay(contexto),
  //   );
  // }

  Widget _buttonFinishPay(ValidationFinishShop validation) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Colors.red,
      ),
      width: double.infinity,
      height: 50,
      child: InkWell(
        child: Text(
          'Pagar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        onTap: (!validation.isValid) ? null : () => _fnFinishPay(context),
      ),
    );
    // return ElevatedButton(
    //   child: Container(
    //     width: double.infinity,
    //     padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
    //     child: Text('Pagar'),
    //   ),
    //   style: ButtonStyle(
    //       //las propiedades seran configuaradas con MaterialStateProperty
    //       shape: MaterialStateProperty.all(
    //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
    //       elevation: MaterialStateProperty.all(0.0),
    //       foregroundColor: MaterialStateProperty.all(Colors.white),
    //       backgroundColor:
    //           MaterialStateProperty.all(Colors.redAccent.shade100)),
    //   onPressed: (!valid.isValid) ? null : () => _fnFinishPay(context),
    // );
  }

  Widget _totalAmountPay() {
    final shopService = Provider.of<ShopService>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Monto Total a Pagar:',
          style: TextStyle(
              color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
        ),
        Text('S/ ${shopService.totalPriceCart.toStringAsFixed(2)}',
            style: TextStyle(
                color: Colors.black,
                fontSize: 23,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  void _addDirection(BuildContext context) {
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
      },
    );
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
}
