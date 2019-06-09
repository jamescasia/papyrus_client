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

  CameraCaptureModel(this.appModel){
    cameraScreenState = CameraScreenState();

  }

  launch(){

    print('launchinner;');

    cameraScreenState = CameraScreenState();
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

    if (cameraScreenState.cameras[i].lensDirection == CameraLensDirection.back) {
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

  // void setCameraScreenState(CameraScreenState cs) {
  //   cameraScreenState = cs;
  //   print("set the camera controller: " +
  //       cameraScreenState.controllerInitSuccesful.toString());
  // }


  // void _scanText(CameraImage availableImage) async {
  //   Image image
  //   final FirebaseVisionImage visionImage =
  //       FirebaseVisionImage.fromBytes(availableImage.planes[0].bytes, null);

  //   final TextRecognizer textRecognizer =
  //       FirebaseVision.instance.textRecognizer();
  //   final VisionText visionText =
  //       await textRecognizer.processImage(visionImage);

  //   print(visionText.text);
  //   for (TextBlock block in visionText.blocks) {
  //     // final Rectangle<int> boundingBox = block.boundingBox;
  //     // final List<Point<int>> cornerPoints = block.cornerPoints;
  //     print(block.text);
  //     final List<RecognizedLanguage> languages = block.recognizedLanguages;

  //     for (TextLine line in block.lines) {
  //       // Same getters as TextBlock
  //       print(line.text);
  //       for (TextElement element in line.elements) {
  //         // Same getters as TextBlock
  //         print(element.text);
  //       }
  //     }
  //   }
  // }

  // void scanQRCode(CameraImage availableImage) async {
  //   final FirebaseVisionImage visionImage =
  //       FirebaseVisionImage.fromBytes(availableImage.planes[0].bytes, null);
  //   BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
  //   Vision

  //   // final Vision

  //   // FirebaseVisionImage firebaseVisionImage =   await barcodeDetector.detectInImage(visionImage);

  //   print(visionText.text);
  //   for (TextBlock block in visionText.blocks) {
  //     // final Rectangle<int> boundingBox = block.boundingBox;
  //     // final List<Point<int>> cornerPoints = block.cornerPoints;
  //     print(block.text);
  //     final List<RecognizedLanguage> languages = block.recognizedLanguages;

  //     for (TextLine line in block.lines) {
  //       // Same getters as TextBlock
  //       print(line.text);
  //       for (TextElement element in line.elements) {
  //         // Same getters as TextBlock
  //         print(element.text);
  //       }
  //     }
  //   }
  // }
}
