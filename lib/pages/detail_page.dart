import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock/pages/api_keys.dart';
import 'package:stock/pages/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
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

class DetailsPage extends StatefulWidget {

  List<dynamic> a=[];
  List<dynamic> b=[];
  DetailsPage(this.a, this.b);

  @override
  State<StatefulWidget> createState() => DetailPageState(a,b);
}

class DetailPageState extends State<DetailsPage>{

  //初始化内置属性,继承内置的父类，初始化函数必须这样的形式
  //detailPage({required Key key,required this.goods_list}):super(key:key)
  List a=[] ;
  List b=[] ;

  DetailPageState(this. a, this.b);
  @override
  Widget build(BuildContext context) {
   // print(a);
    bool flag=true;
    double bchange=0;
    String s="+0";
    if(b.first['d']!=null) {
      bchange = b.first['d'];
      String s = "";
      if (bchange < 0) {
        flag = false;
        s = bchange.toString();
      }
      else {
        flag = true;
        s = "+" + bchange.toString();
      }
    }
    else {
        flag=false;
        s="+0";
    }
    return Scaffold(
       appBar: AppBar(
            title: const Text('Details'),
            centerTitle: true,
            backgroundColor: Colors.grey[800]),
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
                child:Text(a.first['ticker'].toString(),
                    style: TextStyle(color: Colors.white,
                        fontSize: 25,
                        ))
                      ),
        Container(
            padding: const EdgeInsets.fromLTRB(5, 40, 0, 20),
                child:Text(a.first['name'].toString(),
                 // style: flag  ? Colors.redAccent : Colors.green
                    style: TextStyle(color: Colors.grey,
                        fontSize: 25,
                        )),

        )]),
    Row(
    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                        child:Text(b.first['c'].toString(),
                            style: TextStyle(color: Colors.white,
                                fontSize: 25,
                                )),
                      ),
    Container(

     padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
        child:Text(s,
            // style: flag  ? Colors.redAccent : Colors.green
            style: TextStyle(color: flag?Colors.red:Colors.green,
                fontSize: 25,
                )),
    )
    ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child:Text('Stats',
                                style: TextStyle(color: Colors.white,
                                    fontSize: 25,
                                   )),
                          ),

                        ]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child:Text('Open',
                                style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                    )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                            child:Text(b.first['o'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                    fontSize: 18,
                                    )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 30, 20),
                            child:Text('High',
                                style: TextStyle(color: Colors.white,
                                    fontSize: 20,
                                   )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
                            child:Text(b.first['h'].toString(),
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
                            child:Text('Low',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                            child:Text(b.first['l'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(40, 0, 30, 20),
                            child:Text('Prev',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 20),
                            child:Text(b.first['pc'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          )
                        ]),Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child:Text('About',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 25,
                                )),
                          ),

                        ]), Row(
    children: [
    Container(
    padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
    child:Text('Start date',
    style: TextStyle(color: Colors.white,
    fontSize: 20,
    )),
    ),
    Container(
    padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
    child:Text(a.first['ipo'].toString(),
    // style: flag  ? Colors.redAccent : Colors.green
    style: TextStyle(color: Colors.grey,
    fontSize: 18,
    )),
    )]),Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child:Text('Industry',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                            child:Text(a.first['finnhubIndustry'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          )]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child:Text('Website',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          //hyplink here----x forget
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                            child:Text(a.first['weburl'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                              //html.window.open(a.first['weburl'].toString(),"");
                          )]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child:Text('Exchange',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          //hyplink here----x forget
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                            child:Text(a.first['exchange'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          )]),
                    Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(5, 0, 30, 20),
                            child:Text('Market Cap',
                                style: TextStyle(color: Colors.white,
                                  fontSize: 20,
                                )),
                          ),
                          //hyplink here----x forget
                          Container(
                            padding: const EdgeInsets.fromLTRB(30, 0, 20, 20),
                            child:Text(a.first['marketCapitalization'].toString(),
                                // style: flag  ? Colors.redAccent : Colors.green
                                style: TextStyle(color: Colors.grey,
                                  fontSize: 18,
                                )),
                          )])


                  ]

        )
              ));



             // ),


        //    );
      // Text(a.first['ticker'].toString())
      // )
    //]
    //)

   // );
    //         actions: <Widget>[
    //           // IconButton(
    //           //  padding: const EdgeInsets.all(0),
    //           //  alignment: Alignment.centerRight, onPressed: () {  }, icon: null,
    //   //          icon: ( formattedDate
    //   //     ? const Icon(Icons.star)
    //   //     : const Icon(Icons.star_border)),
    //   // color: Colors.white,
    //   // onPressed: (),
    //   // onPressed: _toggleFavorite,
    // // )
    //           ],
  //  );
     //   column(
        //     //future: getDetail(symbol: symbol),
        // builder: (BuildContext context, AsyncSnapshot snapshot) {
        // // 请求已结束
        // if (snapshot.connectionState == ConnectionState.done) {
        // if (snapshot.hasError) {
        // // 请求失败，显示错误
        // return Text("Error: ${snapshot.error}");
        // } else {
        // // 请求成功，显示数据
        // return Text("Contents: ${snapshot.data}");
        // }
        // } else {
        // // 请求未结束，显示loading
        // return CircularProgressIndicator();
        // }
        // )

   // );

  }

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   return ThemeData(
  //     textSelectionTheme: TextSelectionThemeData(
  //       cursorColor: Colors.purple, //thereby
  //     ),
  //     textTheme: TextTheme(
  //       // Use this to change the query's text style
  //       headline6: TextStyle(fontSize: 24.0, color: Colors.white),
  //     ),
  //     appBarTheme: const AppBarTheme(
  //       backgroundColor: Colors.black,
  //       iconTheme: const IconThemeData(
  //         color: Colors.grey,
  //         size: 30.0,
  //       ),
  //     ),
  //     //change icon color to grey  not working-----put inside appBarTheme
  //     //change the flash light clor
  //     // iconTheme: const IconThemeData(
  //     //   color: Colors.blue,
  //     //   size: 35.0,
  //     // ),
  //     inputDecorationTheme: InputDecorationTheme(
  //       border: InputBorder.none,
  //       // Use this change the placeholder's text style
  //       hintStyle: TextStyle(fontSize: 24.0),
  //     ),
  //   );
  // }
  //
  // @override
  // //change the function of adding to favorite list
  // List<Widget> buildActions(BuildContext context) =>
  //     [
  //
  //       IconButton(
  //         padding: const EdgeInsets.all(0),
  //         alignment: Alignment.centerRight,
  //         icon: (_isFavorited
  //             ? const Icon(Icons.star)
  //             : const Icon(Icons.star_border)),
  //         color: Colors.white,
  //         onPressed: _toggleFavorite,
  //       ),
  //       // IconButton(
  //       //   icon: Icon(Icons.add),
  //       //   onPressed: () {
  //       //     if (query.isEmpty) {
  //       //      // Navigator.pop(context);
  //       //     } else {
  //       //       query = '';
  //       //    //   showSuggestions(context);
  //       //     }
  //       //   },
  //       )
  //     ];
  //
  //
  // @override
  // Widget buildLeading(BuildContext context) {
  //   return
  //
  //     IconButton(
  //     icon: const Icon(Icons.arrow_back),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  // }
  //
  // @override
  // Widget buildResults(BuildContext context) {
  //   return Container(
  //     color: Colors.black,
  //     child: FutureBuilder<List<dynamic>>(
  //       future: getDetail(symbol: query),
  //       builder: (context, snapshot) {
  //         var data = snapshot.data;
  //         if (snapshot.hasData) {
  //           // if (snapshot.connectionState == ConnectionState.done) {
  //           return ListView.builder(
  //             itemBuilder: (context, index) {
  //               final suggestion = data![index];
  //               return ListTile(
  //                 title: Text(suggestion, style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold)),
  //                 onTap: () {
  //                   // query = suggestion;
  //                   // showResults(context);
  //                 },
  //               );
  //             },
  //             itemCount: snapshot.data?.length,
  //           );
  //           //    }
  //         }
  //         else if (snapshot.hasError) {
  //           return Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: const <Widget>[
  //               Text(
  //                 "No Results Found.",
  //                 style: TextStyle(fontSize: 28, color: Colors.white),
  //
  //               ),
  //             ],
  //           );
  //         }
  //         else {
  //           return const Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }
  //
  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   return Container(color: Colors.black, child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: const <Widget>[
  //         Text(
  //           "    No Suggestions Found!     ",
  //           style: TextStyle(fontSize: 32, color: Colors.white),
  //         )
  //       ])
  //   );
  // }





}