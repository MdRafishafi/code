import 'package:MyBMTC/helper/http_exception.dart';
import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/providers/Auth.dart';
import 'package:MyBMTC/screens/busBetweenStops.dart';
import 'package:MyBMTC/screens/feedbackScreen.dart';
import 'package:MyBMTC/screens/mapScreen.dart';
import 'package:MyBMTC/screens/searchRouteNumber.dart';
import 'package:MyBMTC/widgets/customDrawer.dart';
import 'package:MyBMTC/widgets/dashboardContainer.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

import 'homeScreen.dart';

class DashboardScreen extends StatefulWidget {
  static final route = 'DashboardScreen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FSBStatus drawerStatus;
  bool _isFirstTime = true;

  initialMethod() async {
    try {
      await Provider.of<Auth>(context, listen: false).isUserInDatabase();
      _isFirstTime = false;
    } on HttpException catch (error) {
      Message.showErrorDialog(
        message: error.toString(),
        context: context,
      );
      Provider.of<Auth>(context, listen: false).logout();
      _isFirstTime = false;
      Navigator.of(context).pushNamedAndRemoveUntil(
        HomeScreen.route,
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      debugPrint(e.toString());
      Message.showErrorDialog(
        message: "Something went wrong",
        icon: true,
        context: context,
      );

    }
  }

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      initialMethod();

    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SwipeDetector(
      onSwipeLeft: () {
        setState(() {
          drawerStatus = FSBStatus.FSB_CLOSE;
        });
      },
      onSwipeRight: () {
        setState(() {
          drawerStatus = FSBStatus.FSB_OPEN;
        });
      },
      child: FoldableSidebarBuilder(
        status: drawerStatus,
        drawer: CustomDrawer(),
        screenContents: dashboardScreenBody(height, width),
        drawerBackgroundColor: Colors.white,
      ),
    );
  }

  Widget dashboardScreenBody(double height, double width) {
    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              drawerStatus == FSBStatus.FSB_OPEN
                  ? Icons.close
                  : Icons.sort_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }),
        title: Text(
          'Dashboard',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: DashboardContainer(
                      route: MapScreen.route,
                      imageUrl: "assets/images/busnearme.png",
                      title: 'Search For Bus Stops Near Me!',
                    ),
                  ),
                  Expanded(
                    child: DashboardContainer(
                      route: BusBetweenStops.route,
                      imageUrl: 'assets/images/busbtwn.png',
                      title: 'Search bus route b/w two bus stations',
                    ),
                  ),
                ]),
            Row(
              children: [
                Expanded(
                  child: DashboardContainer(
                    route: SearchRouteNumber.route,
                    imageUrl: 'assets/images/vehicleservice.png',
                    title: 'Route b/w bus stop using route number',
                  ),
                ),
                Expanded(
                  child: DashboardContainer(
                    route: FeedbackScreen.route,
                    imageUrl: 'assets/images/customerfeedback.png',
                    title: 'Please Give Your Valuable Feedback',
                  ),
                ),
              ],
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         padding: EdgeInsets.all(20.0),
            //         margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            //         decoration: BoxDecoration(
            //           color: Color(0xff1AFFD5),
            //           borderRadius: BorderRadius.only(
            //             bottomLeft: Radius.circular(35),
            //             bottomRight: Radius.circular(35),
            //             topLeft: Radius.circular(35),
            //             topRight: Radius.circular(35),
            //           ),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black45,
            //               blurRadius: 2.0,
            //               spreadRadius: 0.0,
            //               offset: Offset(
            //                   0.0, 0.5), // shadow direction: bottom right
            //             )
            //           ],
            //         ),
            //         child: Text(
            //           'BOOK A TICKET',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold,
            //             color: Color(0xff363450),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
