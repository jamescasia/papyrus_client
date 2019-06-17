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

  init() {}
  AllMessages allMessages;

  sendMessage() {
    if (cont.text == "") return;
    var msg = Message(cont.text, DateTime.now().toLocal().toIso8601String(), "",
        "user", true);
    appModel.addMessage(msg);
    cont.clear();

    scont.animateTo(scont.position.maxScrollExtent, duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
  }
}
