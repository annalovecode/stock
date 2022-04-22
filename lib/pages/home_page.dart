import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stock/pages/search_page.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMMMd').format(DateTime.now());
   return Scaffold(

       appBar: AppBar(
         title: const Text('Stock'),

           centerTitle: true,
         backgroundColor: Color.fromARGB(255,144, 34, 160),
           actions: <Widget>[
       IconButton(
       icon: Icon(Icons.search),

       onPressed: () async {
         final toDo = await showSearch<ToDo>(
           context: context,
           delegate: ToDoSearchDelegate(),
         );
       },
       ),]

       ),

     body:Stack(children: <Widget>[
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
                   Text("favorite", textAlign: TextAlign.left, // 文本对齐方式
                       style: TextStyle(
                           color:Colors.white,
                           fontSize:30,
                           fontWeight:FontWeight.bold)),

    //                Padding(
    //                  padding: const EdgeInsets.only(top: 8.0),
    //                  child: SizedBox(
    // height: 50,
    // child: TextField(
    // decoration: InputDecoration(
    // hintStyle: TextStyle(color: Colors.grey[500]),
    // hintText: "Search",
    // prefix: Icon(Icons.search),
    // fillColor: Colors.grey[800],
    // filled: true,
    // border: OutlineInputBorder(
    // borderSide: BorderSide(
    //  width: 0, style: BorderStyle.none
    // ),
    //   borderRadius: BorderRadius.all(Radius.circular(16))
    // )
    // ),
    // )
    // )
                 //  )


           ]),
         )
       )
     ])
   );
  }

}
