
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addToFavorite.dart';
class FavoriteWidget extends StatefulWidget {
  String a="";
  String b="";
  //Set<String> _saved = Set<String>();
  //String Function(String) callback;
  FavoriteWidget(this.a,this.b);
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(a,b);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  String a="";
  String b="";
  //Future<String> _counter=<String>[] as Future<String>;
  //Set<String> _saved = Set<String>();
  _FavoriteWidgetState(this. a,this.b);
 // SharedPref? sharedPreferences;

  // User userSave = User(a,b);
  // User userLoad = User();
  List<User> category = <User>[];
  String key = 'stringValue';
  load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String categoryStr = prefs.getString(key)??"";
    category = User.decode(categoryStr);
  }
 bool _isFavorited=false;

save() async {
   load();
    final prefs = await SharedPreferences.getInstance();
    User userAdd= User(a,b);
    category.add(userAdd);
    String a1=User.encode(category);
    prefs.setString(key,a1);
  }

  remove() async {
    load();
    final prefs = await SharedPreferences.getInstance();
    User userAdd= User(a,b);
    category.remove(userAdd);
    String a1=User.encode(category);
    prefs.setString(key,a1);
  }
   _toggleFavorite(String paira,String pairb) {
    setState(() {
      if (!_isFavorited) {
       // sharedPreferences?.save();
        save();
       // ?.setData()
      //  _favoriteCount += 1;
       // _saved.add(pair);
        _isFavorited = true;
       // widget.callback(_saved);

      } else {
      //  _favoriteCount -= 1;
        remove();
        _isFavorited = false;
       // _saved.remove(pair);
        //print("state:'_saved'");
      }

    }
    );
  }


  @override
  Widget build(BuildContext context) {
     String paira=a.toString();
     String pairb=b.toString();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
              color: _isFavorited ? Colors.white : null,
            onPressed: (){ _toggleFavorite(paira,pairb);}
          ),
        ),
        SizedBox(
          width: 18,
          // child: Container(
          //   child: Text('$_favoriteCount'),
          // ),
        )
      ],
    );
  }


}