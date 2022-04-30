import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'addToFavorite.dart';

class TestList extends StatefulWidget {

  List<User> quiz;

  TestList({required this.quiz});

  @override
  _TestListState createState() => new _TestListState(quiz);

}

class _TestListState extends State<TestList> {

  bool loading = true;
  List<Widget> listArray = [];
  _TestListState(List value){

      // loop through the json object
      for (var i = 0; i < value.length; i++) {

        // add the ListTile to an array
        listArray.add(ListTile(title: Text(value[i].name | value[i].age)));
       print('1'+listArray[i].toString());

        }


      }

  @override
  Widget build(BuildContext context) {

    //List<Widget> listArray = [];

    return Container(
        child: ListView(
            children: loading?[]:listArray     // when the state of loading changes from true to false, it'll force this widget to reload
        ));

  }

}