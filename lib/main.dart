import 'package:flutter/material.dart';
import 'package:stock/pages/home_page.dart';
import 'package:stock/pages/search_page.dart';
// void main() {
//   runApp(const MyApp());
// }
Future<void> main() async {

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'stock',
        theme: ThemeData(
          dialogBackgroundColor: Colors.black,
          primarySwatch: Colors.purple,
          primaryColor: Colors.black,
          textTheme: TextTheme(
            // Use this to change the query's text style
            headline6: TextStyle(fontSize: 25.0, color: Colors.white),
          ),

        ),
       // debugShowCheckedModeBanner: false,
        home:
        HomePage()
    );
  }
}
