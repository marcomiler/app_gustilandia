import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_gustilandia/src/utils/utils.dart';

import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:app_gustilandia/src/utils/month_picker_dialog.dart';

class FinishPayPage extends StatefulWidget {
  const FinishPayPage();

  @override
  _FinishPayPageState createState() => _FinishPayPageState();
}

class _FinishPayPageState extends State<FinishPayPage> {
  DateTime selectedDate;
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Finaliza tu compra"),
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        shrinkWrap: false, //para q el scroll se ajuste solo al contenido
        children: <Widget>[
          createTable(context),
          SizedBox(
            height: 20,
          ),
          createCardPay(context)
        ],
      ),
    );
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
                offset: Offset(0.0, 5.0),
                spreadRadius: 3.0)
          ]),
      width: size.width * 0.85,
      height: 350,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cardName(),
            SizedBox(height: 10),
            _cardNumber(),
            SizedBox(height: 10),
            _cardExpirationDateAndCvv(),
            SizedBox(height: 10),
            _totalAmountPay(),
            Spacer(),
            _buttonFinishPay(),
          ],
        ),
      ),
    );
  }

  Widget _cardName() {
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
          //onChanged:
          textCapitalization: TextCapitalization.characters,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIconConstraints:
                  BoxConstraints(minWidth: 30, minHeight: 25),
              prefixIcon: Icon(Icons.credit_card),
              prefixStyle: TextStyle(color: Colors.grey),
              hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
              labelStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
              errorMaxLines: 5,
              counterText: ""),
        ),
      ],
    );
  }

  Widget _cardNumber() {
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
                //onChanged:
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
                //onChanged:
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
                //onChanged:
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
                //onChanged:
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: '0000',
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

  Widget _cardExpirationDateAndCvv() {
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
              //onChanged:
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
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
              //onChanged:
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
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

          _inputFieldDateController.text = '$month/$year2';
        } else {
          _inputFieldDateController.text = "";
        }
      }),
    );
  }

  Widget _buttonFinishPay() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
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
        onTap: () {},
      ),
    );
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
}
