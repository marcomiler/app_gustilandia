import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListPedidosClient extends StatelessWidget {
  //constructor con el listado de pedidos

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return TargetPedidos();
      },
    );
  }
}

class TargetPedidos extends StatelessWidget {
  //constructor con el pedido
  const TargetPedidos();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        'details-order', /*arguments: producto*/
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(2.0, 5.0))
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _showHead(),
              SizedBox(height: 5.0),
              _totalItems(),
              SizedBox(height: 5.0),
              _totalPrice(),
              SizedBox(height: 15.0),
              _showDate(),
              //_showEstatus(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _showDate() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '12/06/2021',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 22,
        ),
      ),
      Text(
        '15:33',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 22,
        ),
      )
    ],
  );
}

Widget _showHead() {
  return Row(children: [
    Icon(
      FontAwesomeIcons.clipboard,
      size: 18,
      color: Colors.grey.shade600,
    ),
    Text(
      'Orden ID: ',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
    SizedBox(width: 5.0),
    Text(
      'F0000000000000-1',
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.start,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  ]);
}

Widget _totalItems() {
  return Row(
    children: [
      Icon(
        FontAwesomeIcons.shoppingBag,
        size: 18,
        color: Colors.grey.shade600,
      ),
      Text(
        'Total items: ',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Text(
        '5 productos',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      )
    ],
  );
}

Widget _totalPrice() {
  return Row(
    children: [
      Icon(
        FontAwesomeIcons.coins,
        size: 15,
        color: Colors.grey.shade600,
      ),
      SizedBox(width: 5),
      Text(
        'Total: ',
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Text(
        'S/ 50.00',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
      ),
      Spacer(),
      Container(
        padding: EdgeInsets.all(5),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Recibido',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  );
}

Widget _showEstatus() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.all(5),
        width: 100,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Recibido',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
    ],
  );
}
