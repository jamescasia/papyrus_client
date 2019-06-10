import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/screens/CameraCaptureScreen.dart';
import 'package:camera/camera.dart';
import 'AppModel.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart'; 
import 'package:flutter/material.dart';

class CameraScreenState {
  List<CameraDescription> cameras;
  CameraController controller;
  bool controllerInitSuccesful = false;
  String wifiSSID;
  String passKey;
}

class CameraCaptureModel extends Model {
  CameraScreenState cameraScreenState;

  AppModel appModel;
  String imagePath;

  CameraCaptureModel(this.appModel) {
    cameraScreenState = CameraScreenState();
  }

  launch() {
    print('launchinner;');

    cameraScreenState = CameraScreenState();

    getController();
  }

  launchQRScan() async {
    print("did you really launch qr scan?");
     startCapturingFrames();
    // String creds = await scanQrCodeWifiCredentials();
    // print("tandanddandan the wifi cred are" + creds);
  }

  capturePhoto() async {
    // imagePath =  "${appModel.rootDir.path}/ReceiptsImages/${DateTime.now().millisecondsSinceEpoch}.png";
    print("take");
    appModel.editReceiptScreenModel.createReceipt();
    try {
      // appModel.editReceiptScreenModel.setCurrentImagePath(imagePath);
      await cameraScreenState.controller
          .takePicture(appModel.editReceiptScreenModel.receipt.imagePath);
      // print(await File(imagePath).readAsString());
      // return true;
    } catch (a) {
      print(a.toString());
      // return false;
    }
  }

  Future<void> connectToWifi() async {
    try {
      print('tryn to connect');

      await appModel.platform.invokeMethod("initializeConnection");
      print('successful');
    } catch (e) {
      print(e);
    }
  }

  Future<CameraController> getController() async {
    CameraDescription cam;
    cameraScreenState.cameras = await availableCameras();
    // cameraScreenState.controller.
    print("the available cameras");
    for (int i = 0; i < cameraScreenState.cameras.length; i++) {
      print(cameraScreenState.cameras[i].lensDirection);

      if (cameraScreenState.cameras[i].lensDirection ==
          CameraLensDirection.back) {
        cam = cameraScreenState.cameras[i];
        break;
      }
    }

    cameraScreenState.controller = CameraController(cam, ResolutionPreset.high);
    globalController = cameraScreenState.controller;
    try {
      await cameraScreenState.controller.initialize();
      cameraScreenState.controllerInitSuccesful = true;

      return cameraScreenState.controller;
    } catch (a) {
      cameraScreenState.controllerInitSuccesful = false;

      return cameraScreenState.controller;
    }
  }

  // Future<String> scanQrCodeWifiCredentials() async {
  //   String creds = await new QRCodeReader()
  //       .setAutoFocusIntervalInMs(200) // default 5000
  //       .setForceAutoFocus(true) // default false
  //       .setTorchEnabled(true) // default false
  //       .setHandlePermissions(true) // default true
  //       .setExecuteAfterPermissionGranted(true) // default true
  //       .scan();

  //   return creds;
  // }
  void stopCapturingFrames(){

    cameraScreenState.controller.stopImageStream();
  }
  void startCapturingFrames() async {
    await cameraScreenState.controller.startImageStream((frame) {

      print("capturing a frame like an idiot!");
      print("The frame details are: " + frame.height.toString() + " " + frame.width.toString() + "Format: " + frame.format.group.toString());
       scanQRCode(frame);
    });
  }

  void scanQRCode(CameraImage availableImage) async {

     final FirebaseVisionImageMetadata metadata =
            FirebaseVisionImageMetadata(
          rawFormat: 35,
          size:  Size(1.0, 1.0),
          planeData: <FirebaseVisionImagePlaneMetadata>[
            FirebaseVisionImagePlaneMetadata(
              bytesPerRow: availableImage.planes[0].bytesPerRow,
              height: availableImage.height,
              width: availableImage.width,
            ),
          ],
        ); 
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromBytes(availableImage.planes[0].bytes, metadata);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();

    List<Barcode> barcodes = await barcodeDetector.detectInImage(visionImage);

    for (Barcode b in barcodes) {
      if (b.displayValue.contains("PapyrusWifi")) {
        print("papyrus wifi found! " + b.displayValue);
        cameraScreenState.controller.stopImageStream();
        break;
      }
    }
  }
}
