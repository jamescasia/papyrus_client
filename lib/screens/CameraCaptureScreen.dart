import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'HomeScreen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/CameraCaptureModel.dart';
import 'package:flutter/cupertino.dart';
import 'EditReceiptScreen.dart';
import 'package:papyrus_client/models/AppModel.dart';

class CameraScreenState {
  List<CameraDescription> cameras;
  CameraController controller;
  bool controllerInitSuccesful = false;
}

class CameraCaptureScreen extends StatefulWidget {
  @override
  _CameraCaptureScreenState createState() => _CameraCaptureScreenState();
}

Future<CameraController> getController(
    CameraScreenState cs, _CameraCaptureScreenState c) async {
  CameraDescription cam;
  cs.cameras = await availableCameras();
  print("the available cameras");
  for (int i = 0; i < cs.cameras.length; i++) {
    print(cs.cameras[i].lensDirection);

    if (cs.cameras[i].lensDirection == CameraLensDirection.back) {
      cam = cs.cameras[i];
      break;
    }
  }

  cs.controller = CameraController(cam, ResolutionPreset.high);
  try {
    await cs.controller.initialize();
    cs.controllerInitSuccesful = true;

    // c.setState(() {});
    return cs.controller;
  } catch (a) {
    cs.controllerInitSuccesful = false;

    // c.setState(() {});
    return cs.controller;
  }
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  CameraScreenState cs = CameraScreenState();
  // CameraController controller;

  @override
  void initState() {
    super.initState();
    // initializeCameras(cs, this);
  }

  @override
  void dispose() {
    cs.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (!cs.controller.value.isInitialized) {
    //   return Container(width: MediaQuery.of(context).size.width,height: 1,);
    // }
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ScopedModelDescendant<AppModel>(
            rebuildOnChange: false,
            builder: (context, child, appModel) {
              return ScopedModel<CameraCaptureModel>(
                  // stream: null,

                  model: appModel.cameraCaptureModel,
                  child: ScopedModelDescendant<CameraCaptureModel>(
                      // stream: null,
                      rebuildOnChange: false,
                      builder: (context, child, ccModel) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            // aspectRatio:
                            //     snapshot.data.value.aspectRatio,
                            child: Stack(
                              children: <Widget>[
                                FutureBuilder(
                                    future: getController(cs, this),
                                    builder: (context, snapshot) {
                                      ccModel.setCameraScreenState(cs);
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return (cs.controllerInitSuccesful)
                                            ? CameraPreview(snapshot.data)
                                            : Center(
                                                child: Text(
                                                "Camera cannot be accessed.\nDid you accept permissions?",
                                                style: TextStyle(
                                                  fontSize: sizeMul * 23,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ));
                                      } else if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.waiting)
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                    }),
                                Positioned(
                                  left: 2,
                                  top: 24,
                                  child: Material(
                                    color: Colors.white.withAlpha(0),
                                    child: InkWell(
                                      splashColor: Colors.white.withAlpha(0),
                                      highlightColor:
                                          Colors.black.withOpacity(0.1),
                                      // ,
                                      onTap: () {
                                        // editReceiptScreenModel = EditReceiptScreenModel();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: sizeMul * 40,
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10 * sizeMul),
                                        // height: sizeMul*40,
                                        // color: Colors.red,
                                        child: Image.asset(
                                          'assets/icons/3x/back.png',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.075,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: sizeMul * 60,
                                    color: Colors.black.withOpacity(0.3),
                                    child: RaisedButton(
                                      onPressed: () {
                                        // cs.controller.
                                        ccModel.capturePhoto().then((_) {
                                          cs.controller.dispose();
                                          Navigator.pushReplacement(context,
                                              CupertinoPageRoute(
                                                  builder: (context) {
                                            return EditReceiptScreen(appModel
                                                .editReceiptScreenModel);
                                          }));
                                          // }
                                        });
                                      },
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                )
                              ],
                            ));
                      }));
            }),
      ),
    );
  }
}

// FutureBuilder(
//                             future: getController(cs, this),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.done) {
//                                 ccModel.setCameraScreenState(cs);

//                                 return (cs.controllerInitSuccesful)
//                                     ?
