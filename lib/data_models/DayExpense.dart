
class DayExpense {
  String dateTime;
  double totalSpent;
  double totalSpentOnFood;
  double totalSpentOnMiscellaneous;
  double totalSpentOnTransportation;
  double totalSpentOnLeisure;
  double totalSpentOnUtilities;

  DayExpense(
      this.dateTime,
      this.totalSpentOnFood,
      this.totalSpentOnMiscellaneous,
      this.totalSpentOnTransportation,
      this.totalSpentOnLeisure,
      this.totalSpentOnUtilities,
      this.totalSpent);

  DayExpense.fromJson(Map<String, dynamic> json)
      : dateTime = json["dateTime"],
        totalSpentOnFood = json['totalSpentOnFood'],
        totalSpentOnMiscellaneous = (json['totalSpentOnMiscellaneous']),
        totalSpentOnTransportation = json["totalSpentOnTransportation"],
        totalSpentOnLeisure = json['totalSpentOnLeisure'],
        totalSpentOnUtilities = (json['totalSpentOnUtilities']),
        totalSpent = (json['totalSpent']) ;


  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "totalSpentOnFood": totalSpentOnFood,
        "totalSpentOnMiscellaneous": totalSpentOnMiscellaneous,
        "totalSpentOnTransportation": totalSpentOnTransportation,
        "totalSpentOnLeisure": totalSpentOnLeisure,
        "totalSpentOnUtilities": totalSpentOnUtilities,
        "totalSpent": totalSpent,
      };
}
