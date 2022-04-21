// import 'package:flutter/material.dart';
//
// class searchPage extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//       onPressed: () {
//         query = "";
//         showSuggestions(context);
//       },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//
//     return IconButton(
//         icon: AnimatedIcon(
//             icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
//         onPressed: () => close(context, ""));
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//       width: 100.0,
//       height: 100.0,
//       child: Card(
//         child: Center(
//           child: Text(query),
//
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestionList = query.isEmpty
//         ? recentSuggest
//         : searchList.where((input) => input.startsWith(query)).toList();
//     return ListView.builder(
//         itemCount: suggestionList.length,
//         itemBuilder: (context, index) => ListTile(
//           title: RichText(
//               text: TextSpan(
//                   text: suggestionList[index].substring(0, query.length),
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   children: [
//                     TextSpan(
//                         text: suggestionList[index].substring(query.length),
//                         style: TextStyle(color: Colors.grey))
//                   ])),
//         ));
//   }
// }
//
// // searchList = ["https://finnhub.io/api/v1/search?q=company_name&token=c9f6fdqad3ianhjk2hpg"
//
// const recentSuggest = [
//   "No suggestion found!"
// ];
//
