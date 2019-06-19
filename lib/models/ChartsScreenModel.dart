import 'package:scoped_model/scoped_model.dart';

import 'package:papyrus_client/helpers/GaugeChart.dart';
import 'package:papyrus_client/helpers/TimeSeriesChart.dart';
import 'package:papyrus_client/helpers/GroupBarChart.dart';
import 'AppModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:papyrus_client/data_models/Message.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:papyrus_client/helpers/MessageBox.dart';

import 'package:papyrus_client/data_models/UserExpense.dart';
import 'dart:math';
import 'package:papyrus_client/data_models/DayExpense.dart';
import 'package:papyrus_client/data_models/WeekExpense.dart';
import 'package:papyrus_client/data_models/MonthExpense.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class ChartsScreenModel extends Model {
  AppModel appModel;
  ChartsScreenModel(this.appModel);
  List<DayExpense> dayExpenses;
  List<WeekExpense> weekExpenses;
  List<MonthExpense> monthExpenses;

  launch() async {}

  List<charts.Series<DataSegment, String>> generateGaugeChartData(
      Period period) {
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

  Future<List<charts.Series<DataBar, String>>> generateGroupedBarChartData(
      Period period) async {
    try {
      // print(await appModel.dayExpenseFile.readAsLines());
      dayExpenses = (await appModel.dayExpenseFile.readAsLines())
          .map((f) => DayExpense.fromJson(jsonDecode(f)))
          .toList();

      weekExpenses = (await appModel.weekExpenseFile.readAsLines())
          .map((f) => WeekExpense.fromJson(jsonDecode(f)))
          .toList();

      monthExpenses = (await appModel.monthExpenseFile.readAsLines())
          .map((f) => MonthExpense.fromJson(jsonDecode(f)))
          .toList();
    } catch (e) {}

    var leisureTotalData;
    var foodTotalData;
    var transpoTotalData;
    var utilTotalData;
    var miscTotalData;
    if (period == Period.DAILY) {
      foodTotalData = dayExpenses
          .sublist((dayExpenses.length >= 6) ? dayExpenses.length - 6 : 0)
          .map((f) => DataBar("food", f.totalSpentOnFood, "#f4a735",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateTime))

              // f.dateTime
              ))
          .toList();
      leisureTotalData = dayExpenses
          .sublist((dayExpenses.length >= 6) ? dayExpenses.length - 6 : 0)
          .map((f) => DataBar("leisure", f.totalSpentOnLeisure, "#fef09c",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateTime))
              // f.dateTime

              ))
          .toList();
      transpoTotalData = dayExpenses
          .sublist((dayExpenses.length >= 6) ? dayExpenses.length - 6 : 0)
          .map((f) => DataBar(
              "transportation",
              f.totalSpentOnTransportation,
              "#8ec8f8",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateTime))
              // f.dateTime

              ))
          .toList();

      utilTotalData = dayExpenses
          .sublist((dayExpenses.length >= 6) ? dayExpenses.length - 6 : 0)
          .map((f) => DataBar("utilities", f.totalSpentOnUtilities, "#a1d2a6",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateTime))
              // f.dateTime

              ))
          .toList();

      miscTotalData = dayExpenses
          .sublist((dayExpenses.length >= 6) ? dayExpenses.length - 6 : 0)
          .map((f) => DataBar(
              "miscellaneous",
              f.totalSpentOnMiscellaneous,
              "#ee9698",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateTime))

              // f.dateTime
              ))
          .toList();
    }

    if (period == Period.WEEKLY) {
      foodTotalData = weekExpenses
          .sublist((weekExpenses.length >= 6) ? weekExpenses.length - 6 : 0)
          .map((f) => DataBar("food", f.totalSpentOnFood, "#f4a735",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfWeek))

              // f.dateTime
              ))
          .toList();
      leisureTotalData = weekExpenses
          .sublist((weekExpenses.length >= 6) ? weekExpenses.length - 6 : 0)
          .map((f) => DataBar("leisure", f.totalSpentOnLeisure, "#fef09c",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfWeek))
              // f.dateTime

              ))
          .toList();
      transpoTotalData = weekExpenses
          .sublist((weekExpenses.length >= 6) ? weekExpenses.length - 6 : 0)
          .map((f) => DataBar(
              "transportation",
              f.totalSpentOnTransportation,
              "#8ec8f8",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfWeek))
              // f.dateTime

              ))
          .toList();

      utilTotalData = weekExpenses
          .sublist((weekExpenses.length >= 6) ? weekExpenses.length - 6 : 0)
          .map((f) => DataBar("utilities", f.totalSpentOnUtilities, "#a1d2a6",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfWeek))
              // f.dateTime

              ))
          .toList();

      miscTotalData = weekExpenses
          .sublist((weekExpenses.length >= 6) ? weekExpenses.length - 6 : 0)
          .map((f) => DataBar(
              "miscellaneous",
              f.totalSpentOnMiscellaneous,
              "#ee9698",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfWeek))

              // f.dateTime
              ))
          .toList();
    }

     if (period == Period.MONTHLY) {
      foodTotalData = monthExpenses
          .sublist((monthExpenses.length >= 6) ? monthExpenses.length - 6 : 0)
          .map((f) => DataBar("food", f.totalSpentOnFood, "#f4a735",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfMonth))

              // f.dateTime
              ))
          .toList();
      leisureTotalData = monthExpenses
          .sublist((monthExpenses.length >= 6) ? monthExpenses.length - 6 : 0)
          .map((f) => DataBar("leisure", f.totalSpentOnLeisure, "#fef09c",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfMonth))
              // f.dateTime

              ))
          .toList();
      transpoTotalData = monthExpenses
          .sublist((monthExpenses.length >= 6) ? monthExpenses.length - 6 : 0)
          .map((f) => DataBar(
              "transportation",
              f.totalSpentOnTransportation,
              "#8ec8f8",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfMonth))
              // f.dateTime

              ))
          .toList();

      utilTotalData = monthExpenses
          .sublist((monthExpenses.length >= 6) ? monthExpenses.length - 6 : 0)
          .map((f) => DataBar("utilities", f.totalSpentOnUtilities, "#a1d2a6",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfMonth))
              // f.dateTime

              ))
          .toList();

      miscTotalData = monthExpenses
          .sublist((monthExpenses.length >= 6) ? monthExpenses.length - 6 : 0)
          .map((f) => DataBar(
              "miscellaneous",
              f.totalSpentOnMiscellaneous,
              "#ee9698",
              DateFormat('MM dd yyyy').format(DateTime.parse(f.dateOfFirstDayOfMonth))

              // f.dateTime
              ))
          .toList();
    }

    return [
      new charts.Series<DataBar, String>(
        id: 'Food',
        domainFn: (DataBar db, _) => db.date,
        measureFn: (DataBar db, _) => db.value,
        data: foodTotalData,
        colorFn: (DataBar db, _) => charts.Color.fromHex(code: db.color),
      ),
      new charts.Series<DataBar, String>(
        id: 'Leisure',
        domainFn: (DataBar db, _) => db.date,
        measureFn: (DataBar db, _) => db.value,
        data: leisureTotalData,
        colorFn: (DataBar db, _) => charts.Color.fromHex(code: db.color),
      ),
      new charts.Series<DataBar, String>(
        id: 'Miscellaneous',
        domainFn: (DataBar db, _) => db.date,
        measureFn: (DataBar db, _) => db.value,
        colorFn: (DataBar db, _) => charts.Color.fromHex(code: db.color),
        data: miscTotalData,
      ),
      new charts.Series<DataBar, String>(
        id: 'Transportation',
        domainFn: (DataBar db, _) => db.date,
        measureFn: (DataBar db, _) => db.value,
        colorFn: (DataBar db, _) => charts.Color.fromHex(code: db.color),
        data: transpoTotalData,
      ),
      new charts.Series<DataBar, String>(
        id: 'Utilities',
        domainFn: (DataBar db, _) => db.date,
        measureFn: (DataBar db, _) => db.value,
        colorFn: (DataBar db, _) => charts.Color.fromHex(code: db.color),
        data: utilTotalData,
      ),
    ];
  }
}

class DataBar {
  final String name;
  final double value;
  final String color;
  final String date;
  DataBar(this.name, this.value, this.color, this.date);
}

class DataSegment {
  final String name;
  final double value;
  final String color;
  DataSegment(this.name, this.value, this.color);
}
