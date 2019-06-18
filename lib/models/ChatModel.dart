import 'package:scoped_model/scoped_model.dart';

import 'AppModel.dart';
import 'package:flutter/material.dart';
import 'package:papyrus_client/data_models/Message.dart';

import 'package:papyrus_client/helpers/MessageBox.dart';

import 'dart:math';

class ChatModel extends Model {
  AppModel appModel;
  TextEditingController cont = TextEditingController();
  ScrollController scont = ScrollController();
  bool payprIsTyping = false;
  ChatModel(this.appModel);

  // List<String> responseToChoiceMessages;

  List<String> choiceMessages = [
    "Tell me what you do.",
    "How is my spending?",
    "How much more can I spend?"
        "Can i buy this? ...",
    "Are there any deals I am not aware of?",
    "I have a concern regarding something"
  ];

  List<String> responseIfNotSure = ["I'm not sure if I understand..."];

  init() async {
    await Future.delayed(Duration(milliseconds: 50));
    scont.jumpTo(0);
    // scont.animateTo(scont.position.maxScrollExtent,
    //     duration: const Duration(milliseconds: 100), curve: Curves.easeOut);

    // scont.jumpTo(scont.position.maxScrollExtent);
  }

  AllMessages allMessages;

  sendMessage() async {
    if (cont.text == "") return;
    var msg = Message(cont.text, DateTime.now().toLocal().toIso8601String(), "",
        "user", true);
    appModel.addMessage(msg);
    messageParserAndReplier(cont.text);
    cont.clear();

    await Future.delayed(Duration(milliseconds: 40));
    scont.animateTo(0,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  void replyMessage(String msgText, String imagePath) async {
    var msg = Message(msgText, DateTime.now().toLocal().toIso8601String(),
        imagePath, "paypr", false);

    appModel.addMessage(msg);
  }

  // "Tell me what you do.",
  // "How is my spending?",
  // "How much more can I spend?"
  // "Can i buy this? ...",
  // "Are there any deals I am not aware of?",
  // "I have a concern regarding something"

  String choiceMessageResponseWrapper(int type, {double price}) {
    List<String> responseToChoiceMessages = ["You spent ${appModel}"];
  }

  String getSpendingStatus() {
    var date = DateTime.now().toLocal();
    return "You spent ${appModel.userExpense.lastDateTotalExpenseAmount} today. That's ${0}% ${(true) ? "higher" : "lower"} than your lifetime average day spend. You spent on these today";
  }

  messageParserAndReplier(String msgText) async {
    payprIsTyping = true;

    String reply = "";
    if (msgText.toLowerCase() == choiceMessages[0].toLowerCase() ||
        msgText.toLowerCase().contains("yourself") ||
        msgText.toLowerCase().contains("what to do") ||
        msgText.toLowerCase().contains("help")) {
      reply = "Hey there ${appModel.user.email.split("@")[0]}! How you doing? I am Paypr, Papyrus's official chatbot 🤖. I like to plant trees!! 🌳 Aside from saving the earth and making retailers more competitive by providing digital receipts,  " +
          "I am also tasked to:\n1. Informing you on GREAT EXCLUSIVE DEALS from partner stores tailored to your liking 🤑\n2. Assist and alert you on your spending and expense tracking ⚠,and\n3. Act as a readily available hotline for concerns on our partner stores. 📞\n So don't hesitate to message me anytime 🤙😉";

      // reply = responseToChoiceMessages[0];
    }

    if (msgText.toLowerCase() == choiceMessages[1].toLowerCase() ||
        msgText.toLowerCase().contains("spending") ||
        msgText.toLowerCase().contains("expenses")) {
      reply = getSpendingStatus();
      // reply = responseToChoiceMessages[1];
    }

    await Future.delayed(Duration(
        milliseconds: Random().nextInt(1000) + 500 + reply.length * (2)));
    replyMessage(reply, "");
    payprIsTyping = false;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: 40));
    scont.animateTo(0,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
  }
}
