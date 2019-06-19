
class MonthExpense {
  String monthOfYearNumber;
  String dateOfFirstDayOfMonth;
  double totalSpent;
  double totalSpentOnFood;
  double totalSpentOnMiscellaneous;
  double totalSpentOnTransportation;
  double totalSpentOnLeisure;
  double totalSpentOnUtilities;

  MonthExpense(
      this.monthOfYearNumber,
      this.dateOfFirstDayOfMonth,
      this.totalSpentOnFood,
      this.totalSpentOnMiscellaneous,
      this.totalSpentOnTransportation,
      this.totalSpentOnLeisure,
      this.totalSpentOnUtilities,
      this.totalSpent);

  MonthExpense.fromJson(Map<String, dynamic> json)
      : monthOfYearNumber = json["monthOfYearNumber"],
        totalSpentOnFood = json['totalSpentOnFood'],
        totalSpentOnMiscellaneous = (json['totalSpentOnMiscellaneous']),
        totalSpentOnTransportation = json["totalSpentOnTransportation"],
        totalSpentOnLeisure = json['totalSpentOnLeisure'],
        dateOfFirstDayOfMonth = json['dateOfFirstDayOfMonth'],
        totalSpentOnUtilities = (json['totalSpentOnUtilities']),
        totalSpent = (json['totalSpent']) ;


  Map<String, dynamic> toJson() => {
        "monthOfYearNumber": monthOfYearNumber,
        "totalSpentOnFood": totalSpentOnFood,
        "totalSpentOnMiscellaneous": totalSpentOnMiscellaneous,
        "totalSpentOnTransportation": totalSpentOnTransportation,
        "totalSpentOnLeisure": totalSpentOnLeisure,
        "totalSpentOnUtilities": totalSpentOnUtilities,
        "dateOfFirstDayOfMonth": dateOfFirstDayOfMonth,
        "totalSpent": totalSpent,
      };
}
 