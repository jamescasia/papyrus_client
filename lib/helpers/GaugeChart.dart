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
    return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: sizeMulW * 20,
            width: sizeMulW*20,
            decoration: BoxDecoration(
              color: color,
                borderRadius: BorderRadius.all(
              Radius.circular(3000),
              
              // color: color,
            )),
          ),
          SizedBox(width: sizeMulW*5,),
          Text(
            
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15 * sizeMulW,
            ),
          )
        ],
      // ),
    );
  }
}
