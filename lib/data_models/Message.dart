class Message {
  String message = "";
  String dateTime = "";
  String imagePath = "";
  String sender = "";
  bool iAmTheSender = false;

  Message(this.message, this.dateTime, this.imagePath, this.sender,
      this.iAmTheSender);

  Map<String, dynamic> toJson() => {
        "message": message,
        "dateTime": dateTime,
        "imagePath": imagePath,
        "sender": sender,
        "iAmTheSender": iAmTheSender,
      };

  Message.fromJson(Map<String, dynamic> json)
      : message = json["message"],
        dateTime = json['dateTime'],
        imagePath = json['imagePath'],
        iAmTheSender = json['iAmTheSender'],
        sender = json['sender'];
}

class AllMessages {
  List<Message> messages = [];

  AllMessages();

  Map<String, dynamic> toJson() => {
        "messages": messages.map((f) => f.toJson()).toList(),
      };
  factory AllMessages.fromJson(Map<String, dynamic> json) {
    var r = AllMessages();
    var list = json['messages'] as List;
    if (list.length > 0) {
      List<Message> rList = list.map((i) => Message.fromJson(i)).toList();
      r.messages = rList;
    } else
      r.messages = <Message>[];
    // r.items = rList;
    return r;
  }
}
