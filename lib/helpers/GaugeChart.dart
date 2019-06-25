import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:papyrus_client/screens/HomeScreen.dart';

// import 'charts';
class GaugeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GaugeChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.

  factory GaugeChart.withSampleData() {
    return new GaugeChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('Acceptable', 60,"#ababab"),
      new GaugeSegment('High', 40,"#bcbcbc"),
      new GaugeSegment('Highly Unusual', 20,"#dedede"),
      new GaugeSegment('Low', 10, "#efefef"),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        colorFn: (GaugeSegment segment, _) => charts.Color.fromHex(code: segment.color),
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 30px. The remaining space in
        // the chart will be left as a hole in the center. Adjust the start
        // angle and the arc length of the pie so it resembles a gauge.
        defaultRenderer: new charts.ArcRendererConfig(
            arcWidth: (sizeMulW * 24).toInt(),
            startAngle: 4 / 5 * pi,
            arcLength: 7 / 5 * pi));
  }

  /// Create one series with sample hard coded data.

}

class GaugeChartLegendItem extends StatelessWidget {
  final String title;
  final Color color;
  GaugeChartLegendItem(this.title, this.color);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: sizeMulW * 20,
          width: sizeMulW * 20,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(
                Radius.circular(3000),

                // color: color,
              )),
        ),
        SizedBox(
          width: sizeMulW * 5,
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1.1,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            // fontSize: 15 * sizeMulW,
          ),
        )
      ],
      // ),
    );
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;
  final String color;

  GaugeSegment(this.segment, this.size, this.color);
}
