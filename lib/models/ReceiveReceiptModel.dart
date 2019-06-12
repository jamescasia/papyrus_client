import 'package:scoped_model/scoped_model.dart';
import 'AppModel.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:toast/toast.dart';

class ReceiveReceiptModel extends Model {
  AppModel appModel;
  String ssid;
  String passkey;
  String ip;
  Socket client;
  Socket serverSocket;
  ServerSocket server;
  ReceiveReceiptModel(this.appModel) {}

  socketConnect1() async {
   Socket.connect(ip, 5050)
    .then((Socket sock) {
      client = sock;
      client.listen(dataHandler, 
        onError: errorHandler, 
        onDone: doneHandler, 
        cancelOnError: false);
    })
    .catchError((AsyncError e) {
      print("Unable to connect: $e");
      exit(1);
    });

  //Connect standard in to the socket 
  stdin.listen((data) => 
      client.write(
        new String.fromCharCodes(data).trim() + '\n'));
}


startClient()async{

      client = await Socket.connect('192.168.43.1', 5050);
  client.transform(new IntConverter()).listen((e) => e.forEach(print));
  print('main done');
}
void startServer()async{

   server = await ServerSocket.bind('192.168.43.1', 5050);
  server.listen((Socket socket) {
    serverSocket = socket;
    print('Got connected ${socket.remoteAddress}');

    for (int i = 0; i < 1024; i++) {
      // socket.add(new Uint64List.fromList([i]).buffer.asUint8List());
    }
    // socket.close();
    // print('Closed ${socket.remoteAddress}');
  });


}

void write(){
  serverSocket.add([7,11,69,69,69]);


}
void read(){


}

void dataHandler(data){
  print(new String.fromCharCodes(data).trim());
}

void errorHandler(error, StackTrace trace){
  print(error);
}

void doneHandler(){
  client.destroy();
  exit(0);
}

  launch()async {
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