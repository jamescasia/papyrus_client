
class DayExpense {
  String dateTime;
  double totalSpent;
  double totalSpentOnFood;
  double totalSpentOnMiscellaneous;
  double totalSpentOnTransportation;
  double totalSpentOnLeisure;
  double totalSpentOnNecessities;

  DayExpense(
      this.dateTime,
      this.totalSpentOnFood,
      this.totalSpentOnMiscellaneous,
      this.totalSpentOnTransportation,
      this.totalSpentOnLeisure,
      this.totalSpentOnNecessities,
      this.totalSpent);

  DayExpense.fromJson(Map<String, dynamic> json)
      : dateTime = json["dateTime"],
        totalSpentOnFood = json['totalSpentOnFood'],
        totalSpentOnMiscellaneous = (json['totalSpentOnMiscellaneous']),
        totalSpentOnTransportation = json["totalSpentOnTransportation"],
        totalSpentOnLeisure = json['totalSpentOnLeisure'],
        totalSpentOnNecessities = (json['totalSpentOnNecessities']),
        totalSpent = (json['totalSpent']) ;


  Map<String, dynamic> toJson() => {
        "dateTime": dateTime,
        "totalSpentOnFood": totalSpentOnFood,
        "totalSpentOnMiscellaneous": totalSpentOnMiscellaneous,
        "totalSpentOnTransportation": totalSpentOnTransportation,
        "totalSpentOnLeisure": totalSpentOnLeisure,
        "totalSpentOnNecessities": totalSpentOnNecessities,
        "totalSpent": totalSpent,
      };
}
