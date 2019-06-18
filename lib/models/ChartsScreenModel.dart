import 'package:scoped_model/scoped_model.dart';

import 'package:papyrus_client/helpers/GaugeChart.dart';
import 'package:papyrus_client/helpers/TimeSeriesChart.dart';
import 'package:papyrus_client/helpers/GroupBarChart.dart';
import 'AppModel.dart';
import 'package:flutter/material.dart';

import 'package:papyrus_client/data_models/Message.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:papyrus_client/helpers/MessageBox.dart';

import 'package:papyrus_client/data_models/UserExpense.dart';
import 'dart:math';
import 'package:papyrus_client/data_models/DayExpense.dart';
import 'package:papyrus_client/data_models/WeekExpense.dart';
import 'package:papyrus_client/data_models/MonthExpense.dart';

class ChartsScreenModel extends Model {
  AppModel appModel;
  ChartsScreenModel(this.appModel);

  launch() {}

  List<charts.Series<DataSegment, String>> generateChartData(Period period) {
    var map = appModel.dayExpense.toJson();
    var data;
    if (period == Period.DAILY) {
      data = [
        new DataSegment("totalSpentOnFood",
            appModel.dayExpense.totalSpentOnFood, "#f4a735"),
        new DataSegment("totalSpentOnLeisure",
            appModel.dayExpense.totalSpentOnLeisure, "#fef09c"),
        new DataSegment("totalSpentOnTransportation",
            appModel.dayExpense.totalSpentOnTransportation, "#8ec8f8"),
        new DataSegment("totalSpentOnUtilities",
            appModel.dayExpense.totalSpentOnUtilities, "#a1d2a6"),
        new DataSegment("totalSpentOnMiscellaneous",
            appModel.dayExpense.totalSpentOnMiscellaneous, "#ee9698"),
      ];
    }
    if (period == Period.WEEKLY) {
      data = [
        new DataSegment("totalSpentOnFood",
            appModel.weekExpense.totalSpentOnFood, "#f4a735"),
        new DataSegment("totalSpentOnLeisure",
            appModel.weekExpense.totalSpentOnLeisure, "#fef09c"),
        new DataSegment("totalSpentOnTransportation",
            appModel.weekExpense.totalSpentOnTransportation, "#8ec8f8"),
        new DataSegment("totalSpentOnUtilities",
            appModel.weekExpense.totalSpentOnUtilities, "#a1d2a6"),
        new DataSegment("totalSpentOnMiscellaneous",
            appModel.weekExpense.totalSpentOnMiscellaneous, "#ee9698"),
      ];
    }
    if (period == Period.MONTHLY) {
      data = [
        new DataSegment("totalSpentOnFood",
            appModel.monthExpense.totalSpentOnFood, "#f4a735"),
        new DataSegment("totalSpentOnLeisure",
            appModel.monthExpense.totalSpentOnLeisure, "#fef09c"),
        new DataSegment("totalSpentOnTransportation",
            appModel.monthExpense.totalSpentOnTransportation, "#8ec8f8"),
        new DataSegment("totalSpentOnUtilities",
            appModel.monthExpense.totalSpentOnUtilities, "#a1d2a6"),
        new DataSegment("totalSpentOnMiscellaneous",
            appModel.monthExpense.totalSpentOnMiscellaneous, "#ee9698"),
      ];
    }
    return [
      new charts.Series<DataSegment, String>(
        id: 'Segments',
        domainFn: (DataSegment gd, _) => gd.name,
        measureFn: (DataSegment gd, _) => gd.value,
        colorFn: (DataSegment gd, _) => charts.Color.fromHex(code: gd.color),
        data: data,
      )
    ];
  }

  List<charts.Series<DataSegment, String>> createSampleData() {
    var data = [
      new DataSegment('a', 10, "#f4a735"),
      new DataSegment('b', 20, "#fef09c"),
      new DataSegment('c', 30, "#8ec8f8"),
      new DataSegment('d', 35, "#a1d2a6"),
      new DataSegment('e e', 5, "#ee9698"),
      // new DataSegment('Highly Unusual', 20, "#ee9698"),
    ];

    return [
      new charts.Series<DataSegment, String>(
        id: 'Segments',
        domainFn: (DataSegment gd, _) => gd.name,
        measureFn: (DataSegment gd, _) => gd.value,
        colorFn: (DataSegment gd, _) => charts.Color.fromHex(code: gd.color),
        data: data,
      )
    ];
  }
}

class DataSegment {
  final String name;
  final double value;
  final String color;
  DataSegment(this.name, this.value, this.color);
}
