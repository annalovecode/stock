import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock/pages/api_keys.dart';
import 'package:stock/pages/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/favoriteWidget.dart';
// import 'dart:html' as html;

class detail {
  String? country;
  String? currency;
  String? exchange;
  String? finnhubIndustry;
  String? ipo;
  String? logo;
  int? marketCapitalization;
  String? name;
  String? phone;
  double? shareOutstanding;
  String? ticker;
  String? weburl;

  detail({this.country,
    this.currency,
    this.exchange,
    this.finnhubIndustry,
    this.ipo,
    this.logo,
    this.marketCapitalization,
    this.name,
    this.phone,
    this.shareOutstanding,
    this.ticker,
    this.weburl});

  detail.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    currency = json['currency'];
    exchange = json['exchange'];
    finnhubIndustry = json['finnhubIndustry'];
    ipo = json['ipo'];
    logo = json['logo'];
    marketCapitalization = json['marketCapitalization'];
    name = json['name'];
    phone = json['phone'];
    shareOutstanding = json['shareOutstanding'];
    ticker = json['ticker'];
    weburl = json['weburl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['currency'] = this.currency;
    data['exchange'] = this.exchange;
    data['finnhubIndustry'] = this.finnhubIndustry;
    data['ipo'] = this.ipo;
    data['logo'] = this.logo;
    data['marketCapitalization'] = this.marketCapitalization;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['shareOutstanding'] = this.shareOutstanding;
    data['ticker'] = this.ticker;
    data['weburl'] = this.weburl;
    return data;
  }
}
class price {
  double? c;
  double? d;
  double? dp;
  double? h;
  double? l;
  double? o;
  double? pc;
  int? t;

  price({this.c, this.d, this.dp, this.h, this.l, this.o, this.pc, this.t});

  price.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    d = json['d'];
    dp = json['dp'];
    h = json['h'];
    l = json['l'];
    o = json['o'];
    pc = json['pc'];
    t = json['t'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['c'] = this.c;
    data['d'] = this.d;
    data['dp'] = this.dp;
    data['h'] = this.h;
    data['l'] = this.l;
    data['o'] = this.o;
    data['pc'] = this.pc;
    data['t'] = this.t;
    return data;
  }
}

class DetailsPage extends StatefulWidget {

  List<dynamic> a=[];
  List<dynamic> b=[];
 // Set<String> saved =Set<String>();
  DetailsPage(this.a, this.b);

  @override
  State<StatefulWidget> createState() => DetailPageState(a,b);
}

class DetailPageState extends State<DetailsPage> {

  //初始化内置属性,继承内置的父类，初始化函数必须这样的形式
  //detailPage({required Key key,required this.goods_list}):super(key:key)
  List a = [];
 // Set<String> saved =Set<String>();
  List b = [];

  DetailPageState(this.a, this.b);

  @override
  Widget build(BuildContext context) {
    // print(a);
    bool flag = true;
    double bchange ;
    String s = "+0";
    if (b.isEmpty) {
      return Scaffold(
          appBar: AppBar(
          title: const Text('Details'),
    centerTitle: true,
    backgroundColor: Colors.grey[800],
    actions: <Widget>[
    FavoriteWidget("","")
    ]
    ),
    body: Container(
          color: Colors.black,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            Text(
              "    Fail to fetch stock data!     ",
              style: TextStyle(fontSize: 32, color: Colors.white),
            )
          ])));

    }
    else {
        bchange = b.first['d'].toDouble();
        String s = "";
        if (bchange<0) {
          flag = false;
          s = bchange.toString();
        }
        else {
          flag = true;
          s = "+" + bchange.toString();
        }
      // }
      // else {
      //   flag = false;
      //   s = "+0";
      // }
      return Scaffold(
          appBar: AppBar(
              title: const Text('Details'),
              centerTitle: true,
              backgroundColor: Colors.grey[800],
              actions: <Widget>[
                FavoriteWidget(a.first['ticker'].toString() ,
                    a.first['name'].toString())

              ]
            // actions: <Widget>[ //导航栏右侧菜单
            //   IconButton(alreadySaved?Icons.star:Icons.star_border),
            // ],
          ),
          body:
          Container(
              color: Colors.black,
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                  children: [
                    Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.fromLTRB(5, 40, 5, 20),
                              child: Text(
                                  a.first['ticker'].toString(), softWrap: true,
                                  style: TextStyle(color: Colors.white,
                                    fontSize: 25,
                                  ))
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 40, 0, 20),
                            child: Text(
                                a.first['name'].toString(), softWrap: true,
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 25,
                                )),

                          )
                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child: Text(b.first['c'].toString(),
                                style: TextStyle(color: Colors.white,
                                  fontSize: 25,
                                )),
                          ),
                          Container(

                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
                            child: Text(s, softWrap: true,
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(
                                  color: flag ? Colors.green : Colors.red,
                                  fontSize: 25,
                                )),
                          )
                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child: Text('Stats',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 25,
                                )),
                          ),

                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child: Text('Open',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                            child: Text(b.first['o'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 30, 20),
                            child: Text('High',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
                            child: Text(b.first['h'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          )
                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 30, 20),
                            child: Text('Low',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                            child: Text(b.first['l'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 30, 20),
                            child: Text('Prev',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
                            child: Text(b.first['pc'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          )
                        ]), Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 5),
                            child: Text('About',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 25,
                                )),
                          ),

                        ]), Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 5),
                            child: Text('Start date',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 14,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child: Text(a.first['ipo'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 14,
                                )),
                          )
                        ]), Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 42, 5),
                            child: Text('Industry',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 14,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child: Text(a.first['finnhubIndustry'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 14,
                                )),
                          )
                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 42, 5),
                            child: Text('Website',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 14,
                                )),
                          ),
                          //hyplink here----x forget
                          Container(
                           padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child:InkWell(
                            child: Text(a.first['weburl'].toString(),
                                style: TextStyle(color: Colors.blue,
                                  fontSize: 14,
                                )),
    onTap: () => launchUrl(Uri.parse(a.first['weburl'].toString())))
    )
                            //html.window.open(a.first['weburl'].toString(),"");

                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 32, 5),
                            child: Text('Exchange',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 14,
                                )),
                          ),
                          //hyplink here----x forget
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child: Text(
                                a.first['exchange'].toString(), softWrap: true,
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 14,
                                )),
                          )
                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 20, 5),
                            child: Text('Market Cap',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 14,
                                )),
                          ),
                          //hyplink here----x forget
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 20, 5),
                            child: Text(
                                a.first['marketCapitalization'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 14,
                                )),
                          )
                        ])


                  ]

              )
          ));
    }
  }
}