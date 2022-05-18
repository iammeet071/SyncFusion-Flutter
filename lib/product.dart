import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:hexcolor/hexcolor.dart';

class Product {
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        loc: json['loc'],
        confirmedCasesIndian: json['confirmedCasesIndian'],
        deaths: json['deaths'],
        // orderDate: DateTime.parse(json['OrderDate']),
        // shippedDate: DateTime.parse(json['ShippedDate']),
        totalConfirmed: json['totalConfirmed']);
    // shipName: json['ShipName'],
    // shipAddress: json['ShipAddress'],
    // shipCity: json['ShipCity'],
    // shipPostelCode: json['ShipPostelCode'],
    // shipCountry: json['ShipCountry']);
  }

  Product({
    this.loc,
    this.confirmedCasesIndian,
    this.deaths,
    this.totalConfirmed,
  });
  String? loc;
  int? confirmedCasesIndian;
  int? deaths;
  int? totalConfirmed;
}

class JsonDataGridSource extends DataGridSource {
  JsonDataGridSource(this.productlist) {
    buildDataGridRow();
  }

  List<DataGridRow> dataGridRows = [];
  List<Product> productlist = [];

  void buildDataGridRow() {
    dataGridRows = productlist.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Location', value: dataGridRow.loc),
        DataGridCell<int>(
            columnName: 'Confirmed Cases',
            value: dataGridRow.confirmedCasesIndian),
        DataGridCell<int>(columnName: 'Deaths', value: dataGridRow.deaths),
        DataGridCell<int>(
            columnName: 'Total Confirm', value: dataGridRow.totalConfirmed),
      ]);
    }).toList(growable: false);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        color: HexColor("#2e2835"),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        color: HexColor("#ff5b7d"),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      Container(
        color: HexColor("#ff5b7d"),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      Container(
        color: HexColor("#ff5b7d"),
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    ]);
  }
}
