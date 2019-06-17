import 'package:scoped_model/scoped_model.dart';

import 'AppModel.dart';
import 'package:flutter/material.dart';
import 'package:papyrus_client/data_models/Message.dart';

import 'package:papyrus_client/helpers/MessageBox.dart';

class ChatModel extends Model {
  AppModel appModel;
  TextEditingController cont = TextEditingController();
  ScrollController scont = ScrollController();
  ChatModel(this.appModel);

  List<String> greetings;

  List<String> choiceMessages = [
    "Tell me what you do.",
    "How is my spending?",
    "Are there any deals I am not aware of?",
    "I have a concern regarding something"
  ];

  init() async {
    greetings = [
      "Hey there ${appModel.user.email.split("@")[0]}! How you doing? I am Paypr, Papyrus's official chatbot 🤖. I like to plant trees!! 🌳 Aside from saving the earth and making retailers more competitive by providing digital receipts,  " +
          "I am also tasked to:\n1. Informing you on GREAT EXCLUSIVE DEALS from partner stores tailored to your liking 🤑\n2. Assist and alert you on your spending and expense tracking ⚠ and\n3. Act as a readily available hotline for concerns on our partner stores. 🤙"
    ];

    await Future.delayed(Duration(milliseconds: 50));
    scont.animateTo(scont.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);

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
    scont.animateTo(scont.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
  }

  void replyMessage(String msgText, String imagePath) async {
    var msg = Message(msgText, DateTime.now().toLocal().toIso8601String(),
        imagePath, "paypr", false);
  }

  messageParserAndReplier(String msgText) async {}
}
