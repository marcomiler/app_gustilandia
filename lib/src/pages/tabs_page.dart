import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:app_gustilandia/src/pages/tab_store.dart';
import 'package:app_gustilandia/src/pages/tab_shop.dart';
import 'package:app_gustilandia/src/pages/tab_profile.dart';


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
      iconSize: 20,
      elevation: 6,
      selectedFontSize: 15.0,
      backgroundColor: Colors.redAccent.shade100,
      fixedColor: Colors.white,
      unselectedItemColor: Colors.white60,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      currentIndex: navegacionModel.currentPage,
      onTap: (i) => navegacionModel.currentPage = i,
      items: [
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.store), label: 'Comprar',),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.shoppingCart,  size: 22,), label: 'Carrito'),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.userAlt), label: 'Perfil')
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
          TabStore(),
          TabShop(),
          TabProfile()
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