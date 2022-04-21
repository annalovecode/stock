import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
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

class ToDoSearchDelegate extends SearchDelegate<ToDo> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
       Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Result>>(
      future: _search(query: query),
      builder: (context, snapshot) {
        var data = snapshot.data;
        if(snapshot.hasData) {
          // if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${data?[index].symbol}|${data?[index].description} '),
                  // onTap: () {
                  //   close(context, data![index]);
                  // },
                );
              },
              itemCount: snapshot.data?.length,
            );
      //    }
        }
        else if (snapshot.data?.length==0) {
          return Column(
            children: <Widget>[
              Text(
                "No Results Found.",
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
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

  Future<List<Result>> _search({String?query}) async {
    List<Result> res=[];
    if(query==null) return res;

    const authority = 'finnhub.io';
    const path = '/api/v1/search';
    final queryParameters = <String, String>{'q': query};
    final uri = Uri.https(authority, path, queryParameters);
   // print(uri);
    String token = 'c9f6fdqad3ianhjk2hpg';
    final result = await http.get(uri, headers: {
      'Authorization': 'Bearer ' + token,
    });
    //print('Token : ${token}');
    print(result);
    try{
      if(result.statusCode==200){
        final list = json.decode(result.body) as List;
        res = list.map((e) => Result.fromJson(e)).toList();

      }
      else{
        print('api err');
      }
    } on Exception catch(e){
      print('err:$e');
    }

    return res;
  }
}