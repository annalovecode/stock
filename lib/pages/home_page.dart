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
      final String categoryStr = prefs.getString(key)??"";
      user = User.decode(categoryStr);
    }
   getStringValuesSF() async {
      load();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String stringValue = prefs.getString(key)?? "";
      print(stringValue);
      user= User.decode(stringValue);
      return user;
    }
  @override
   Widget build(BuildContext context) {
    getStringValuesSF();

   return Scaffold(
       appBar: AppBar(
         title: const Text('Stock'),
           centerTitle: true,
         backgroundColor: Color.fromARGB(255,144, 34, 160),
           actions: <Widget>[
       IconButton(
       icon: Icon(Icons.search),

       onPressed: () async {
         showSearch(context: context, delegate: ToDoSearchDelegate());
       },
       ),]

       ),
   body:
           _buildSuggestions()
       );}



  Widget _buildSuggestions() {
 //   TestList(quiz:user);
    return (
        Stack(children: <Widget>[
        Container(
        padding: EdgeInsets.all(5),
    width: MediaQuery.of(context).size.width,
    color: Colors.black,
    child: SafeArea(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.end,
    //   textDirection: TextDirection.RTL,
    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //verticalDirection: VerticalDirection.down,
    children:<Widget> [
              Text("STOCK WATCH",
                textAlign: TextAlign.left, // 文本对齐方式
                style: TextStyle(color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
              Text(formattedDate,
                  textAlign: TextAlign.left, // 文本对齐方式
                  style: TextStyle(
                      color:Colors.white,
                      fontSize:30,
                      fontWeight:FontWeight.bold)),
    Align(
        //crossAxisAlignment: CrossAxisAlignment.center,
      child:Column(crossAxisAlignment: CrossAxisAlignment.start, children:<Widget>
      [Text("Favorites", textAlign: TextAlign.left, // 文本对齐方式

          style: TextStyle(
              color:Colors.white,
              fontSize:30)),
      Divider(
        height: 40,
        color: Colors.grey[100],
      //  indent: 120,
      )])
    ),

    SizedBox(
    height: MediaQuery.of(context).size.height-310,
        width: MediaQuery.of(context).size.width,

    child: _containListView()
    )
             ])

        ))]));
  }
  Widget _containListView(){

      return
        ListView.separated(
          separatorBuilder: (context, index) {
        return Divider(color: Colors.grey[400]);
      },

        physics: NeverScrollableScrollPhysics(),
        itemCount: user.length,

    itemBuilder: (context, index) {
            if(user.length==0){
              return ListTile(
                  textColor: Colors.white,
                  title: Text("EMPTY"));
            }
            else{
    return
      ListTile(
       textColor: Colors.white,

    title: Text("${user[index].name}"),
        subtitle: Text("${user[index].age}"),
    );
    }});

  }
  }





