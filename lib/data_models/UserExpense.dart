import 'dart:io';
import 'package:papyrus_client/data_models/DayExpense.dart';
import 'package:papyrus_client/data_models/WeekExpense.dart';
import 'package:papyrus_client/data_models/MonthExpense.dart';

class UserExpense {
  double totalLifetimeExpenseAmount = 0;
  double leisureLifetimeExpenseAmount = 0;
  double foodLifetimeExpenseAmount = 0;
  double transportationLifetimeExpenseAmount = 0;
  double necessitiesLifetimeExpenseAmount = 0;
  double miscellaneousLifetimeExpenseAmount = 0;

  String lastDateRecorded = "";
  String lastWeekRecorded = "";
  String lastMonthRecorded = "";
  String firstDayMonth = "";
  String firstDayWeek = "";
  double lastDateTotalExpenseAmount = 0;
  double lastDateLeisureExpenseAmount = 0;
  double lastDateFoodExpenseAmount = 0;
  double lastDateTransportationExpenseAmount = 0;
  double lastDateNecessitiesExpenseAmount = 0;
  double lastDateMiscellaneousExpenseAmount = 0;
  double lastWeekTotalExpenseAmount = 0;
  double lastWeekLeisureExpenseAmount = 0;
  double lastWeekFoodExpenseAmount = 0;
  double lastWeekTransportationExpenseAmount = 0;
  double lastWeekNecessitiesExpenseAmount = 0;
  double lastWeekMiscellaneousExpenseAmount = 0;
  double lastMonthTotalExpenseAmount = 0;
  double lastMonthLeisureExpenseAmount = 0;
  double lastMonthFoodExpenseAmount = 0;
  double lasMonthTransportationExpenseAmount = 0;
  double lastMonthNecessitiesExpenseAmount = 0;
  double lastMonthMiscellaneousExpenseAmount = 0;

  UserExpense() {}

  resetDateRecords() {
    lastDateTotalExpenseAmount = 0;
    lastDateLeisureExpenseAmount = 0;
    lastDateFoodExpenseAmount = 0;
    lastDateTransportationExpenseAmount = 0;
    lastDateNecessitiesExpenseAmount = 0;
    lastDateMiscellaneousExpenseAmount = 0;
  }

  resetWeekRecords() {
    lastWeekTotalExpenseAmount = 0;
    lastWeekLeisureExpenseAmount = 0;
    lastWeekFoodExpenseAmount = 0;
    lastWeekTransportationExpenseAmount = 0;
    lastWeekNecessitiesExpenseAmount = 0;
    lastWeekMiscellaneousExpenseAmount = 0;
  }

  resetMonthRecords() {
    lastMonthTotalExpenseAmount = 0;
    lastMonthLeisureExpenseAmount = 0;
    lastMonthFoodExpenseAmount = 0;
    lasMonthTransportationExpenseAmount = 0;
    lastMonthNecessitiesExpenseAmount = 0;
    lastMonthMiscellaneousExpenseAmount = 0;
  }

  initialize() {}

  Map<String, dynamic> toJson() => {
        "totalLifetimeExpenseAmount": totalLifetimeExpenseAmount,
        "leisureLifetimeExpenseAmount": leisureLifetimeExpenseAmount,
        "foodLifetimeExpenseAmount": foodLifetimeExpenseAmount,
        "transportationLifetimeExpenseAmount":
            transportationLifetimeExpenseAmount,
        "necessitiesLifetimeExpenseAmount": necessitiesLifetimeExpenseAmount,
        "miscellaneousLifetimeExpenseAmount":
            miscellaneousLifetimeExpenseAmount,
        "lastDateRecorded": lastDateRecorded,
        "lastWeekRecorded": lastWeekRecorded,
        lastMonthRecorded: lastMonthRecorded,
        "lastDateTotalExpenseAmount": lastDateTotalExpenseAmount,
        "lastDateLeisureExpenseAmount": lastDateLeisureExpenseAmount,
        "lastDateFoodExpenseAmount": lastDateFoodExpenseAmount,
        "lastDateTransportationExpenseAmount":
            lastDateTransportationExpenseAmount,
        "lastDateNecessitiesExpenseAmount": lastDateNecessitiesExpenseAmount,
        "lastDateMiscellaneousExpenseAmount":
            lastDateMiscellaneousExpenseAmount,
        "lastWeekTotalExpenseAmount": lastWeekTotalExpenseAmount,
        "lastWeekLeisureExpenseAmount": lastWeekLeisureExpenseAmount,
        "lastWeekFoodExpenseAmount": lastWeekFoodExpenseAmount,
        "lastWeekTransportationExpenseAmount":
            lastWeekTransportationExpenseAmount,
        "lastWeekNecessitiesExpenseAmount": lastWeekNecessitiesExpenseAmount,
        "lastWeekMiscellaneousExpenseAmount":
            lastWeekMiscellaneousExpenseAmount,
        "lastMonthTotalExpenseAmount": lastMonthTotalExpenseAmount,
        "lastMonthLeisureExpenseAmount": lastMonthLeisureExpenseAmount,
        "lastMonthFoodExpenseAmount": lastMonthFoodExpenseAmount,
        "lasMonthTransportationExpenseAmount":
            lasMonthTransportationExpenseAmount,
        "lastMonthNecessitiesExpenseAmount": lastMonthNecessitiesExpenseAmount,
        "lastMonthMiscellaneousExpenseAmount":
            lastMonthMiscellaneousExpenseAmount,
        "firstDayWeek": firstDayWeek,
        "firstDayMonth": firstDayMonth
      };

  // factory UserExpense.fromJson(Map<String, dynamic> json) {
  //   UserExpense userExpense = UserExpense()
  //     ..totalLifetimeExpenseAmount = json["totalLifetimeExpenseAmount"]
  //     ..foodLifetimeExpenseAmount = json['foodLifetimeExpenseAmount']
  //     ..transportationLifetimeExpenseAmount =
  //         json['transportationLifetimeExpenseAmount']
  //     ..necessitiesLifetimeExpenseAmount =
  //         json['necessitiesLifetimeExpenseAmount']
  //     ..miscellaneousLifetimeExpenseAmount =
  //         json['miscellaneousLifetimeExpenseAmount']
  //     ..leisureLifetimeExpenseAmount = json['leisureLifetimeExpenseAmount'] ;
  //   return userExpense;
  // }

  UserExpense.fromJson(Map<String, dynamic> json)
      : totalLifetimeExpenseAmount = json["totalLifetimeExpenseAmount"],
        foodLifetimeExpenseAmount = json['foodLifetimeExpenseAmount'],
        transportationLifetimeExpenseAmount =
            json['transportationLifetimeExpenseAmount'],
        necessitiesLifetimeExpenseAmount =
            json['necessitiesLifetimeExpenseAmount'],
        miscellaneousLifetimeExpenseAmount =
            json['miscellaneousLifetimeExpenseAmount'],
        leisureLifetimeExpenseAmount = json['leisureLifetimeExpenseAmount'],
        lastDateRecorded = json["lastDateRecorded"],
        lastWeekRecorded = json["lastWeekRecorded"],
        lastMonthRecorded = json["lastMonthRecorded"],
        lastDateTotalExpenseAmount = json["lastDateTotalExpenseAmount"],
        lastDateLeisureExpenseAmount = json["lastDateLeisureExpenseAmount"],
        lastDateFoodExpenseAmount = json["lastDateFoodExpenseAmount"],
        lastDateTransportationExpenseAmount =
            json["lastDateTransportationExpenseAmount"],
        lastDateNecessitiesExpenseAmount =
            json["lastDateNecessitiesExpenseAmount"],
        lastDateMiscellaneousExpenseAmount =
            json["lastDateMiscellaneousExpenseAmount"],
        lastWeekTotalExpenseAmount = json["lastWeekTotalExpenseAmount"],
        lastWeekLeisureExpenseAmount = json["lastWeekLeisureExpenseAmount"],
        lastWeekFoodExpenseAmount = json["lastWeekFoodExpenseAmount"],
        lastWeekTransportationExpenseAmount =
            json["lastWeekTransportationExpenseAmount"],
        lastWeekNecessitiesExpenseAmount =
            json["lastWeekNecessitiesExpenseAmount"],
        lastWeekMiscellaneousExpenseAmount =
            json["lastWeekMiscellaneousExpenseAmount"],
        lastMonthTotalExpenseAmount = json["lastMonthTotalExpenseAmount"],
        lastMonthLeisureExpenseAmount = json["lastMonthLeisureExpenseAmount"],
        lastMonthFoodExpenseAmount = json["lastMonthFoodExpenseAmount"],
        lasMonthTransportationExpenseAmount =
            json["lasMonthTransportationExpenseAmount"],
        lastMonthNecessitiesExpenseAmount =
            json["lastMonthNecessitiesExpenseAmount"],
        lastMonthMiscellaneousExpenseAmount =
            json["lastMonthMiscellaneousExpenseAmount"],
        firstDayWeek = json['firstDayWeek'],
        firstDayMonth = json['firstDayMonth'];
}

enum Category { LEISURE, FOOD, TRANSPORTATION, MISCELLANEOUS, NECESSITIES }
enum Period { MONTHLY, WEEKLY, DAILY }

class ExpenseItem {
  String category;
  double amount;
  String dateTime;

  ExpenseItem(this.category, this.amount, this.dateTime);

  Map<String, dynamic> toJson() => {
        "category": category,
        "amount": amount,
        "dateTime": dateTime,
      };

  ExpenseItem.fromJson(Map<String, dynamic> json)
      : category = json["category"],
        amount = json['amount'],
        dateTime = (json['dateTime']);
}
