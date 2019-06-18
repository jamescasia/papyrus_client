import 'package:scoped_model/scoped_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'EditReceiptScreenModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';
import 'ChatModel.dart';
import 'CameraCaptureModel.dart';
import 'package:ef_qrcode/ef_qrcode.dart';
import 'ReceiveReceiptModel.dart';
import 'ReceiptsScreenModel.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'dart:convert';
import 'package:papyrus_client/data_models/UserExpense.dart';
import 'package:papyrus_client/data_models/DayExpense.dart';
import 'package:papyrus_client/data_models/WeekExpense.dart';
import 'package:papyrus_client/data_models/MonthExpense.dart';
import 'package:papyrus_client/data_models/Message.dart';

class AppModel extends Model {
  // User _user;
  MethodChannel platform = const MethodChannel('papyrus_client/');
  Period _viewing_period = Period.DAILY;
  bool _alsoReceivePromosThruEmail;
  bool _receiveUniquePromos;
  bool _receiveOpenToAllPromos;
  FirebaseAuth mAuth;
  String platformVersion;
  // String rootFilePath;
  bool loadedUserExpense = false;
  EditReceiptScreenModel editReceiptScreenModel;
  CameraCaptureModel cameraCaptureModel;
  ReceiveReceiptModel receiveReceiptModel;
  ChatModel chatModel;
  ReceiptsScreenModel receiptsScreenModel;
  FirebaseUser user;
  Directory rootDir;
  Directory tempDir;
  List<String> dirList;
  File userExpenseJSONFile;
  File userExpensesFile;
  File dayExpenseFile;
  File weekExpenseFile;
  File monthExpenseFile;
  String allMessagesFilePath;
  File allMessagesFile;
  AllMessages allMessages;
  String dayExpenseFilePath;
  String weekExpenseFilePath;
  String monthExpenseFilePath;
  String userExpensesFilePath;
  UserExpense userExpense;
  bool receiptsLoaded = false;
  bool loadedMessages = false;
  String userExpenseJSONFilePath;
  DayExpense dayExpense;
  WeekExpense weekExpense;
  MonthExpense monthExpense;
  // bool loaded

  List<FileSystemEntity> receiptFiles;
  Map<String, String> dirMap = {
    "Receipts": "null",
    "ReceiptsImages": "null",
    "UserData": "null",
    "Expenses": "null",
    "Expenses/Period": "null",
    "Messages": "null"
  };
  String userQRPath;
  List<Permission> perms = [
    Permission.AccessCoarseLocation,
    Permission.AccessFineLocation,
    Permission.Camera,
    Permission.ReadExternalStorage,
    Permission.WriteExternalStorage
  ];
  Map<Permission, PermissionStatus> perm_results =
      new Map<Permission, PermissionStatus>();
  // BuildContext context;

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  bool get alsoReceivePromosThruEmail => _alsoReceivePromosThruEmail;
  Period get viewing_period => _viewing_period;
  bool get receiveUniquePromos => _receiveUniquePromos;
  bool get receiveOpenToAllPromos => _receiveOpenToAllPromos;

  AppModel() {
    launch();
  }

  launch() async {
    mAuth = FirebaseAuth.instance;
    editReceiptScreenModel = EditReceiptScreenModel(this);
    cameraCaptureModel = CameraCaptureModel(this);
    receiveReceiptModel = ReceiveReceiptModel(this);
    receiptsScreenModel = ReceiptsScreenModel(this);
    chatModel = ChatModel(this);

    for (Permission p in perms) {
      // perm_results.addEntries(p:null);
      perm_results[p] = await SimplePermissions.requestPermission(p);
    }
    user = await mAuth.currentUser();

    if (user != null) init();
  }

  void init() async {
    // for (Permission p in perms) {
    //   // perm_results.addEntries(p:null);
    //   perm_results[p] = await SimplePermissions.requestPermission(p);
    // }
    // editReceiptScreenModel = EditReceiptScreenModel(this);
    // cameraCaptureModel = CameraCaptureModel(this);
    // receiveReceiptModel = ReceiveReceiptModel(this);
    // receiptsScreenModel = ReceiptsScreenModel(this);
    // if (user == null) return;
    // try {
    //   platformVersion = await SimplePermissions.platformVersion;
    // } catch (e) {
    //   platformVersion = "failed to get platform version";
    // }

    // print("The permission results" + perm_results.toString());

    rootDir = await getApplicationDocumentsDirectory();
    // var = await getExte
    await checkOrGenerateDirectories();

    //  reset();
    //  return;

  

    listFileNamesOfReceiptsFoundInStorageAndGenerateReceipts();
    await prepareExpenseFiles();
    passiveUpdateUserExpense();

    await prepareMessageFile();
    passiveUpdateMessages();

    tempDir = await getTemporaryDirectory();
    generateImage();
  }

  void reset()async {
     await prepareMessageFile();
       deleteAllReceiptFiles();
      deleteAllExpenseFiles();
      deleteMessages();

  }

  void deleteAllExpenseFiles() async {
    List<FileSystemEntity> files;
    print("here are the files");
    files = Directory(dirMap['Expenses'])
        .listSync(recursive: true, followLinks: false);
    for (int i = 0; i < files.length; i++) {
      File rJSON = File(files[i].path);
      try {
        await rJSON.delete();
      } catch (e) {}
      print('ouyst');
    }
  }

  void deleteAllReceiptFiles() async {
    List<FileSystemEntity> files;
    print("here are the files");
    files = Directory(dirMap['Receipts'])
        .listSync(recursive: true, followLinks: false);

    for (int i = 0; i < files.length; i++) {
      File rJSON = File(files[i].path);
      try {
        await rJSON.delete();
      } catch (e) {}

      print('ouyst');
    }
  }
/**
 * Process
 * 
 * 
 * 
 * 
 */

// void saveReceiptToJsonAndToFile() {
//     print("locals" + appModel.rootDir.path);
//     print("saving");

//     File file = new File(
//         '${appModel.dirMap['Receipts']}/${_receipt.time_stamp}.json');
//     file.writeAsString(jsonEncode(_receipt.toJson()));

//     readReceiptFromJsonFile(file.path);
//   }

  loadMessageJson() async {
    try {
      Map map = jsonDecode(await allMessagesFile.readAsString());
      return AllMessages.fromJson(map);
    } catch (e) {
      return AllMessages();
    }
  }

  loadUserExpense() async {
    try {
      Map map = jsonDecode(await userExpenseJSONFile.readAsString());
      return UserExpense.fromJson(map);
    } catch (e) {
      return UserExpense();
    }
  }

  fromStringToEnumCategory(String cat) {
// enum Category { LEISURE, FOOD, TRANSPORTATION, MISCELLANEOUS, UTILITIES }
    if (cat == "LEISURE") return Category.LEISURE;
    if (cat == "FOOD") return Category.FOOD;
    if (cat == "TRANSPORTATION") return Category.TRANSPORTATION;
    if (cat == "MISCELLANEOUS") return Category.MISCELLANEOUS;
    if (cat == "UTILITIES") return Category.UTILITIES;
  }

  void addReceiptandSaveToStorage(Receipt r) {
    String path = '${dirMap['Receipts']}/${r.time_stamp}.json';
    File file = new File(path);
    file.writeAsString(jsonEncode(r.toJson()));

    ExpenseItem e = ExpenseItem(r.category, r.total, r.dateTime);

    print("made expenseItem" + e.amount.toString());

    addExpenseItemToExpenseTxtFile(e);
    // print("The encodedd is tadaa" + jsonEncode(r.toJson()));

    receiptFiles.insert(0, file);
    // _receipts_json_paths.add(path);
    // receipts.insert(0, r);
    // receipts.add(r);

    notifyListeners();
  }

  void addMessage(Message msg) {
    allMessages.messages.insert(0, msg);
    allMessagesFile.writeAsString(jsonEncode(allMessages.toJson()));
    notifyListeners();
  }

  void deleteMessages() {
    allMessages.messages = [];
    allMessagesFile.writeAsString(jsonEncode(allMessages.toJson()));
    List<int> toDelPos = [];

    for (Message msg in allMessages.messages) {
      toDelPos.add(allMessages.messages.indexOf(msg));
    }

    for (int i in toDelPos) {
      allMessages.messages.removeAt(i);
    }
  }

  void passiveUpdateMessages() {
    List<int> toDelPos = [];

    if (allMessages.messages.length > 300) {
      var start = allMessages.messages.length - 300;
      allMessages.messages = allMessages.messages.sublist(start);
    }

    // for (Message msg in allMessages.messages) {
    //   if (DateTime.now().toLocal().day - DateTime.parse(msg.dateTime).day >=
    //       5) {
    //     toDelPos.add(allMessages.messages.indexOf(msg));
    //   }
    // }

    // for (int i in toDelPos) {
    //   allMessages.messages.removeAt(i);
    // }
  }

  prepareMessageFile() async {
    allMessagesFile = File(allMessagesFilePath);

    allMessages = await loadMessageJson();

    loadedMessages = true;
  }

  void prepareExpenseFiles() async {
    userExpenseJSONFile = File(userExpenseJSONFilePath);
    userExpensesFile = File(userExpensesFilePath);
    dayExpenseFile = File(dayExpenseFilePath);
    weekExpenseFile = File(weekExpenseFilePath);
    monthExpenseFile = File(monthExpenseFilePath);
    // try {
    //   Map map = jsonDecode(await userExpenseJSONFile.readAsString());
    //   userExpense = UserExpense.fromJson(map);
    // } catch (e) {}

    // print("READ ALOUD");
    // print("json current" + jsonEncode(userExpense.toJson()));
    // print(userExpensesFile.readAsString());

    userExpense = await loadUserExpense();
    loadedUserExpense = true;

    print("lastweeks expense" +
        userExpense.lastWeekTotalExpenseAmount.toString());

    dayExpense = DayExpense(
        userExpense.lastDateRecorded,
        userExpense.lastDateFoodExpenseAmount,
        userExpense.lastDateMiscellaneousExpenseAmount,
        userExpense.lastDateTransportationExpenseAmount,
        userExpense.lastDateLeisureExpenseAmount,
        userExpense.lastDateUtilitiesExpenseAmount,
        userExpense.lastDateTotalExpenseAmount);

    weekExpense = WeekExpense(
        userExpense.lastWeekRecorded,
        userExpense.lastWeekFoodExpenseAmount,
        userExpense.lastWeekMiscellaneousExpenseAmount,
        userExpense.lastWeekTransportationExpenseAmount,
        userExpense.lastWeekLeisureExpenseAmount,
        userExpense.lastWeekUtilitiesExpenseAmount,
        userExpense.lastWeekTotalExpenseAmount);

    monthExpense = MonthExpense(
        userExpense.lastMonthRecorded,
        userExpense.lastMonthFoodExpenseAmount,
        userExpense.lastMonthMiscellaneousExpenseAmount,
        userExpense.lastMonthTransportationExpenseAmount,
        userExpense.lastMonthLeisureExpenseAmount,
        userExpense.lastMonthUtilitiesExpenseAmount,
        userExpense.lastMonthTotalExpenseAmount);

    userExpenseInit();
    // if(userE)
  }

  userExpenseInit() {}

  void addToInvolvedExpenses(String category, double total) {
    if (category == "Food") {
      userExpense.lastDateFoodExpenseAmount += total;
      userExpense.lastWeekFoodExpenseAmount += total;
      userExpense.lastMonthFoodExpenseAmount += total;
      userExpense.foodLifetimeExpenseAmount += total;
    }
    if (category == "Utilities") {
      userExpense.lastDateUtilitiesExpenseAmount += total;
      userExpense.lastWeekUtilitiesExpenseAmount += total;
      userExpense.lastMonthUtilitiesExpenseAmount += total;
      userExpense.necessitiesLifetimeExpenseAmount += total;
    }
    if (category == "Leisure") {
      userExpense.lastDateLeisureExpenseAmount += total;
      userExpense.lastWeekLeisureExpenseAmount += total;
      userExpense.lastMonthLeisureExpenseAmount += total;
      userExpense.leisureLifetimeExpenseAmount += total;
    }
    if (category == "Transportation") {
      userExpense.lastDateTransportationExpenseAmount += total;
      userExpense.lastWeekTransportationExpenseAmount += total;
      userExpense.lastMonthTransportationExpenseAmount += total;
      userExpense.transportationLifetimeExpenseAmount += total;
    }
    if (category == "Miscellaneous") {
      userExpense.lastDateMiscellaneousExpenseAmount += total;
      userExpense.lastWeekMiscellaneousExpenseAmount += total;
      userExpense.lastMonthMiscellaneousExpenseAmount += total;
      userExpense.miscellaneousLifetimeExpenseAmount += total;
    }

    userExpense.totalLifetimeExpenseAmount += total;

    print(
        "TOOOOOOOOOOTALL" + userExpense.totalLifetimeExpenseAmount.toString());
  }

  addDayExpense() async {
    // this shiet only get called when day closed

    await dayExpenseFile.writeAsString(jsonEncode(dayExpense.toJson()) + "\n",
        mode: FileMode.writeOnlyAppend);
  }

  addWeekExpense() async {
    await dayExpenseFile.writeAsString(jsonEncode(weekExpense.toJson()) + "\n",
        mode: FileMode.writeOnlyAppend);
  }

  addMonthExpense() async {
    await dayExpenseFile.writeAsString(jsonEncode(monthExpense.toJson()) + "\n",
        mode: FileMode.writeOnlyAppend);
  }

  void passiveUpdateUserExpense() {
    var date = DateTime.now().toLocal();

    if (userExpense.lastDateRecorded == "" ||
        date.day != DateTime.parse(userExpense.lastDateRecorded).day) {
      userExpense.resetDateRecords();
    }
    if (userExpense.lastMonthRecorded == "" ||
        date.month != DateTime.parse(userExpense.lastDateRecorded).month) {
      userExpense.resetMonthRecords();
    }
  }

  void updateUserExpense(ExpenseItem expenseItem) {
    var date = DateTime.now().toLocal();

    if (userExpense.lastDateRecorded == "" ||
        date.day != DateTime.parse(userExpense.lastDateRecorded).day) {
      addDayExpense();
      userExpense.resetDateRecords();
      // reset to 0
      // add the newly added expense item to category and total

    }
    if (userExpense.lastMonthRecorded == "" ||
        date.month != DateTime.parse(userExpense.lastDateRecorded).month) {
      addMonthExpense();
      userExpense.resetMonthRecords();
      userExpense.firstDayMonth = date.toIso8601String();
    }

    addToInvolvedExpenses(expenseItem.category, expenseItem.amount);
    userExpense.lastDateTotalExpenseAmount += expenseItem.amount;
    userExpense.lastMonthTotalExpenseAmount += expenseItem.amount;
    userExpense.lastWeekTotalExpenseAmount += expenseItem.amount;

    updateDayExpense();
    updateWeekExpense();
    updateMonthExpense();

    userExpense.lastDateRecorded = date.toIso8601String();
    userExpense.lastMonthRecorded = date.month.toString();
    userExpenseJSONFile.writeAsString(jsonEncode(userExpense.toJson()));
    notifyListeners();
  }

  void updateDayExpense() {
    dayExpense.totalSpent = userExpense.lastDateTotalExpenseAmount;
    dayExpense.totalSpentOnFood = userExpense.lastDateFoodExpenseAmount;
    dayExpense.totalSpentOnLeisure = userExpense.lastDateLeisureExpenseAmount;
    dayExpense.totalSpentOnMiscellaneous =
        userExpense.lastDateMiscellaneousExpenseAmount;
    dayExpense.totalSpentOnUtilities =
        userExpense.lastDateUtilitiesExpenseAmount;
    dayExpense.totalSpentOnTransportation =
        userExpense.lastDateTransportationExpenseAmount;
  }

  void updateWeekExpense() {
    weekExpense.totalSpent = userExpense.lastWeekTotalExpenseAmount;
    weekExpense.totalSpentOnFood = userExpense.lastWeekFoodExpenseAmount;
    weekExpense.totalSpentOnLeisure = userExpense.lastWeekLeisureExpenseAmount;
    weekExpense.totalSpentOnMiscellaneous =
        userExpense.lastWeekMiscellaneousExpenseAmount;
    weekExpense.totalSpentOnUtilities =
        userExpense.lastWeekUtilitiesExpenseAmount;
    weekExpense.totalSpentOnTransportation =
        userExpense.lastWeekTransportationExpenseAmount;
  }

  void updateMonthExpense() {
    monthExpense.totalSpent = userExpense.lastMonthTotalExpenseAmount;
    monthExpense.totalSpentOnFood = userExpense.lastMonthFoodExpenseAmount;
    monthExpense.totalSpentOnLeisure =
        userExpense.lastMonthLeisureExpenseAmount;
    monthExpense.totalSpentOnMiscellaneous =
        userExpense.lastMonthMiscellaneousExpenseAmount;
    monthExpense.totalSpentOnUtilities =
        userExpense.lastMonthUtilitiesExpenseAmount;
    monthExpense.totalSpentOnTransportation =
        userExpense.lastMonthTransportationExpenseAmount;
  }

  void addExpenseItemToExpenseTxtFile(ExpenseItem expenseItem) async {
    await userExpensesFile.writeAsString(
        jsonEncode(expenseItem.toJson()) + "\n",
        mode: FileMode.writeOnlyAppend);

    updateUserExpense(expenseItem);
    notifyListeners();
  }

  // void addExpenseAndSaveToStorage(String path){
  //   File file = new File(path);
  //   file.writeAsString(jsonEncode(object))
  // }

  void listFileNamesOfReceiptsFoundInStorageAndGenerateReceipts() {
    print("here are the files");
    receiptFiles = Directory(dirMap['Receipts'])
        .listSync(recursive: true, followLinks: false);

    receiptFiles = receiptFiles.reversed.toList();

    receiptsLoaded = true;
    notifyListeners();
  }

  //  loadUserExpenses() {

  //    return Direc
  // }

  checkOrGenerateDirectories() async {
    for (String i in dirMap.keys) {
      String path = await Directory("${rootDir.path}/${user.uid}/${i}/")
          .create(recursive: true)
          .then((dir) {
        return dir.path;
      });
      dirMap[i] = path;
    }
    userExpenseJSONFilePath = "${dirMap['Expenses']}Expense.json";
    userExpensesFilePath = "${dirMap['Expenses']}Expense.txt";
    dayExpenseFilePath = "${dirMap['Expenses/Period']}DayExpense.txt";
    weekExpenseFilePath = "${dirMap['Expenses/Period']}WeekExpense.txt";
    monthExpenseFilePath = "${dirMap['Expenses/Period']}MonthExpense.txt";
    allMessagesFilePath = "${dirMap['Messages']}MonthExpense.json";

    await File(allMessagesFilePath).create();
    await File(userExpenseJSONFilePath).create();
    await File(userExpensesFilePath).create();
    await File(dayExpenseFilePath).create();
    await File(weekExpenseFilePath).create();
    await File(monthExpenseFilePath).create();

    // b.delete();
    // c.delete();
    return true;
  }

  void findAllReceipts() async {}

  void generateImage() async {
    if (!await File("${dirMap['UserData']}/${user.email}.jpg").exists()) {
      try {
        var imageFile = await EfQrcode.generate(user.uid, "#ffffff", "#000000");
        userQRPath = "${dirMap['UserData']}/${user.email}.jpg";
        imageFile.copy(userQRPath);
        print('done file');
        // imageFile.pat
        // await imageFile.rename( userQRPath);
        //  file.writeAsBytes(imageFile);

      } catch (e) {
        print(e);
      }
    }
  }

  Future<FirebaseUser> login(String email, String password) async {
    user = await mAuth.signInWithEmailAndPassword(
        email: email, password: password);
    print("The user is ${user.toString()}");
    init();
    return user;
  }

  logOut() {
    mAuth.signOut();
  }

  set receiveUniquePromos(bool value) {
    _receiveUniquePromos = value;
    notifyListeners();
  }

  set receiveOpenToAllPromos(bool value) {
    _receiveOpenToAllPromos = value;
    notifyListeners();
  }

  set alsoReceivePromosThruEmail(bool value) {
    _alsoReceivePromosThruEmail = value;
    notifyListeners();
  }

  set viewing_period(Period period) {
    _viewing_period = period;
    notifyListeners();
  }
}

class User {
  String username;
  String uid;
  FirebaseUser fbUser;
}

class UserPreferences {
  bool receiveUniquePromos;
  bool receiveOpenToAllPromos;

  // String

}
