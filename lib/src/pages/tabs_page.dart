import 'package:app_gustilandia/src/pages/tab_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //escucha los cambios en toda la pagina
    return ChangeNotifierProvider(
      create: (_) => new _NavegacionModel(),
      child: Scaffold(
        body: _Paginas(),
        bottomNavigationBar: _Navegacion(),
      ),
    );
  }

}

class _Navegacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
      currentIndex: navegacionModel.currentPage,
      onTap: (i) => navegacionModel.currentPage = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Go to Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile')
      ],
    );
  }

}


class _Paginas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navegacionModel = Provider.of<_NavegacionModel>(context);
    
    return PageView(
        controller: navegacionModel.pageController,
        // physics: BouncingScrollPhysics(),
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          TabHome(),
          Container( 
            color: Colors.green
          ),
          Container( 
            color: Colors.grey
          )
        ],
    );
  }
}


class _NavegacionModel with ChangeNotifier{

  int _currentPage = 0;
  PageController _pageController = new PageController();


  int get currentPage => this._currentPage;
  set currentPage (int value) {
    this._currentPage = value;

    _pageController.animateToPage(value, duration: Duration(milliseconds: 250), curve: Curves.easeOut);
    notifyListeners();
  } 

  PageController get pageController => this._pageController;

}