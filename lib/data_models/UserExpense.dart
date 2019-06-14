// class UserExpense {
//   double total_lifetime_expense_amount;

//   List<ExpenseItem> lifetime_expenses;

//   UserExpense();

//   addExpense(ExpenseItem expenseItem) {
//     lifetime_expenses.insert(0, expenseItem);
//   }

//   factory UserExpense.fromJson(Map<String, dynamic> json) {
//     var r = UserExpense();
//     var list = json['lifetime_expenses'] as List;
//     if (list.length > 0) {
//       List<ExpenseItem> rList =
//           list.map((i) => ExpenseItem.fromJson(i)).toList();
//       r.lifetime_expenses = rList;
//     } else
//       r.lifetime_expenses = <ExpenseItem>[];
//     return r;
//   }
//   Map<String, dynamic> toJson() => {
//         "total_lifetime_expense_amount": total_lifetime_expense_amount,
//         "lifetime_expenses": lifetime_expenses.map((f) => f.toJson()).toList(),
//       };
// }

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

  UserExpense() {}

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
      };

  factory UserExpense.fromJson(Map<String, dynamic> json) {
    UserExpense userExpense = UserExpense()
      ..totalLifetimeExpenseAmount = json["totalLifetimeExpenseAmount"]
      ..foodLifetimeExpenseAmount = json['foodLifetimeExpenseAmount']
      ..transportationLifetimeExpenseAmount =
          json['transportationLifetimeExpenseAmount']
      ..necessitiesLifetimeExpenseAmount =
          json['necessitiesLifetimeExpenseAmount']
      ..miscellaneousLifetimeExpenseAmount =
          json['miscellaneousLifetimeExpenseAmount']
      ..leisureLifetimeExpenseAmount = json['leisureLifetimeExpenseAmount'] ;
    return userExpense;
  }
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
