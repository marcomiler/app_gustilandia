import 'package:flutter/material.dart';

class DetailsOrder extends StatelessWidget {
  const DetailsOrder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButton(),
            SizedBox(height: 5),
            _statusPedido(),
            SizedBox(height: 5),
            _detailsPedido(),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

Widget _statusPedido() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5.0,
          spreadRadius: 2.0,
          offset: Offset(2.0, 5.0),
        )
      ],
    ),
    child: Column(
      children: [
        Container(
          child: ClipOval(
            child: Image.asset(
              'assets/images/delivery.gif',
              width: 100,
              height: 100,
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Tu pedido está en camino',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _detailsPedido() {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5.0,
          spreadRadius: 2.0,
          offset: Offset(2.0, 5.0),
        )
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _logoInfo(),
        SizedBox(height: 15),
        _showDirection(),
        SizedBox(height: 15),
        Text(
          'TU PEDIDO',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        _showProducts(),
        SizedBox(height: 20),
        _showPayment(),
      ],
    ),
  );
}

Widget _logoInfo() {
  return Row(
    children: [
      ClipOval(
        child: Image.asset(
          'assets/images/logo.jpg',
          width: 60,
          height: 60,
        ),
      ),
      SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gustilandia SAC',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(width: 10),
          Text(
            'Monseñor Edward 1871, San Borja',
            //overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      )
    ],
  );
}

Widget _showDirection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'DIRECCIÓN DE ENTREGA',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 18,
        ),
      ),
      Text(
        'mz E. lote 33, Los Rosales, Los Olivos',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ],
  );
}

Widget _showProducts() {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: EdgeInsets.all(4),
    itemCount: 4,
    itemBuilder: (context, index) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '3',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          Text(
            'Chochman',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          ClipOval(
            child: Image.asset(
              'assets/images/cake1.jpg',
              width: 25,
              height: 25,
            ),
          )
        ],
      );
    },
  );
}

Widget _showPayment() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'TU COBRO',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Text(
        'S/ 50.00',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
