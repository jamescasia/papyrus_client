
class WeekExpense {
  String weekOfMonthNumber;
  String dateOfFirstDayOfWeek;
  double totalSpent;
  double totalSpentOnFood;
  double totalSpentOnMiscellaneous;
  double totalSpentOnTransportation;
  double totalSpentOnLeisure;
  double totalSpentOnUtilities;

  WeekExpense(
    
      this.weekOfMonthNumber,
      this.dateOfFirstDayOfWeek,
      this.totalSpentOnFood,
      this.totalSpentOnMiscellaneous,
      this.totalSpentOnTransportation,
      this.totalSpentOnLeisure,
      this.totalSpentOnUtilities,
      this.totalSpent);

  WeekExpense.fromJson(Map<String, dynamic> json)
      : weekOfMonthNumber = json["weekOfMonthNumber"],
        totalSpentOnFood = json['totalSpentOnFood'],
        totalSpentOnMiscellaneous = (json['totalSpentOnMiscellaneous']),
        totalSpentOnTransportation = json["totalSpentOnTransportation"],
        totalSpentOnLeisure = json['totalSpentOnLeisure'],
        dateOfFirstDayOfWeek = json['dateOfFirstDayOfWeek'],
        totalSpentOnUtilities = (json['totalSpentOnUtilities']),
        totalSpent = (json['totalSpent']) ;


  Map<String, dynamic> toJson() => {
        "weekOfMonthNumber": weekOfMonthNumber,
        "totalSpentOnFood": totalSpentOnFood,
        "totalSpentOnMiscellaneous": totalSpentOnMiscellaneous,
        "totalSpentOnTransportation": totalSpentOnTransportation,
        "totalSpentOnLeisure": totalSpentOnLeisure,
        "totalSpentOnUtilities": totalSpentOnUtilities,
        "dateOfFirstDayOfWeek": dateOfFirstDayOfWeek,
        "totalSpent": totalSpent,
      };
}
 