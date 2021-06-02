import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:app_gustilandia/src/services/shop_service.dart';
import 'package:app_gustilandia/src/pages/tab_profile.dart';
import 'package:app_gustilandia/src/pages/tab_shop.dart';
import 'package:app_gustilandia/src/pages/tab_store.dart';

class NavigationBar extends StatefulWidget {
  NavigationBar();

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: IndexedStack(
              index: currentIndex,
              children: [
                TabStore(),
                TabShop(),
                TabProfile()
              ],
            )
          ),
          NavigationBarItems(
            index: currentIndex,
            onIndexSelected: (index){
              setState(() {
                currentIndex = index;
                }
              );
            }
          )
        ],
      ),
    );
  }
}

class NavigationBarItems extends StatefulWidget{

  final int index;
  final ValueChanged<int> onIndexSelected;

  const NavigationBarItems({Key key ,this.index, this.onIndexSelected}) : super(key: key);

  @override
  _NavigationBarItemsState createState() => _NavigationBarItemsState();
}

class _NavigationBarItemsState extends State<NavigationBarItems> {
  @override
  Widget build(BuildContext context) {

    final shopService = Provider.of<ShopService>(context);

    return DecoratedBox( 
      decoration: BoxDecoration(
        color: Colors.redAccent.shade100,
        //borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20.0))
      ),
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Colors.redAccent.shade100,
              child: IconButton(
                color: Colors.blue,
                icon: Icon(
                  Icons.store,
                  size: 35.0,
                  color: widget.index == 0 ? Colors.white : Colors.white70,
                ), 
                onPressed: () {
                  widget.onIndexSelected(0);
                }
              ),
            ),
            Material(//para solucionar el problema del tap
              color: Colors.redAccent.shade100,
              child: Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      size: 35.0,
                      color: widget.index == 1 ? Colors.white : Colors.white70,
                    ), 
                    onPressed: () => widget.onIndexSelected(1)
                  ),
                Positioned(
                  right: 0,
                  child: shopService.itemsShop.length == 0 ? SizedBox()
                  : CircleAvatar(
                    radius: 11,
                    backgroundColor: Colors.pink,
                    child: Text(
                      '${shopService.itemsShop.length}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )

                ]
              ),
            ),
            Material(
              color: Colors.redAccent.shade100,
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  size: 35.0,
                  color: widget.index == 2 ? Colors.white : Colors.white70,
                ), 
                onPressed: () => widget.onIndexSelected(2)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
