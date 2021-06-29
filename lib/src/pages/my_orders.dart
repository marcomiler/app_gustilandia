import 'package:app_gustilandia/src/widget/list_pedidos_client.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 7,
        centerTitle: true,
        title: Text(
          'Mis Ordenes',
          style: TextStyle(
            color: Colors.redAccent.shade200,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListPedidosClient(),
    );
  }
}
