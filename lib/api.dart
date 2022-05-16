import 'dart:convert';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LineChart();
  }
}

List<Product> productlist = [];
late JsonDataGridSource jsonDataGridSource;

Future generateProductList() async {
  var response = await http.get(Uri.parse(
      'https://ej2services.syncfusion.com/production/web-services/api/Orders'));
  // print(json.decode(response.body));
  var list = json.decode(response.body).cast<Map<String, dynamic>>();
  productlist =
      await list.map<Product>((json) => Product.fromJson(json)).toList();
  jsonDataGridSource = JsonDataGridSource(productlist.sublist(0, 5));

  return productlist;
}
