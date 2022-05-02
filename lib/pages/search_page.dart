import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stock/pages/detail_page.dart';
import 'api_keys.dart';
import 'home_page.dart';
class ToDo {
  int? count;
  List<Result>? result;

  ToDo({this.count, this.result});

  ToDo.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? description;
  String? displaySymbol;
  String? symbol;
  String? type;
  List<String>? primary;

  Result(
      {this.description,
        this.displaySymbol,
        this.symbol,
        this.type,
        this.primary});

  Result.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    displaySymbol = json['displaySymbol'];
    symbol = json['symbol'];
    type = json['type'];
    primary = json['primary'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['displaySymbol'] = displaySymbol;
    data['symbol'] = symbol;
    data['type'] = type;
    data['primary'] = primary;
    return data;
  }
}


class ToDoSearchDelegate extends SearchDelegate<String> {



  ToDoSearchDelegate();
  CounterProvider _counterProvider = new CounterProvider();

  /**
   * init state
   */
  void initState() {

    _counterProvider.addListener(() {
      //数值改变的监听
      print('YM------>${ _counterProvider.stock}');
    });
  }
  void dispose() {

    _counterProvider.dispose();//移除监听
   print('YM------>${ _counterProvider.stock}');
  }

  /**
   * themeData change
   */
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.purple, //thereby
      ),
      textTheme: TextTheme(
        // Use this to change the query's text style
        headline6: TextStyle(fontSize: 24.0, color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.grey,
          size: 30.0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        // Use this change the placeholder's text style
        hintStyle: TextStyle(fontSize: 24.0),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) =>
      [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
           query = '';
         //  buildSuggestions(context);
           showSuggestions(context);
          },

        )
      ];


  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
        onPressed: () {
          _counterProvider.change();
        Navigator.pop(context);

        }


    );
  }
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<List<String>>(
        future: _search(query: query),
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  var suggestion = data![index];
                  return ListTile(
                    title: Text(suggestion, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                    onTap: () async {
                      suggestion=suggestion.trim();
                      List<String> s1 = suggestion.split('|');
                      String symbol = s1.first;

                      List<dynamic> a =await getDetail(symbol: symbol);
                      Future<List<dynamic>> b= getPrice(symbol: symbol);
                      List<dynamic> b1 =await b;

                       Navigator.push(
                           context,
                           MaterialPageRoute(
                               builder: (context) => DetailsPage(a,b1)));

                    },

                  );
                },
                itemCount: snapshot.data?.length);


          }
          else if (snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text(
                  "No Results Found.",
                  style: TextStyle(fontSize: 28, color: Colors.white),

                ),
              ],
            );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(color: Colors.black, child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const <Widget>[
          Text(
            "    No Suggestions Found!     ",
            style: TextStyle(fontSize: 32, color: Colors.white),
          )
        ])
    );
  }

}
/**
 * get data of the stock from API
 */
Future<List<String>> _search({String?query}) async {
    List<String> res=[];
    if(query==null) return res;
    const authority = 'finnhub.io';
    const path = '/api/v1/search';
    final queryParameters ={
    'q': query,
  'token': kFinnhubKey,
};
    final uri = Uri.https(authority, path, queryParameters);
    final result= await http.get(uri);
    try{
      if(result.statusCode==200){
        final body = json.decode(result.body);
        final k=body['result'];
        return res= k.map<String>((json) {
          final symbol = json['symbol'];
          final desc = json['description'];
          return '$symbol | $desc';
        }).toList();

      }
      else{
        print('api err');
      }
    } on Exception catch(e){
      print('err:$e');
    }

    return res;
  }

/**
 * get Detail of the stock
 */
Future<List<dynamic>> getDetail({required String symbol}) async {
  List<dynamic> res = [];
  const authority = 'finnhub.io';
  const path = '/api/v1/stock/profile2';
  final queryParameters = {
    'symbol': symbol.trim(),
    'token': kFinnhubKey,
  };
  final uri = Uri.https(authority, path, queryParameters);
  final result = await http.get(uri);
  try {
    if (result.statusCode == 200) {
      final body = json.decode(result.body);
      res= [body];
    }
    else {
      print('api err');

    }
  } on Exception catch (e) {
    print('err:$e');
  }

  return res;
}

/**
 * get current price change of a stock
 */
Future<List<dynamic>> getPrice({required String symbol}) async {
  List<dynamic> res = [];
  const authority = 'finnhub.io';
  const path = '/api/v1/quote';
  final queryParameters = {
    'symbol': symbol.trim(),
    'token': kFinnhubKey,
  };
  final uri = Uri.https(authority, path, queryParameters);

  final result = await http.get(uri);
  try {
    if (result.statusCode == 200) {
      final body = json.decode(result.body);
      res= [body];

    }
    else {
      print('api err');

      res=[];
      if(res.isEmpty){

      }

    }
  } on Exception catch (e) {
    print('err:$e');
  }

  return res;
}



