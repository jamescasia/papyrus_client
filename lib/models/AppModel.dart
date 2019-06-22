import 'package:scoped_model/scoped_model.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'EditReceiptScreenModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'ChatModel.dart';
import 'CameraCaptureModel.dart';
import 'package:ef_qrcode/ef_qrcode.dart';
import 'package:papyrus_client/data_models/Promo.dart';
import 'ReceiveReceiptModel.dart';
import 'ReceiptsScreenModel.dart';
import 'package:papyrus_client/data_models/Receipt.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:papyrus_client/data_models/UserExpense.dart';
import 'package:papyrus_client/data_models/DayExpense.dart';
import 'package:papyrus_client/data_models/WeekExpense.dart';
import 'package:papyrus_client/data_models/MonthExpense.dart';
import 'package:papyrus_client/data_models/Message.dart';
import 'package:papyrus_client/models/ChartsScreenModel.dart';
import 'package:toast/toast.dart';

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
  ChartsScreenModel chartsScreenModel;

  ReceiptsScreenModel receiptsScreenModel;
  FirebaseUser user;
  Directory rootDir;
  Directory tempDir;
  List<String> dirList;
  File userExpenseJSONFile;
  File userExpensesFile;
  List<Promo> promoList = [];
  File dayExpenseFile;
  File weekExpenseFile;
  File monthExpenseFile;
  File qrCodeFile;
  List<String> receiptRuids = [];
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
  bool imageQrLoaded = false;
  WeekExpense weekExpense;
  MonthExpense monthExpense;
  FirebaseDatabase database;
  DatabaseReference userRef;
  DatabaseReference receiptsRef;
  DatabaseReference promosRef;
  DatabaseReference messagesFromAdminRef;
  DatabaseReference allReceiptsRef;

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
  BuildContext context;

  // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  bool get alsoReceivePromosThruEmail => _alsoReceivePromosThruEmail;
  Period get viewing_period => _viewing_period;
  bool get receiveUniquePromos => _receiveUniquePromos;
  bool get receiveOpenToAllPromos => _receiveOpenToAllPromos;

  AppModel(this.context) {
    // init();
    launch();
  }

  launch() async {
    mAuth = FirebaseAuth.instance;
    editReceiptScreenModel = EditReceiptScreenModel(this);
    cameraCaptureModel = CameraCaptureModel(this);
    receiveReceiptModel = ReceiveReceiptModel(this);
    receiptsScreenModel = ReceiptsScreenModel(this);
    chartsScreenModel = ChartsScreenModel(this);
    chatModel = ChatModel(this);
    // if(await SimplePermissions.platformVersion > SimplePermissions.platformVersion.)

    var version = int.parse(await SimplePermissions.platformVersion);

    if (version >= 23) {
      for (Permission p in perms) {
        perm_results[p] = await SimplePermissions.requestPermission(p);
      }
    }

    user = await mAuth.currentUser();
    // if (user != null)
    init();

    print(
        "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n" +
            user.email);

    //
  }

  listenForReceipts(){
     receiptsRef.onChildAdded.listen((child) {
      print("someoned added receipts");
      String ruid = child.snapshot.key;
      allReceiptsRef.child(ruid).once().then((data) {
        if (!receiptRuids.contains(ruid)) {
          Map map = jsonDecode(data.value);
          var receipt = Receipt.fromJson(map);
          addReceiptandSaveToStorage(receipt);
        }
      });
    });

    receiptsRef.once().then((data) {
      var d = data.value;
      print("the data" + d.toString());

      d.forEach((k, value) {
        var found = false;

        for (FileSystemEntity rFile in receiptFiles) { 

          found = receiptRuids.contains(k.toString());
          if (found) break;
        }

        if (!found) {
          String ruid = k.toString();
          allReceiptsRef.child(ruid).once().then((data) {
            Map map = jsonDecode(data.value);
            var receipt = Receipt.fromJson(map);
            addReceiptandSaveToStorage(receipt);
          });
        }
      });
    });


  }

  listenForPromos(){
    promosRef.once().then((data) {

      
      Map map = jsonDecode(data.value);
      var promo = Promo.fromJson(map);

      Message msg = Message(
          "I've got a promo for you!! 😱🤑🤑\n\n${promo.value * 100}% off of your favourite ${promo.item_name}!!. Click on this message to view the promo",
          DateTime.now().toLocal().toIso8601String(),
          "null",
          promo.retailer_id,
          false);

      addMessage(msg);
    });
  }

  void firebaseInit() {
    print("inited");
    database = FirebaseDatabase.instance;
    userRef = database.reference().child('private/accounts/users/${user.uid}');
    print(user.uid + "could be wrong? no");
    promosRef = userRef.child('promos');
    messagesFromAdminRef = userRef.child('messages');
    allReceiptsRef = database.reference().child('private/receipts');
    receiptsRef = userRef.child("receipts");

    listenForReceipts();

   

    
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
    // if (user == null) return;add
    // try {
    //   platformVersion = await SimplePermissions.platformVersion;
    // } catch (e) {
    //   platformVersion = "failed to get platform version";
    // }

    // print("The permission results" + perm_results.toString());

    rootDir = await getApplicationDocumentsDirectory();
    // var = await getExte
    await checkOrGenerateDirectories();

    // reset();
    // return;

    listFileNamesOfReceiptsFoundInStorageAndGenerateReceipts();
    await prepareExpenseFiles();
    passiveUpdateUserExpense();

    await prepareMessageFile();
    passiveUpdateMessages();

    tempDir = await getTemporaryDirectory();
    generateImage();
    firebaseInit();
  }

  void reset() async {
    await prepareMessageFile();
    deleteAllReceiptFiles();
    deleteAllExpenseFiles();
    deleteMessages();
    userRef.set(null);
    await File(allMessagesFilePath).delete();
    await File(userExpenseJSONFilePath).delete();
    await File(userExpensesFilePath).delete();
    await File(dayExpenseFilePath).delete();
    await File(weekExpenseFilePath).delete();
    await File(monthExpenseFilePath).delete();


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
    String path = '${dirMap['Receipts']}/r_uid${r.time_stamp}.json';
    File file = new File(path);
    file.writeAsString(jsonEncode(r.toJson()));

    receiptRuids.insert(0, "r_uid${r.time_stamp}");

    ExpenseItem e = ExpenseItem(r.category, r.total, r.dateTime);

    // print("made expenseItem" + e.amount.toString());

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
    userExpense = await loadUserExpense();
    notifyListeners();
    print("lastweeks expense" +
        userExpense.lastWeekTotalExpenseAmount.toString());
  }

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
    userExpense.lastDateTotalExpenseAmount += total;
    userExpense.lastMonthTotalExpenseAmount += total;
    userExpense.lastWeekTotalExpenseAmount += total;

    // print(
    //     "TOOOOOOOOOOTALL" + userExpense.totalLifetimeExpenseAmount.toString());
  }

  addDayExpense() async {
    if (dayExpense.dateTime != "") {
      await dayExpenseFile.writeAsString(jsonEncode(dayExpense.toJson()) + "\n",
          mode: FileMode.writeOnlyAppend);
    }

    userExpense.numberOfRecordedDays++;
  }

  addWeekExpense() async {
    if (weekExpense.weekOfMonthNumber != "") {
      await weekExpenseFile.writeAsString(
          jsonEncode(weekExpense.toJson()) + "\n",
          mode: FileMode.writeOnlyAppend);
    }
    userExpense.numberOfRecordedWeeks++;
  }

  addMonthExpense() async {
    if (monthExpense.monthOfYearNumber != "") {
      await monthExpenseFile.writeAsString(
          jsonEncode(monthExpense.toJson()) + "\n",
          mode: FileMode.writeOnlyAppend);
    }

    userExpense.numberOfRecordedMonths++;
  }

  void initializePeriodExpenses() {
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
        userExpense.firstDayWeek,
        userExpense.lastWeekFoodExpenseAmount,
        userExpense.lastWeekMiscellaneousExpenseAmount,
        userExpense.lastWeekTransportationExpenseAmount,
        userExpense.lastWeekLeisureExpenseAmount,
        userExpense.lastWeekUtilitiesExpenseAmount,
        userExpense.lastWeekTotalExpenseAmount);

    monthExpense = MonthExpense(
        userExpense.lastMonthRecorded,
        userExpense.firstDayMonth,
        userExpense.lastMonthFoodExpenseAmount,
        userExpense.lastMonthMiscellaneousExpenseAmount,
        userExpense.lastMonthTransportationExpenseAmount,
        userExpense.lastMonthLeisureExpenseAmount,
        userExpense.lastMonthUtilitiesExpenseAmount,
        userExpense.lastMonthTotalExpenseAmount);

    loadedUserExpense = true;
    notifyListeners();
  }

  // void newPeriodResetUserExpense() async {
  //   var date = DateTime.now().toLocal();

  //   if (userExpense.lastDateRecorded == "" ||
  //       date.day != DateTime.parse(userExpense.lastDateRecorded).day) {
  //     userExpense.resetDateRecords(date);
  //     await addDayExpense();
  //   }
  //   if (userExpense.lastMonthRecorded == "" ||
  //       (userExpense.lastMonthRecorded != date.month.toString())) {
  //     userExpense.resetMonthRecords(date);
  //     userExpense.firstDayMonth = date.toIso8601String();
  //     // finally write the month summary to records appen it
  //     await addMonthExpense();
  //   }
  // }

  bool isItANewDay() {
    // print("check new day mofos" +
    //     DateTime.now().toLocal().day.toString() +
    //     "vs" +
    //     (userExpense.lastDateRecorded));
    if (userExpense.lastDateRecorded == "" ||
        userExpense.lastDateRecorded == null) return true;
    return DateTime.now().toLocal().day !=
        DateTime.parse(userExpense.lastDateRecorded).day;
  }

  bool isItANewWeek() {
    if (userExpense.lastWeekRecorded == "" ||
        userExpense.lastWeekRecorded == null) return true;

    DateTime date = DateTime.now().toLocal();
    DateTime otherDate = (DateTime.parse(userExpense.lastWeekRecorded));
    return DateFormat('MM/dd/yyyy')
            .format(date.subtract(Duration(days: date.weekday - 1))) !=
        DateFormat('MM/dd/yyyy')
            .format(otherDate.subtract(Duration(days: otherDate.weekday - 1)));
  }

  bool isItANewMonth() {
    // print(
    //     "check new mo mofos ${userExpense.lastMonthRecorded} vs    ${DateTime.now().toLocal().month.toString()}");
    if (userExpense.lastMonthRecorded == "" ||
        userExpense.lastMonthRecorded == null) return true;
    return DateTime.now().toLocal().month.toString() !=
        userExpense.lastMonthRecorded;
  }

  // void updateUserExpense() {
  //   var date = DateTime.now().toLocal();

  //   ExpenseAverages.lifetimeAverageDaySpend =
  //       userExpense.totalLifetimeExpenseAmount /
  //           userExpense.numberOfRecordedDays;

  //   ExpenseAverages.lifetimeAverageWeekSpend =
  //       userExpense.totalLifetimeExpenseAmount /
  //           userExpense.numberOfRecordedWeeks;

  //   ExpenseAverages.lifetimeAverageMonthSpend =
  //       userExpense.totalLifetimeExpenseAmount /
  //           userExpense.numberOfRecordedMonths;

  //   notifyListeners();
  // }

  void passiveUpdateUserExpense() {
    initializePeriodExpenses();
    // inits the DayExpense, WeekExpense, MonthExpense, based on userExpense records
    if (isItANewDay()) {
      addDayExpense();
      userExpense.resetDateRecords();
    }
    if (isItANewWeek()) {
      addWeekExpense();
      userExpense.resetWeekRecords();
    }
    if (isItANewMonth()) {
      addMonthExpense();
      userExpense.resetMonthRecords();
    }

    updateDayExpense();
    updateWeekExpense();
    updateMonthExpense();
    ExpenseAverages.lifetimeAverageDaySpend =
        userExpense.totalLifetimeExpenseAmount /
            userExpense.numberOfRecordedDays;

    ExpenseAverages.lifetimeAverageWeekSpend =
        userExpense.totalLifetimeExpenseAmount /
            userExpense.numberOfRecordedWeeks;

    ExpenseAverages.lifetimeAverageMonthSpend =
        userExpense.totalLifetimeExpenseAmount /
            userExpense.numberOfRecordedMonths;

    // if(userExpense.)
    userExpenseJSONFile.writeAsString(jsonEncode(userExpense.toJson()),
        mode: FileMode.write);
    notifyListeners();
  }

  void addToUserExpense(ExpenseItem expenseItem) {
    // basically add shit to userexpense

    if (isItANewDay()) {
      addDayExpense();
      userExpense.resetDateRecords();
    }
    if (isItANewWeek()) {}
    if (isItANewMonth()) {
      addMonthExpense();
      userExpense.resetMonthRecords();
    }

    addToInvolvedExpenses(expenseItem.category, expenseItem.amount);
    updateDayExpense();
    updateWeekExpense();
    updateMonthExpense();
    ExpenseAverages.lifetimeAverageDaySpend =
        userExpense.totalLifetimeExpenseAmount /
            userExpense.numberOfRecordedDays;

    ExpenseAverages.lifetimeAverageWeekSpend =
        userExpense.totalLifetimeExpenseAmount /
            userExpense.numberOfRecordedWeeks;

    ExpenseAverages.lifetimeAverageMonthSpend =
        userExpense.totalLifetimeExpenseAmount /
            userExpense.numberOfRecordedMonths;
    userExpenseJSONFile.writeAsString(jsonEncode(userExpense.toJson()),
        mode: FileMode.write);
    // userExpenseJSONFile.writeAsString()
    notifyListeners();

    // updateUserExpense();
  }

  void updateDayExpense() {
    // dayExpense.
    dayExpense.dateTime = userExpense.lastDateRecorded;
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
    // weekExpense.dateOfFirstDayOfWeek = userExpense.firstDayWeek;
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
    // monthExpense.dateOfFirstDayOfMonth = userExpense.firstDayMonth;
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

    addToUserExpense(expenseItem);
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

    receiptRuids = receiptFiles.map((f) {
      var tokens = f.path.split("/");
      var rFileName = tokens.last.split(".")[0];
      return rFileName;
    }).toList();

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
    allMessagesFilePath = "${dirMap['Messages']}Messages.json";
    File(allMessagesFilePath).create();
    File(userExpenseJSONFilePath).create();
    File(userExpensesFilePath).create();
    File(dayExpenseFilePath).create();
    File(weekExpenseFilePath).create();
    qrCodeFile = await File("${dirMap['UserData']}${user.uid}.jpg").create();
    await File(monthExpenseFilePath).create();

    // b.delete();
    // c.delete();
    return true;
  }

  void findAllReceipts() async {}

  void generateImage() async {
    try {
      var imageFile = await EfQrcode.generate(user.uid, "#ffffff", "#000000");
      userQRPath = "${dirMap['UserData']}${user.uid}.jpg";

      print("THEEEEEEEDAMMMMMMMMMMMMMMMMMNNTRUUUTHH" + userQRPath);

      await imageFile.copy(userQRPath);
      await qrCodeFile.writeAsBytes(await imageFile.readAsBytes());
      print('done file');
      imageQrLoaded = true;

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<FirebaseUser> registerUser(
      String email, String name, String password) async {
    user = await mAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    //     .then((data) {
    //   user = data;

    // });

    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = name;

    await user.updateProfile(info);

    await user.reload();
    init();
    // } catch (a) {
    //   Toast.show("Failed to register: ${a.toString()}", context,
    //       duration: Toast.LENGTH_SHORT);
    // }

    return user;
  }

  Future<FirebaseUser> login(String email, String password) async {
    // try {
    user = await mAuth.signInWithEmailAndPassword(
        email: email, password: password);
    // } catch (a) {
    //   Toast.show("Failed to log in: ${a.toString()}", context,
    //       duration: Toast.LENGTH_SHORT);
    // }

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
