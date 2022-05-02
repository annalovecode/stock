import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Stock.dart';

class FavoriteWidget extends StatefulWidget {
  String a = "";
  String b = "";

  //Set<String> _saved = Set<String>();
  // Function callback;
  FavoriteWidget(this.a, this.b);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(this.a, this.b);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  String a = "";
  String b = "";

  _FavoriteWidgetState(this.a, this.b);

  List<Stock> category = <Stock>[];
  String key = 'stringValue';
  bool _isFavorited = false;
  // CounterProvider _counterProvider = new CounterProvider();
  // //CounterProvider _counterProvider = new CounterProvider();
  // void initState() {
  //
  //   _counterProvider.addListener(() {
  //     //数值改变的监听
  //     print('YM------>新数值:${ _counterProvider.user}');
  //   });
  // }
  // void dispose() {
  //
  //   _counterProvider.dispose();//移除监听
  //   print('YM------>新数值:${ _counterProvider.user}');
  // }
  /**
   * load data from sharedPre
   */
  load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String categoryStr = prefs.getString(key) ?? "";
    category = Stock.decode(categoryStr);
    Stock userAdd = Stock(a, b);
    _isFavorited = category.map((item) => item.name).contains(userAdd.name);

  }

  /**
   * save data to sharedPre
   */
  save() async {
//    _isFavorited = true;
    load();
    final prefs = await SharedPreferences.getInstance();
    Stock userAdd = Stock(a, b);
    category.add(userAdd);
    String a1 = Stock.encode(category);
    prefs.setString(key, a1);
    //  print(a1);
    _isFavorited = true;
  }
  /**
   * remove data from sharedPre
   */
  remove() async {
    load();
    final prefs = await SharedPreferences.getInstance();
    Stock item = Stock(a, b);
    category.removeWhere((item) => item.name == a);
    String a1 = Stock.encode(category);
    prefs.setString(key, a1);
    _isFavorited = false;
  }
  /**
   * handle the state of the favorite list
   */
  _toggleFavorite(String paira, String pairb) {
    setState(() {
      // bool flag=true;
      if (!_isFavorited) {
        // sharedPreferences?.save();
        save();

        _isFavorited = true;
        //   bool flag=false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: Text(paira + ' was added to watchlist',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                ))));
        // widget.callback(_saved);

      } else {
        //  _favoriteCount -= 1;
        remove();
        _isFavorited = false;
        // if(flag==false){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.white,
            content: Text(paira + ' was removed to watchlist',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black,
                ))));
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    String paira = a.toString();
    String pairb = b.toString();

    return FutureBuilder(
        future: load(),
        builder: (ctx, snapshot) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                child: IconButton(
                    icon: (_isFavorited
                        ? Icon(Icons.star)
                        : Icon(Icons.star_border)),
                    color: _isFavorited ? Colors.white : null,
                    onPressed: () {
                      _toggleFavorite(paira, pairb);
                    }),
              ),
              SizedBox(
                width: 18,
              )
            ],
          );
        });
  }
}



