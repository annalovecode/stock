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
   Stack(children: <Widget>[
   Container(
   padding: EdgeInsets.all(10),
       width: MediaQuery.of(context).size.width,
       color: Colors.black,
       child: SafeArea(
       child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.end,
       //   textDirection: TextDirection.RTL,
       //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
       verticalDirection: VerticalDirection.down,
       children:<Widget> [
           _buildSuggestions()

       ]),
       )
   )
   ])
   );

  }


  Widget _buildSuggestions() {
 //   TestList(quiz:user);
    return (

              Text("STOCK WATCH",
                textAlign: TextAlign.left, // 文本对齐方式
                style: TextStyle(color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),),
              Text(formattedDate,
                  textAlign: TextAlign.left, // 文本对齐方式
                  style: TextStyle(
                      color:Colors.black,
                      fontSize:30,
                      fontWeight:FontWeight.bold)),
              Text("favorite", textAlign: TextAlign.left, // 文本对齐方式
                  style: TextStyle(
                      color:Colors.black,
                      fontSize:30,
                      fontWeight:FontWeight.bold)),
              Text(user.length.toString())
    // ListView.builder(
              //     itemCount: user.length,  //- 要生成的条数
              //     itemBuilder: (context, index){
              //       return ListTile(
              //           title: Text('${user[index].name}')
              //       );
              //     }
              // )
   // TestList(quiz:user)

  //  new ListView(children: divided)]
        );
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
    return
      ListTile(

    title: Text("${user[index].name} | ${user[index].age}"),
    );
    });

  }
  }





