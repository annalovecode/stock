import 'dart:convert';

/**
 * a class used to handle stock encode and decode
 */
class Stock {
  String name = "";
  String CompanyName = "";

  Stock(this.name, this.CompanyName);

  Stock.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        CompanyName = json['age'];

  Map<String, dynamic> toJson() => {'name': name, 'age': CompanyName};

  static Map<String, dynamic> toMap(Stock user) =>
      {'name': user.name, 'age': user.CompanyName};

  static String encode(List<Stock> user) => json.encode(
        user.map<Map<String, dynamic>>((user) => Stock.toMap(user)).toList(),
      );

  static List<Stock> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Stock>((item) => Stock.fromJson(item))
          .toList();
}
