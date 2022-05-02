
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';
import 'addToFavorite.dart';
import 'package:async/async.dart';
class FavoriteWidget extends StatefulWidget {
  String a="";
  String b="";

  //Set<String> _saved = Set<String>();
 // Function callback;
 FavoriteWidget(this.a,this.b);
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(this.a,this.b);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  String a="";
  String b="";

  _FavoriteWidgetState(this. a,this.b);
  List<User> category = <User>[];
  String key = 'stringValue';
  bool _isFavorited=false;

  // @override
  // void initState() {
  //   super.initState();
  //   _memoizer = AsyncMemoizer();
  // }

 load() async {
  // bool _isFavorited=true;
   //print(a.toString());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String categoryStr = prefs.getString(key)??"";
    category = User.decode(categoryStr);
    User userAdd= User(a,b);
    _isFavorited=category.map((item) => item.name).contains(userAdd.name);
     print(_isFavorited);
     print(category.toList());

  }


save() async {
//    _isFavorited = true;
    load();
    final prefs = await SharedPreferences.getInstance();
    User userAdd= User(a,b);
    category.add(userAdd);
    String a1=User.encode(category);
    prefs.setString(key,a1);
    print(a1);
  _isFavorited = true;
  }

  remove() async {
    load();
    final prefs = await SharedPreferences.getInstance();
    User item= User(a,b);
    category.removeWhere((item) => item.name == a);
    String a1=User.encode(category);
    prefs.setString(key,a1);
   _isFavorited = false;

  }
   _toggleFavorite(String paira,String pairb) {
    setState(() {
     // bool flag=true;
      if (!_isFavorited) {
       // sharedPreferences?.save();
        save();
       // ?.setData()
      //  _favoriteCount += 1;
       // _saved.add(pair);
       _isFavorited = true;
     //   bool flag=false;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
            backgroundColor: Colors.white,
            content: Text(paira+' was added to watchlist', textAlign: TextAlign.start,
            style: TextStyle(
            color: Colors.black,
        ))));
       // widget.callback(_saved);

      } else {
      //  _favoriteCount -= 1;
        remove();
       _isFavorited=false;
        // if(flag==false){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.white,
                content: Text(paira+' was removed to watchlist', textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                    ))))
        ;}

       // _saved.remove(pair);
        //print("state:'_saved'");
    //  }

    }
    );
  }


  @override
  Widget build(BuildContext context) {
    //initState();
    // load();
     print(a.toString());
     String paira=a.toString();
     String pairb=b.toString();
     print(paira);
    //  load();
    // print(_isFavorited);
     return FutureBuilder(
         future: load(),
    builder: (ctx, snapshot) {

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
    )
    ,
    SizedBox(
    width: 18,
    // child: Container(
    //   child: Text('$_favoriteCount'),
    // ),
    )
    ],
    );
    }

     );

}}