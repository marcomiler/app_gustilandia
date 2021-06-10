import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinishPayPage extends StatelessWidget {
  const FinishPayPage();

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
        children: [
          createTable(context),
        ],
      ),
    );
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
        mainAxisSize: MainAxisSize.min,
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
                label: Text("Cantidad", style: TextStyle(color: Colors.white))),
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
