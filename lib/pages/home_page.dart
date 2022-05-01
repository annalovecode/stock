import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock/pages/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock/widgets/TestList.dart';

import '../widgets/addToFavorite.dart';

class HomePage extends StatefulWidget{

  @override
  RandomWordsState createState() => new RandomWordsState();
  }
  class RandomWordsState extends State<HomePage> {

    // final List<String> _suggestions = <String>[];
    //static const loadingTag = "##empty##"; //表尾标记
    //final Set<String> _saved = {"1"};
    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    final String formattedDate = DateFormat('MMMMd').format(DateTime.now());
    List<User> user = <User>[];
    String key = 'stringValue';

    load() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String categoryStr = prefs.getString(key) ?? "";
      user = User.decode(categoryStr);
    }

    getStringValuesSF() async {
      load();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String stringValue = prefs.getString(key) ?? "";
      print(stringValue);
      user = User.decode(stringValue);
      return user;
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
                  },
                ),
              ]

          ),
          body:
          _buildSuggestions()
      );
    }


    Widget _buildSuggestions() {
      //   TestList(quiz:user);
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
                        //   textDirection: TextDirection.RTL,
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          Text("STOCK WATCH",
                            textAlign: TextAlign.left, // 文本对齐方式
                            style: TextStyle(color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),),
                          Text(formattedDate,
                              textAlign: TextAlign.left, // 文本对齐方式
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                          Align(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>
                                  [
                                    Text("Favorites", textAlign: TextAlign.left,
                                        // 文本对齐方式

                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30)),
                                    Divider(
                                      height: 20,
                                      color: Colors.grey[100],
                                      //  indent: 120,
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

    Future<bool?> _showConfirmationDialog(BuildContext context, String action) {
      print(context);
      return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Delete Confirmation'),
            content: const Text('Are you sure you want to delete this item?'),
            actions: <Widget>[
              FlatButton(
                child: const Text('Yes'),
                onPressed: () {
                  Navigator.pop(context, true); // showDialog() returns true
                },
              ),
              FlatButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context, false); // showDialog() returns false
                },
              ),
            ],
          );
        },
      );
    }

    Widget _containListView() {
      String whatHappened;
      return
        ListView.separated(
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey[400]);
            },
            physics: NeverScrollableScrollPhysics(),
            itemCount: user.length,
            itemBuilder: (context, index) {
              if (user.length == 0) {
                return ListTile(
                    textColor: Colors.white,
                    title: Text("EMPTY"));
              }
              else {
                return Dismissible(
                confirmDismiss: (direction) {
      return showDialog(
      context: context,
      builder: (context) {
      return CupertinoAlertDialog(
      title: Text('Delete'),
      content: Text('Delete'),
      actions: <Widget>[
      FlatButton(
      onPressed: () {
      // Navigator.pop(context, false);
      Navigator.of(
      context,
      // rootNavigator: true,
      ).pop(false);
      },
      child: Text('No'),
      ),
      FlatButton(
      onPressed: () {
      // Navigator.pop(context, true);
      Navigator.of(
      context,
      // rootNavigator: true,
      ).pop(true);
      },  child: Text('Yes'),
      ),
      ],
      );
      },
      );
                },
                  // Each Dismissible must contain a Key. Keys allow Flutter to
                  // uniquely identify widgets.
                    key: ObjectKey(user[index]),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      //TODO DELETE
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Theme.of(context).accentColor,
                          content: Text(
                            'test',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  // Provide a function that tells the app
                    // what to do after an item has been swiped away.
                   // onDismissed: (direction) {
                    //   confirmDismiss:
                    //       (DismissDirection dismissDirection) async {
                    //     print('aadd');
                    //     switch (dismissDirection) {
                    //       case DismissDirection.endToStart:
                    //         whatHappened = 'ARCHIVED';
                    //         print('aaa');
                    //         return await _showConfirmationDialog(
                    //             context, 'Archive') == true;
                    //       case DismissDirection.startToEnd:
                    //         whatHappened = 'DELETED';
                    //         print('aaa2');
                    //         return await _showConfirmationDialog(
                    //             context, 'Delete') == true;
                    //       case DismissDirection.horizontal:
                    //       case DismissDirection.vertical:
                    //       case DismissDirection.up:
                    //       case DismissDirection.down:
                    //       print('aaa3');
                    //         assert(false);
                    //     }
                    //     return false;
                    //   };
                     child: ListTile(
                  textColor: Colors.white,

                  title: Text("${user[index].name}"),
                  subtitle: Text("${user[index].age}"),
                ));
              }
            });
    }


  // showDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('Delete Confirmation'),
  //       content: const Text('Are you sure you want to delete this item?'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context,'Delete');
  //             ScaffoldMessenger.of(context)
  //                 .showSnackBar(SnackBar(content: Text('${user[index].name} dismissed')));
  //           },
  //           child: const Text('Delete'),
  //         ),
  //         TextButton(
  //           onPressed: () =>Navigator.pop(context, 'Cancel'),
  //           child: const Text('Cancel'),
  //
  //         ),
  //
  //       ],

  //    ),
  // Remove the item from the data source.
  // setState(() {
  //user.removeAt(index);

  //  }
  //      );
  //  _alertButton();
  // Then show a snackbar.

  // ScaffoldMessenger.of(context)
  //     .showSnackBar(SnackBar(content: Text('${user[index].name} dismissed')));
  //   },

  //   child:ListTile(
  //    textColor: Colors.white,
  //
  // title: Text("${user[index].name}"),
  //     subtitle: Text("${user[index].age}"),
  // // ));
  // }});

  //
  // }
  // }


  }
