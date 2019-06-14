// import 'package:papyrus_client/data_models/UserExpense.dart';
// // import 'package:papyrus_client/data_models/UserExpense.dart';

// class UserExpenseHelper {
//   UserExpense userExpense;
//   List<ExpenseItem> yearly_expense;
//   List<ExpenseItem> monthly_expense;
//   List<ExpenseItem> daily_expense;

//   UserExpenseHelper() {}

//   List<ExpenseItem> getExpensesGivenCategory(
//       List<ExpenseItem> expenses, Category category) {
//     return expenses.where((f) => f.category == category).toList();
//   }

// // get based on time period and given date

//   void addExpense(ExpenseItem expense) {
//     userExpense.addExpense(expense);
//   }

//   void addExpenseFromRawData(Category category, double amount, DateTime date) {
//     ExpenseItem expense =
//         ExpenseItem(category: category, amount: amount, date: date);
//     userExpense.addExpense(expense);
//   }

//   List<ExpenseItem> getExpensesGivenTimePeriod(
//       List<ExpenseItem> expenses, DateTime date, Period period) {
//     if (period == Period.DAILY) {
//       return expenses.where((f) => f.date.day == date.day).toList();
//     }
//     if (period == Period.WEEKLY) {
//       return expenses.where((f) => f.date.year == date.year).toList();
//     }
//     if (period == Period.MONTHLY) {
//       return expenses.where((f) => f.date.month == date.month).toList();
//     }
//   }
// }
