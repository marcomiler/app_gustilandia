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
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _showImage(noticia),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0,),
                Column(
                  children: [
                    SizedBox(height: 10.0,),
                    Text(
                      'Pie de Manzana',
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    _showActhor(noticia),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ],
            ),
          ],
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(2.0, 5.0)
            )
          ]
        ),
      ),
    );
  }
}



Widget _showActhor(Article noticia){

  if(noticia.author != null && noticia.author != ''){
      return Text(
      'S/ 15.0', 
      maxLines: 2,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 30,
        color: Colors.blue
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
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
        child: FadeInImage(
          height: 220,
          width: double.infinity,
          image: NetworkImage(noticia.urlToImage),
          placeholder: AssetImage('assets/images/giphy.gif'),
          fit: BoxFit.fill,
          fadeOutDuration: Duration(milliseconds: 300),
          fadeInCurve: Curves.easeInToLinear,
        ),
      ),
    );
  }else{
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
        child: Image(
          width: double.infinity,
          height: 220,
          image: AssetImage('assets/images/no-image-available.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}