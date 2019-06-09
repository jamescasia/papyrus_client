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

class GetReceiptScreen extends StatefulWidget {
  @override
  _GetReceiptScreenState createState() => new _GetReceiptScreenState();
}

class _GetReceiptScreenState extends State<GetReceiptScreen>
    with SingleTickerProviderStateMixin {
  // with TickerProvider;
  TabController tabController;
  int currIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
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
                Icon(
                  Icons.access_alarm,
                  color: Colors.green,
                  size: sizeMul * 40,
                ),
                Icon(
                  Icons.battery_alert,
                  color: Colors.green,
                  size: sizeMul * 40,
                ),
                Icon(
                  Icons.outlined_flag,
                  color: Colors.green,
                  size: sizeMul * 40,
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
                      CameraQRScanTab(),
                      CameraCaptureScreen(),
                      ShowQRTab(),
                    ],
                  ),
                ),
                Positioned(
                  left: 2,
                  top: 24,
                  child: InkWell(
                    splashColor: Colors.white.withAlpha(0),
                    highlightColor: Colors.black.withOpacity(0.1),
                    // ,
                    onTap: () {

                      globalController.dispose();

                      Navigator.pop(context);
                    },
                    child: Container(
                      width: sizeMul * 40,
                      padding: EdgeInsets.symmetric(vertical: 10 * sizeMul),
                      // height: sizeMul*40,
                      // color: Colors.red,
                      child: Image.asset(
                        'assets/icons/3x/back.png',
                        color: Colors.black,
                        height: MediaQuery.of(context).size.width * 0.075,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}
