import 'package:scoped_model/scoped_model.dart';
import 'AppModel.dart';
import 'dart:async';

class ReceiveReceiptModel extends Model {



  AppModel appModel;
  String ssid; 
  String passkey;
  String ip ;
  ReceiveReceiptModel(this.appModel){





  }

  launch(){
    ssid= appModel.cameraCaptureModel.ssid;
    passkey = appModel.cameraCaptureModel.passkey;
    ip =  appModel.cameraCaptureModel.ip;

    connectToWifi( );


  }

   Future<void> connectToWifi( ) async {
    try {
      print("WIFI creds be like " + ssid + passkey);
      print('tryn to connect');

      var creds = <String, String>{
        "ssid": ssid,
        "passkey": passkey,
      };

     bool result =  await appModel.platform.invokeMethod("initializeConnection", creds);
      print('successful');
    } catch (e) {
      print(e);
    }
  }

  
}