import 'package:app_gustilandia/src/model/news_models.dart';
import 'package:flutter/material.dart';

class ListNews extends StatelessWidget{

  final List<Article> news;

  const ListNews(this.news);

  @override
  Widget build(BuildContext context) {
    
    return LayoutBuilder(
        builder: (context, constraints){
        final width = constraints.maxWidth;
        final itemHeight = (width*0.5) / 0.65;
        final height = constraints.maxHeight + itemHeight;

        return OverflowBox(
          maxWidth: width,
          maxHeight: height,
          minHeight: height,
          minWidth: width,
          child: GridView.builder(
            padding: EdgeInsets.only(top: itemHeight/2, bottom: itemHeight),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0
            ),
            itemCount: news.length,
            itemBuilder: (BuildContext context, index){
              return Transform.translate(
                offset: Offset(0.0, index.isOdd ? itemHeight *0.5 : 0.0),
                child: _TarjetaTopBar(news[index]/*, index*/),
              );
            },

          ),
        );
      }
    );

  }

}

class _TarjetaTopBar extends StatelessWidget {

  final Article noticia;
  /*final int index;*/

  const _TarjetaTopBar(this.noticia, /*this.index*/);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.only(left: 10.0, right: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        shadowColor: Colors.black54,
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ClipOval(
              child: AspectRatio(
              aspectRatio: 1,
              child: _showImage(noticia),
              )
              )
            ),
            SizedBox(height: 10.0,),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    noticia.title, 
                    maxLines: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                    ),
                  ),
                  _showActhor(noticia)
                  // Text(
                  //   noticia.author, 
                  //   maxLines: 2,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w300,
                  //     fontSize: 11,
                  //     color: Colors.grey
                  //   ),
                  // ),
                ],
              )
            ),
          ],
        )
      ),
      onTap: () {},
    );
  }
}

Widget _showActhor(Article noticia){

  if(noticia.author != null && noticia.author != ''){
      return Text(
      noticia.author, 
      maxLines: 2,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 11,
        color: Colors.grey
      ),
    );
  }else{
    return Text(
      'Autor no definido',
      maxLines: 2,
      style: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 11,
        color: Colors.grey
      ),
    );
  }

}

Widget _showImage(Article noticia) {

  if(noticia.urlToImage != null && noticia.urlToImage != ''){
    return FadeInImage(
      image: NetworkImage(noticia.urlToImage),
      placeholder: AssetImage('assets/images/loading.gif'),
      fit: BoxFit.cover,
    );
  }else{
    return Image(
      image: AssetImage('assets/images/no-image.png'),
      fit: BoxFit.cover,
    );
  }

}
