import 'package:scoped_model/scoped_model.dart';
import 'AppModel.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class ReceiveReceiptModel extends Model {
  AppModel appModel;
  String ssid;
  String passkey;
  BuildContext context;
  String ip;
  bool done = false;
  Socket client;
  Socket serverSocket;
  ServerSocket server;
  String state;

  String newImage;
  ReceiveReceiptModel(this.appModel) {}

//   socketConnect1() async {
//    Socket.connect(ip, 5050)
//     .then((Socket sock) {
//       client = sock;
//       client.listen(dataHandler,
//         onError: errorHandler,
//         onDone: doneHandler,
//         cancelOnError: false);
//     })
//     .catchError((AsyncError e) {
//       print("Unable to connect: $e");
//       exit(1);
//     });

//   //Connect standard in to the socket
//   stdin.listen((data) =>
//       client.write(
//         new String.fromCharCodes(data).trim() + '\n'));
// }

  startClient() async {
    File file = new File("${appModel.tempDir.path}/999.png");
    Toast.show("Starting client", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    client = await Socket.connect('192.168.43.1', 5050);

    client.listen((e) {
      // client.write("hey there");

      Toast.show(" ${String.fromCharCodes(e)}", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      file.writeAsBytes(e).then((b) {
        done = true;
        newImage = b.path;
        notifyListeners();
        Toast.show("Finished file from ${b.path}", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });

      // Toast.show(String.fromCharCodes(e), context,
      //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    });
    // client.transform(new IntConverter()).listen((e) {
    //   // Toast.show(String.fromCharCodes(e), context,
    //   //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    //   return e.forEach(print);
    // });
    print('main done');
  }

  void sendFile() async {
    File file = File(await FilePicker.getFilePath(type: FileType.IMAGE));

    if (state == "server") {
      serverSocket.add(await file.readAsBytes());
      // serverSocket.write(file.readAsBytes());
    }

    if (state == "client") {
      // client.write(file.readAsBytes());
      client.add(await file.readAsBytes());
    }
  }

  void startServer() async {
    var path = await getExternalStorageDirectory();
    File file = new File("${appModel.tempDir.path}/Papyrus/999.png");

    Toast.show("Starting server", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    server = await ServerSocket.bind('192.168.43.1', 5050);
    await server.listen((Socket socket) {
      serverSocket = socket;
      print('Got connected ${socket.remoteAddress}');

      Toast.show("someone connected ${socket.remoteAddress}", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

      // for (int i = 0; i < 1024; i++) {
      //   // serverSocket.add
      //   // socket.add(new Uint64List.fromList([i]).buffer.asUint8List()  );
      // }
      // // socket.close();
      // print('Closed ${socket.remoteAddress}');

      serverSocket.listen((a) {
        Toast.show(" ${String.fromCharCodes(a)}", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        file.writeAsBytes(a).then((b) {
          Toast.show("Finished file from ${file.path}", context,
              duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        });
      });
    });

    serverSocket.listen((a) {
      Toast.show(" ${String.fromCharCodes(a)}", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      file.writeAsBytes(a).then((b) {
        Toast.show("Finished file from ${file.path}", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      });
    });
  }

  void showToast() {
    Toast.show("Toast plugin app", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  void write(String s) {
    if (state == "server") {
      serverSocket.write(s);
    }

    if (state == "client") {
      client.write(s);
    }

    // Toast.show("printing", context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    // serverSocket.add([7, 11, 69, 69, 69]);
  }

  void read() {}

  void dataHandler(data) {
    print(new String.fromCharCodes(data).trim());
  }

  void errorHandler(error, StackTrace trace) {
    print(error);
  }

  void doneHandler() {
    client.destroy();
    exit(0);
  }

  launch() async {
    Toast.show("Toast plugin app", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    ssid = appModel.cameraCaptureModel.ssid;
    passkey = appModel.cameraCaptureModel.passkey;
    ip = appModel.cameraCaptureModel.ip;

    //  if(await connectToWifi())
    //     socketConnect2();
    //   else connectToWifi();
  }

  Future<bool> connectToWifi() async {
    try {
      print("WIFI creds be like " + ssid + passkey);
      print('tryn to connect');

      var creds = <String, String>{
        "ssid": ssid,
        "passkey": passkey,
      };

      bool result =
          await appModel.platform.invokeMethod("initializeConnection", creds);
      print('successful');
      return result;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

class IntConverter extends Converter<List<int>, List<int>> {
  const IntConverter();

  List<int> convert(List<int> data) {
    if (data is Uint8List) {
      return data.buffer.asInt64List();
    } else {
      return new Uint64List.fromList(data).buffer.asUint8List();
    }
  }

  IntSink startChunkedConversion(sink) {
    return new IntSink(sink);
  }
}

class IntSink extends ChunkedConversionSink<List<int>> {
  final _converter;
  // fales when this type is used
  // final ChunkedConversionSink<List<int>> _outSink;
  final _outSink;

  IntSink(this._outSink) : _converter = new IntConverter();

  void add(List<int> data) {
    _outSink.add(_converter.convert(data));
  }

  void close() {
    _outSink.close();
  }
}
