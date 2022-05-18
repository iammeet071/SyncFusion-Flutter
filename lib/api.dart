import 'dart:convert';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/chart.dart';
import 'package:project/datagrid.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/product.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  @override
  void initState() {
    generateProductList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart();
  }
}

List<Product> productlist = [];
List<Product> productlist1 = [];
late JsonDataGridSource jsonDataGridSource;
var list, list1;
List<int> sortedDeaths = [];
List<int> sortedTotal = [];
List<int> abc = [];
Future generateProductList() async {
  var response = await http
      .get(Uri.parse('https://api.rootnet.in/covid19-in/stats/history'));

  // print(json.decode(response.body)["data"][i]["regional"][j]
  //     ["totalConfirmed"]);
  // print(json.decode(response.body)["data"][i]["day"][j]["totalConfirmed"]);
  list = json
      .decode(response.body)["data"][200]["regional"]
      .cast<Map<String, dynamic>>();
  list1 = json
      .decode(response.body)["data"][210]["regional"]
      .cast<Map<String, dynamic>>();
  print("object");
  print(json.decode(response.body)["data"][210]["day"]);
  print("object");

  // print(list);

  productlist =
      await list.map<Product>((json) => Product.fromJson(json)).toList();
  jsonDataGridSource = JsonDataGridSource(productlist);
  sorted();
  productlist1 =
      await list1.map<Product>((json) => Product.fromJson(json)).toList();
  jsonDataGridSource = JsonDataGridSource(productlist1);

  return productlist;
}

Future<List<int>> sorted() async {
  productlist.forEach((element) {
    sortedDeaths.add(element.deaths!.toInt());
  });
  sortedDeaths.sort();
  sortedDeaths.toSet().toList();
  print(sortedDeaths.toSet().toList());

  return sortedDeaths.toSet().toList();
}

Future<List<int>> sortedTotalCase() async {
  productlist.forEach((element) {
    sortedTotal.add(element.totalConfirmed!.toInt());
  });
  sortedTotal.sort();
  sortedTotal.toSet().toList();
  print(sortedTotal.toSet().toList());

  return sortedTotal.toSet().toList();
}
