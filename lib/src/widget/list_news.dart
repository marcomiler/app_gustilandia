import 'package:app_gustilandia/src/model/news_models.dart';
import 'package:flutter/material.dart';

class ListNews extends StatelessWidget{

  final List<Article> news;

  const ListNews(this.news);

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, index){
        return _TarjetaTopBar(news[index]);
      },
    );
  }

}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;

  const _TarjetaTopBar(this.noticia,);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, 'details', arguments: noticia);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,),
        width: double.infinity,
        height: 150.0,
        child: Card(
          color: Colors.white,
          //margin: EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          shadowColor: Colors.black87,
          elevation: 8,
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _showImage(noticia),
              SizedBox(height: 10.0,),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Pie de Manzana',
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      SizedBox(height: 5.0,),
                      _showActhor(noticia),
                      SizedBox(height: 10.0,),
                      Container(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: (){},
                          child: Text(
                            'Ver',
                            style: TextStyle(
                              fontSize: 15
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

Widget _showActhor(Article noticia){

  if(noticia.author != null && noticia.author != ''){
      return Text(
      'S/. 15.0', 
      maxLines: 2,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 25,
        color: Colors.grey
      ),
    );
  }else{
    return Text(
      'lorem ipsum',
      maxLines: 2,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 25,
        color: Colors.grey
      ),
    );
  }

}

Widget _showImage(Article noticia) {

  if(noticia.urlToImage != null && noticia.urlToImage != ''){
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        child: FadeInImage(
          width: 180,
          height: 150,
          image: NetworkImage(noticia.urlToImage),
          placeholder: AssetImage('assets/images/giphy.gif'),
          fit: BoxFit.cover,
          fadeOutDuration: Duration(milliseconds: 1500),
        ),
      ),
    );
  }else{
    return Container(
      padding: EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        child: Image(
          width: 180,
          height: 150,
          image: AssetImage('assets/images/no-image-available.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}


// class ListNews extends StatelessWidget{

//   final List<Article> news;

//   const ListNews(this.news);

//   @override
//   Widget build(BuildContext context) {
    
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 10.0),
//       child: LayoutBuilder(
//           builder: (context, constraints){
//           final width = constraints.maxWidth;
//           final itemHeight = (width*0.2) / 0.65;
//           final height = constraints.maxHeight + itemHeight;

//           return OverflowBox(
//             maxWidth: width,
//             maxHeight: height,
//             minHeight: height,
//             minWidth: width,
//             child: GridView.builder(
//               padding: EdgeInsets.only(top: itemHeight/2, bottom: itemHeight),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.8,
//                 crossAxisSpacing: 0.0,
//                 mainAxisSpacing: 10.0
//               ),
//               itemCount: news.length,
//               itemBuilder: (BuildContext context, index){
//                 return Transform.translate(
//                   offset: Offset(0.0, index.isOdd ? itemHeight *0.5 : 0.0),
//                   child: _TarjetaTopBar(news[index]),
//                 );
//               },

//             ),
//           );
//         }
//       ),
//     );

//   }

// }

// class _TarjetaTopBar extends StatelessWidget {

//   final Article noticia;

//   const _TarjetaTopBar(this.noticia,);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){},
//       child: Container(
//         child: Card(
//           color: Colors.white,
//           margin: EdgeInsets.only(left: 10.0, right: 10.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10)
//           ),
//           shadowColor: Colors.black87,
//           elevation: 7,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             //mainAxisSize: MainAxisSize.max,
//             children: <Widget>[
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
//                   child: _showImage(noticia),
//                 ),
//               ),
//               SizedBox(height: 10.0,),
//               Expanded(
//                 child: Padding(
//                   padding: EdgeInsets.all(5.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         noticia.title, 
//                         maxLines: 2,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 13
//                         ),
//                       ),
//                       SizedBox(height: 10.0,),
//                       _showActhor(noticia)
//                     ],
//                   ),
//                 )
//               ),
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }



