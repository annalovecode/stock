import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock/pages/detail_page.dart';
import 'package:stock/pages/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/Stock.dart';

class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
  }

  class HomePageState extends State<HomePage> {


    final String formattedDate = DateFormat('MMMMd').format(DateTime.now());
    List<Stock> stockList = <Stock>[];
    String key = 'stringValue';

    /**
     * load the prev data
     */

    load() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String categoryStr = prefs.getString(key) ?? "";
      stockList = Stock.decode(categoryStr);
    }
    /**
     * get string of user
     */
    getStringValuesSF() async {
      load();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String stringValue = prefs.getString(key) ?? "";
     // print(stringValue);
      stockList = Stock.decode(stringValue);
      //print(stringValue);
      return stockList;
    }
    /**
     * remove a specific item
     */
   // String loadingTag="";
    remove(String a, String b) async {
    // load();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Stock item= Stock(a,b);
      stockList.removeWhere((item) => item.name == a);
      String a1=Stock.encode(stockList);
      if(a1.isEmpty) {
       //  loadingTag = "##loading##"; //表尾标记
         a1 = "";
         stockList.clear() ;
         print(stockList);
      }
      prefs.setString(key,a1);
    }

    @override
    Widget build(BuildContext context) {
     getStringValuesSF();
     return Scaffold(
          appBar: AppBar(
              title: const Text('Stock'),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 144, 34, 160),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                   showSearch(
                        context: context, delegate: ToDoSearchDelegate());
                      // This block runs when you have come back to the 1st Page from 2nd.
                      setState(() {
                        // Cal l setState to refresh the page.
                     //   searchOne=finalResult;
                      });
                    })
              ]
          ),
          body:
          _buildSuggestions()
      );
    }

    /**
     * build The Body of the Home page
     */
    Widget _buildSuggestions() {
      getStringValuesSF();
      return (
          Stack(children: <Widget>[
            Container(
                padding: EdgeInsets.all(5),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: Colors.black,
                child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text("STOCK WATCH ",
                            textAlign: TextAlign.left, // 文本对齐方式
                            style: TextStyle(color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),),
                          Text(formattedDate+" ",
                              textAlign: TextAlign.left, // 文本对齐方式
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold)),
                          Align(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    Text(""),
                                    Text(" Favorites", textAlign: TextAlign.left,
                                        // 文本对齐方式
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25)),
                                    Text(""),
                                    Divider(
                                      thickness: 2,
                                      color: Colors.white,
                                       indent: 10,
                                      endIndent: 10,
                                    )
                                  ])
                          ),
                          SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height - 310,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: _containListView()
                          )
                        ])

                ))
          ]));
    }

    /**
     * build the dynamic listview
     */
    Widget _containListView() {
      setState(() {
        // Call setState to refresh the page.
      });
      return StatefulBuilder(builder: (context, setNewState) {
      if(stockList.isEmpty){
        return ListView(children: <Widget>[
        ListTile(
        // 主标题
        title: Text('Empty',
            //文字左对齐
            textAlign: TextAlign.center,
            style: TextStyle(
              //数字必须是Double类型的
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                //  设置字体的颜色
                color: Colors.white,
            )
        ))]);
      }
      else{
      return
        ListView.separated(
            padding: const EdgeInsets.all(0),
            separatorBuilder: (context, index) {
              return Divider( thickness: 2,
                color: Colors.white,
                indent: 10,
                endIndent: 10,);
            },
            itemCount: stockList.length,
            itemBuilder: (context, index) {
                return Dismissible(

                confirmDismiss: (direction) {
      return showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey[900],
      title: Text('Delete Confirmation',style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          )),
      content: Text('Are you sure you want to delete this item ?',style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        )),
      actions: <Widget>[
      TextButton(
      onPressed: () {
      // Navigator.pop(context, false);
      Navigator.of(
      context,
      // rootNavigator: true,
      ).pop(true);
      },
      child: Text('Delete',style: TextStyle(
        color: Colors.white,
        fontSize: 18,
       )),
      ),
      TextButton(
      onPressed: () {
      // Navigator.pop(context, true);
      Navigator.of(
      context,
      // rootNavigator: true,
      ).pop(false);
      },  child: Text('   Cancel',style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        )),
      ),
      ],
      );
      },
      );
                },
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                    key: ObjectKey(stockList[index]),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                           // Text('Move to favorites', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),

                    onDismissed: (direction) {
                      //TODO DELETE
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            '${stockList[index].name} was removed from the watchlist ',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                      setState(() {
                        remove(stockList[index].name,stockList[index].CompanyName);
                      });

                    },
                     child: ListTile(
                  textColor: Colors.white,
                  title: Text("${stockList[index].name}"),
                  subtitle: Text("${stockList[index].CompanyName}"),
                       onTap: () async {
                         List<dynamic> a =await getDetail(symbol: stockList[index].name);
                         // print(a.toString());
                         //  List lista = await a as List ;
                         //  print(a.toString());
                         Future<List<dynamic>> b= getPrice(symbol: stockList[index].name);
                         List<dynamic> b1 =await b;
                         Navigator.push(
                             context,
                             MaterialPageRoute(
// //            builder: (context) => new NewsWebPage(h5_url,'新闻详情')));
                                 builder: (context) => DetailsPage(a,b1)));
                       },
                ));
              }
            );}
    });}



  }
/**
 * listen to changes of SharedPreference
 */
class CounterProvider with ChangeNotifier {
  List<Stock> stock = <Stock>[];

  List<Stock> get value => stock;
  void change()async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String categoryStr = prefs.getString('stringValue') ?? "";
      stock = Stock.decode(categoryStr);
      notifyListeners();

  }

}

