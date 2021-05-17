import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListPerfil extends StatelessWidget {
  ListPerfil();

  @override
  Widget build(BuildContext context) {

    Color color = Colors.redAccent.shade100;

    return ListView(
      children: <Widget>[
        Divider(),
        _itemList('Editar Perfil', Icon(FontAwesomeIcons.edit, color: color,), ()=> Navigator.pushNamed(context, 'edit_profile'), color, true),
        Divider(),
        _itemList('Mis Ordenes', Icon(FontAwesomeIcons.shoppingBag, color: color,), ()=> Navigator.pushNamed(context, 'bagShoping'), color, true),
        Divider(),
        _itemList('Acerca de Gustilandia', Icon(FontAwesomeIcons.infoCircle, color: color,), ()=> Navigator.pushNamed(context, 'about'), color, true),
        Divider(),
        _itemList('Cerrar Sesión', Icon(FontAwesomeIcons.signOutAlt, color: color,), (){}, color, false),
      ],
    );
  }


  Widget _itemList(String text, Icon icon, VoidCallback callback, Color color, bool trail) {

    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Color(0XFF4a503d),
          fontWeight: FontWeight.bold,
          fontSize: 16
        ),
      ),
      leading: icon,
      trailing: (trail == true)
      ? Icon(Icons.keyboard_arrow_right, color: color)
      : null,
      onTap: callback,
    );
  }
}