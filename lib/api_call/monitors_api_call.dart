import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:monitors/models/monitor.dart';

//Future<List<Monitor>>
class MonitorsCall {
  Future<List<Monitor>> getMonitors(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final length = document
          .getElementById("show_items")!
          .getElementsByClassName("product-item-container")
          .length;
      String title(int index) => document
          .getElementById("show_items")!
          .getElementsByClassName("product-item-container")[index]
          .getElementsByClassName("caption hide-cont")
          .first
          .text
          .trim();
      String price(int index) => document
          .getElementById("show_items")!
          .getElementsByClassName("product-item-container")[index]
          .getElementsByClassName("price")
          .first
          .text
          .trim();
      String imgUrl(int index) {
        return document
            .getElementById("show_items")!
            .getElementsByTagName("img")[0]
            .attributes['src']
            .toString();
      }

      List<Monitor> monitors;
      monitors = List.generate(length, (index) {
        return Monitor(imgUrl(index), title(index), double.parse(price(index)));
      });
      print(imgUrl(1));
      return monitors;
    } else {
      throw Exception("No data Loaded");
    }
  }
}
