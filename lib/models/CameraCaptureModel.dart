import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/screens/CameraCaptureScreen.dart';
import 'package:camera/camera.dart';
import 'AppModel.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';

class CameraScreenState {
  List<CameraDescription> cameras;
  CameraController controller;
  bool controllerInitSuccesful = false;
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
  }

  launchQRScan()async {

    print("did you really launch qr scan?");
     startCapturingFrames();
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


  void startCapturingFrames() async {
    await cameraScreenState.controller.startImageStream((frame) {
      print("capturing a frame like an idiot!");
      scanQRCode(frame);
    });
  }

  void scanQRCode(CameraImage availableImage) async {
    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromBytes(availableImage.planes[0].bytes, null);
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
