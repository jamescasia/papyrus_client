enum Period { YEARLY, MONTHLY, DAILY }

class UserExpense {
  double total_lifetime_expense_amount;

  List<ExpenseItem> lifetime_expenses;

  UserExpense();

  addExpense(ExpenseItem expenseItem) {
    lifetime_expenses.insert(0, expenseItem);
  }

  factory UserExpense.fromJson(Map<String, dynamic> json) {
    var r = UserExpense();
    var list = json['lifetime_expenses'] as List;
    if (list.length > 0) {
      List<ExpenseItem> rList =
          list.map((i) => ExpenseItem.fromJson(i)).toList();
      r.lifetime_expenses = rList;
    } else
      r.lifetime_expenses = <ExpenseItem>[];
    return r;
  }
  Map<String, dynamic> toJson() => {
        "total_lifetime_expense_amount": total_lifetime_expense_amount,
        "lifetime_expenses": lifetime_expenses.map((f) => f.toJson()).toList(),
      };
}

enum Category { LEISURE, FOOD, TRANSPORTATION, MISCELLANEOUS, NECESSITIES }

class ExpenseItem {
  Category category;
  double amount;
  DateTime date;

  ExpenseItem({Category category, double amount, DateTime date});

  Map<String, dynamic> toJson() => {
        "category": category,
        "amount": amount,
        "date": date.toIso8601String(),
      };

  ExpenseItem.fromJson(Map<String, dynamic> json)
      : category = json["category"],
        amount = json['amount'],
        date = DateTime.parse(json['date']);
}
