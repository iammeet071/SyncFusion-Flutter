import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/api.dart';
import 'package:project/datagrid.dart';
import 'package:project/product.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:project/api.dart';

List<Product> chartlist = [];

List<Product> getData() {
  chartlist = generateProductList() as List<Product>;

  return chartlist;
}

class LineChart extends StatefulWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
            future: generateProductList(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return snapshot.hasData
                  ? SfCartesianChart(
                      tooltipBehavior: _tooltipBehavior,
                      palette: [HexColor("#ff5b7d"), HexColor("#2e2835")],
                      borderColor: Colors.red,
                      plotAreaBorderColor: Colors.red,
                      legend: Legend(
                          isVisible: true,
                          position: LegendPosition.top,
                          alignment: ChartAlignment.far),
                      // ignore: prefer_const_literals_to_create_immutables
                      series: <ChartSeries>[
                        LineSeries<Product, dynamic>(
                          enableTooltip: true,
                          name: "Product 1",
                          dataSource: productlist.sublist(0, 30),
                          xValueMapper: (Product product, _) =>
                              product.orderID!.toInt(),
                          yValueMapper: (Product product, _) =>
                              product.freight!.toDouble(),
                        ),
                        LineSeries<Product, dynamic>(
                          name: "Product 2",
                          dataSource: productlist.sublist(0, 30),
                          xValueMapper: (Product product, _) =>
                              product.orderID!.toInt(),
                          yValueMapper: (Product product, _) =>
                              product.employeeID!.toDouble(),
                        ),
                      ],
                      primaryXAxis: NumericAxis(
                          edgeLabelPlacement: EdgeLabelPlacement.shift),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    );
            }));
  }
}
