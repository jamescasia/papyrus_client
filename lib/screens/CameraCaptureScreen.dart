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
  cs.cameras = await availableCameras();
  cs.controller = CameraController(
      cs.cameras[cs.cameras.length - 1], ResolutionPreset.medium);
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
                        return FutureBuilder(
                            future: getController(cs, this),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                ccModel.setCameraScreenState(cs);

                                return (cs.controllerInitSuccesful)
                                    ? AspectRatio(
                                        aspectRatio:
                                            snapshot.data.value.aspectRatio,
                                        child: Stack(
                                          children: <Widget>[
                                            CameraPreview(snapshot.data),
                                            Positioned(
                                              left: sizeMul * 1,
                                              top: sizeMul * 24,
                                              child: Material(
                                                color:
                                                    Colors.white.withAlpha(0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.white.withAlpha(0),
                                                  highlightColor: Colors.black
                                                      .withOpacity(0.1),
                                                  // ,
                                                  onTap: () {
                                                    // editReceiptScreenModel = EditReceiptScreenModel();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: sizeMul * 40,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                10 * sizeMul),
                                                    // height: sizeMul*40,
                                                    // color: Colors.red,
                                                    child: Image.asset(
                                                      'assets/icons/3x/back.png',
                                                      height:
                                                          MediaQuery.of(context)
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
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: sizeMul * 60,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                child: RaisedButton(
                                                  onPressed: () {
                                                    // cs.controller.
                                                    ccModel
                                                        .capturePhoto()
                                                        .then((_) {
                                                      cs.controller.dispose();
                                                      Navigator.pushReplacement(
                                                          context,
                                                          CupertinoPageRoute(
                                                              builder: (context) =>
                                                                  EditReceiptScreen(
                                                                      appModel
                                                                          .editReceiptScreenModel)));
                                                      // }
                                                    });
                                                  },
                                                  shape: CircleBorder(),
                                                ),
                                              ),
                                            )
                                          ],
                                        ))
                                    : Center(
                                        child: Text(
                                          "Getting camera failed. Did you reject permission?",
                                          style: TextStyle(
                                              fontSize: sizeMul * 19,
                                              color: Colors.black),
                                        ),
                                      );
                              } else
                                return Center(
                                    child: CircularProgressIndicator());
                            });
                      }));
            }),
      ),
    );
  }
}
