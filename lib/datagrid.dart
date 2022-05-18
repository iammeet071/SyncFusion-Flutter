// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/api.dart';
import 'package:project/chart.dart';
import 'package:project/product.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:hexcolor/hexcolor.dart';

class JsonDataGrid extends StatefulWidget {
  @override
  _JsonDataGridState createState() => _JsonDataGridState();
}

class _JsonDataGridState extends State<JsonDataGrid> {
  Product product = Product();

  List<GridColumn> getColumns() {
    List<GridColumn> columns;
    columns = ([
      GridColumn(
        columnName: 'Loc',
        allowSorting: true,
        width: 120,
        label: Container(
            color: HexColor("#2e2835"),
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Text('Location',
                overflow: TextOverflow.clip,
                softWrap: true,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
      ),
      GridColumn(
        columnName: 'confirmedCasesIndian',
        allowSorting: true,
        width: 120,
        label: Container(
          color: HexColor("#2e2835"),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text('Confirmed Indian Cases',
              overflow: TextOverflow.clip,
              softWrap: true,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      GridColumn(
        columnName: 'deaths',
        allowSorting: true,
        width: 120,
        label: Container(
          color: HexColor("#2e2835"),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'Deaths',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
      GridColumn(
        columnName: 'totalConfirmed',
        allowSorting: true,
        width: 120,
        label: Container(
          color: HexColor("#2e2835"),
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Text(
            'Total Confirmed Cases',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
        ),
      ),
    ]);
    return columns;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "COVID ANALYSIS TABLE",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  child: FutureBuilder(
                      future: generateProductList(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return snapshot.hasData
                            ? SfDataGrid(
                                source: jsonDataGridSource,
                                columns: getColumns())
                            : Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              );
                      })),
              SizedBox(
                height: 40,
              ),
              Text(
                "COVID ANALYSIS CHART",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Api(),
            ],
          ),
        ),
      ),
    );
  }
}
