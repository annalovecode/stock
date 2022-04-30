import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class User {
  String name="";
  String age="";

  User(this.name,this.age);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age
  };

  static Map<String, dynamic> toMap(User user) => {
  'name': user.name,
  'age': user.age

  };

  static String encode(List<User> user) => json.encode(
  user
      .map<Map<String, dynamic>>((user) => User.toMap(user))
      .toList(),
  );

  static List<User> decode(String musics) =>
  (json.decode(musics) as List<dynamic>)
      .map<User>((item) => User.fromJson(item))
      .toList();
  }



