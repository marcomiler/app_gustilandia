import 'package:app_gustilandia/src/model/category.model.dart';
import 'package:app_gustilandia/src/services/news_service.dart';
import 'package:app_gustilandia/src/theme/theme.dart';
import 'package:app_gustilandia/src/widget/list_news.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabStore extends StatefulWidget {

  

  @override
  _TabTabStoreState createState() => _TabTabStoreState();
}

class _TabTabStoreState extends State<TabStore> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.white,
        backgroundColor: mytheme.backgroundColor,
          body : Column(
            children: <Widget>[
            _ListaCategorias(),

            if(!newsService.isLoading)
              Expanded(
                child: ListNews(newsService.getArticleCategorySelected),
              ),
            
            if(newsService.isLoading)
            Expanded( 
              child: Center(
                child: CircularProgressIndicator()
              ),
            )
          ]
          )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListaCategorias extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    final categories = Provider.of<NewsService>(context).categories;
    final _color = Colors.white38;

    return Container(
      decoration: BoxDecoration(
        color: _color,
      ),
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index){

          final cName = categories[index].name;

          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _CategoryButton(categories[index]),
                SizedBox(height: 5,),
                Text(
                  '${cName[0].toUpperCase()}${cName.substring(1)}',
                  style: TextStyle(
                    color: Colors.redAccent.shade200,
                    fontWeight: newsService.selectedCategory == categories[index].name
                    ? FontWeight.bold
                    : FontWeight.normal
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget{

  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: (){
        final newsService = Provider.of<NewsService>(context, listen: false);//en false en este caso para que el widget no se redibuje
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (newsService.selectedCategory == this.category.name)
          ? Colors.redAccent.shade200
          : Colors.redAccent.shade100,
        ),
        child: Icon(
          category.icon,
          color: (newsService.selectedCategory == this.category.name)
          ? Colors.white
          : Colors.white60,
          size: (newsService.selectedCategory == this.category.name)
          ? 26
          : 18
        ),
      ),
    );
  }

}