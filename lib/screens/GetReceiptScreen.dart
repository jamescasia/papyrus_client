import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'CameraCaptureScreen.dart';
import 'ShowQRScreen.dart';
import 'ShowQRTab.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:papyrus_client/models/AppModel.dart';
import 'CameraQRScanTab.dart';
import 'CameraCaptureScreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:papyrus_client/models/CameraCaptureModel.dart';

class GetReceiptScreen extends StatefulWidget {
  CameraCaptureModel ccModel;
  GetReceiptScreen(this.ccModel);
  @override
  _GetReceiptScreenState createState() => new _GetReceiptScreenState(ccModel);
}

class _GetReceiptScreenState extends State<GetReceiptScreen>
    with SingleTickerProviderStateMixin {
  // with TickerProvider;
  CameraCaptureModel ccModel;
  TabController tabController;
  int currIndex = 0;
  _GetReceiptScreenState(this.ccModel);
  @override
  void initState() {
    // TODO: implement initState
    ccModel.launch();
    tabController = TabController(
      length: 3,
      vsync: this,
    );

    tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    setState(() {
      currIndex = tabController.index;
    });
  }

  @override
  void dispose() {
    globalController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
        // stream: null,
        builder: (context, child, appModel) {
      return DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.green,
          bottomNavigationBar: CurvedNavigationBar(
            height: 75,
            animationDuration: Duration(milliseconds: 150),
            index: currIndex,
            onTap: (index) {
              currIndex = index;
              tabController.index = currIndex;
              setState(() {});
            },
            backgroundColor: Colors.green,
            // color: Colors.white,
            items: [
              Padding(
                padding: EdgeInsets.all(sizeMulW * 4),
                child: Center(
                  child: Icon(
                    Icons.tap_and_play,
                    color: Colors.green,
                    size: sizeMulW * 40,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(sizeMulW * 4),
                child: Icon(
                  FontAwesomeIcons.expand,
                  // Icons.crop_free,
                  color: Colors.green,
                  size: sizeMulW * 35,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(sizeMulW * 4),
                child: Icon(
                  Icons.cloud_download,
                  color: Colors.green,
                  size: sizeMulW * 40,
                ),
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 75,
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    CameraQRScanTab(ccModel),
                    CameraCaptureScreen(),
                    ShowQRTab(),
                  ],
                ),
              ),
              Positioned(
                              left: 0,
                              top: 24,
                              child: Container(
                                width: sizeMulW*60,
                                child: RaisedButton(
                                  
                                  highlightElevation: 0,
                                  color: Colors.white.withOpacity(0),
                                  elevation: 0,
                                  splashColor: Colors.white.withAlpha(0),
                                  highlightColor: Colors.black.withOpacity(0), 
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    // width: sizeMulW * 50,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10 * sizeMulW),
                                    // height: sizeMulW*40,
                                    // color: Colors.red,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/icons/3x/back.png',
                                          height:
                                              MediaQuery.of(context).size.width *
                                                  0.075,
                                        ),
                                        
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
            ],
          ),
        ),
      );
    });
  }
}
