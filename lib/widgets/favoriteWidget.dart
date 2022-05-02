
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addToFavorite.dart';
class FavoriteWidget extends StatefulWidget {
  String a="";
  String b="";

  //Set<String> _saved = Set<String>();
 // Function callback;
  FavoriteWidget(this.a,this.b);
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  String a="";
  String b="";

  //_FavoriteWidgetState(this. a,this.b,this.);
  List<User> category = <User>[];
  String key = 'stringValue';
  bool _isFavorited=true;
  late Future future;

  @override
  void initState() {
    super.initState();
    future = load(); //初始化卡片信息
  }

  //刷新数据
  Future refresh() async {
    setState(() {
      future = load();
    });
  }
 load() async {
  // bool _isFavorited=true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String categoryStr = prefs.getString(key)??"";
    category = User.decode(categoryStr);
    User userAdd= User(a,b);
    _isFavorited=category.map((item) => item.name).contains(userAdd.name);
     print(_isFavorited);

  }


save() async {
    _isFavorited = true;
    final prefs = await SharedPreferences.getInstance();
    User userAdd= User(a,b);
    category.add(userAdd);
    String a1=User.encode(category);
    prefs.setString(key,a1);
    print(a1);
  //  _isFavorited = true;
  }

  remove() async {
    _isFavorited = false;
    final prefs = await SharedPreferences.getInstance();
    User item= User(a,b);
    category.removeWhere((item) => item.name == a);
    String a1=User.encode(category);
    prefs.setString(key,a1);

  }
   _toggleFavorite(String paira,String pairb,bool _isFavorited) {
    setState(() {
      bool flag=true;
      if (!_isFavorited) {
       // sharedPreferences?.save();
        save();
       // ?.setData()
      //  _favoriteCount += 1;
       // _saved.add(pair);
        _isFavorited = true;
        bool flag=false;
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
        if(flag==false){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: Colors.white,
                content: Text(paira+' was removed to watchlist', textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Colors.black,
                    ))));flag=true;}

       // _saved.remove(pair);
        //print("state:'_saved'");
      }

    }
    );
  }


  @override
  Widget build(BuildContext context) {
     return buildFutureBuilder();
  }
  FutureBuilder buildFutureBuilder() {
    return new FutureBuilder(
      builder: (context, AsyncSnapshot async) {
        if (async.connectionState == ConnectionState.active ||
            async.connectionState == ConnectionState.waiting) {
          return new Center(
            child: new CircularProgressIndicator(),
          );
        }
        if (async.connectionState == ConnectionState.done) {
          if (async.hasError) {
            return new Center(
              child: new Text("ERROR"),
            );
          } else if (async.hasData) {
            CardInfoEntity _cardInfo = async.data;
            return new RefreshIndicator(
                child: buildListView(context, _cardInfo), onRefresh: refresh);
          }
        }
      },
      future: future,
    );

  }
  // load();
  String paira=a.toString();
  String pairb=b.toString();
  //  load();
  //   print(_isFavorited);
  return Row(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
  Container(
  padding: EdgeInsets.all(0),
  child: IconButton(
  icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
  color: _isFavorited ? Colors.white : null,
  onPressed: (){ _toggleFavorite(paira,pairb,_isFavorited);}
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