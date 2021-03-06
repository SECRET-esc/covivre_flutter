import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:covivre/constants/ColorsTheme.dart';

class HourChart extends StatefulWidget {
  HourChart({Key key, @required this.stateAtRisk, @required this.data})
      : super(key: key);
  bool stateAtRisk;
  Map data;

  @override
  _HourChartState createState() => _HourChartState();
}

class _HourChartState extends State<HourChart> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width * 0.9,
        padding: EdgeInsets.all(width * 0.02),
        child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
                labelStyle: TextStyle(
                    fontSize: width > 412 ? 18 : 16,
                    color: Colors.white,
                    fontFamily: "FaturaBook",
                    fontWeight: FontWeight.w500),
                majorGridLines: MajorGridLines(width: 0),
                axisLine: AxisLine(width: 0),
                labelPlacement: LabelPlacement.onTicks),
            primaryYAxis: NumericAxis(
              labelStyle: TextStyle(
                  color: Color.fromRGBO(89, 88, 104, 1), fontSize: 18),
              opposedPosition: true,
            ),
            // enableAxisAnimation: true,
            series: <CartesianSeries>[
              widget.stateAtRisk
                  ? AreaSeries<SalesData, String>(
                      dataSource: [
                          SalesData('25/10', 1),
                          SalesData('25/11', 2),
                          SalesData('25/12', 3),
                          SalesData('25/13', 0),
                          SalesData('now'.toUpperCase(), 5)
                        ],
                      color: Color.fromRGBO(117, 69, 59, 1),
                      // pointColorMapper: (SalesData sales, _) => sales.segmentColor,
                      xValueMapper: (SalesData sales, _) => sales.year,
                      yValueMapper: (SalesData sales, _) => sales.sales,
                      borderColor: Color.fromRGBO(245, 132, 74, 0.8),
                      borderWidth: 2,
                      markerSettings: MarkerSettings(
                          width: 20,
                          color: Theme.of(context).colorScheme.background,
                          height: 20,
                          borderColor: Color.fromRGBO(245, 132, 74, 0.8),
                          isVisible: true,
                          shape: DataMarkerType.circle))
                  : AreaSeries(
                      dataSource: null, xValueMapper: null, yValueMapper: null),
              AreaSeries<SalesData, String>(
                  dataSource: [
                    SalesData('25/10', 0),
                    SalesData('25/11', 0),
                    SalesData('25/12', 0),
                    SalesData('25/13', 0),
                    SalesData('now'.toUpperCase(), 3)
                  ],
                  color: Color.fromRGBO(66, 68, 54, 1),
                  // pointColorMapper: (SalesData sales, _) => sales.segmentColor,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  borderColor: Theme.of(context).colorScheme.base,
                  borderWidth: 2,
                  dataLabelSettings: DataLabelSettings(color: Colors.white),
                  markerSettings: MarkerSettings(
                      width: 20,
                      borderColor: Theme.of(context).colorScheme.base,
                      color: Theme.of(context).colorScheme.background,
                      height: 20,
                      isVisible: true,
                      shape: DataMarkerType.circle)),
            ]));
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
