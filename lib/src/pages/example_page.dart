import 'package:app_gustilandia/src/model/categoria_model.dart';
import 'package:app_gustilandia/src/services/producto_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExamplePage extends StatelessWidget {
  ExamplePage();

  @override
  Widget build(BuildContext context) {

    //final prodService = Provider.of<ProductoService>(context);

    return Scaffold(
      body: Container(),
    );
  }
}

// class _ListaCategorias extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {

//     // final newsService = Provider.of<NewsService>(context);

//     // final categories = Provider.of<NewsService>(context).categories;
//     final prodService = Provider.of<ProductoService>(context);
//     final categories = Provider.of<ProductoService>(context).categories;
//     final _color = Colors.white38;

//     return Container(
//       decoration: BoxDecoration(
//         color: _color,
//       ),
//       width: double.infinity,
//       height: 80,
//       child: ListView.builder(
//         physics: BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (BuildContext context, int index){

//           final cName = categories[index].categoria;

//           return Padding(
//             padding: EdgeInsets.all(8),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(height: 5,),
//                 Text(
//                   '${cName[0].toUpperCase()}${cName.substring(1)}',
//                   style: TextStyle(
//                     color: Colors.redAccent.shade200,
//                     // fontWeight: newsService.selectedCategory == categories[index].name
//                    fontWeight: prodService.selectedCategory == categories[index].id
//                     ? FontWeight.bold
//                     : FontWeight.normal
//                   ),
//                 )
//               ],
//             ),
//           );
//         }
//       ),
//     );
//   }
// }