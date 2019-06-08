import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/screens/CameraCaptureScreen.dart';
import 'package:camera/camera.dart';
import 'AppModel.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';

class CameraCaptureModel extends Model {
  CameraScreenState cameraScreenState;
  AppModel appModel;
  String imagePath;

  CameraCaptureModel(this.appModel);

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

  void setCameraScreenState(CameraScreenState cs) {
    cameraScreenState = cs;
    print("set the camera controller: " +
        cameraScreenState.controllerInitSuccesful.toString());
  }


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
