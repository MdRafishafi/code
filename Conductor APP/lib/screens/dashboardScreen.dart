import 'dart:math' show cos, sqrt, asin;

import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
// import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../providers/Auth.dart';
import '../providers/busDetails.dart';
import '../screens/allTickets.dart';
import '../screens/bookNewTicket.dart';
import '../screens/takePictureScreen.dart';
import '../widgets/bottomSheet.dart';
import '../widgets/customDrawer.dart';
import '../widgets/dashboardContainer.dart';
import 'homeScreen.dart';

class DashboardScreen extends StatefulWidget {
  static final route = 'DashboardScreen';
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  FSBStatus drawerStatus;
  bool _isFirstTime = true;
  var _isLoading = false;
  bool change = false;
  // Location _location = Location();
  // LocationData locationData;

  initialMethod() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = await Provider.of<Auth>(context, listen: false);
      auth.isUserInDatabase();
      final busDetailsData =
          Provider.of<BusDetailsProvider>(context, listen: false);
      if (busDetailsData.routeNoDetails == null)
        await busDetailsData.routeNumber(busDetailsData.busRouteId);
      _isFirstTime = false;
      // locationData = await _location.getLocation();
      // await busDetailsData.liveLocation(
      //   conductorId: auth.userId,
      //   lat: locationData.latitude,
      //   lon: locationData.longitude,
      // );
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
      print(e.toString());
      Message.showErrorDialog(
        message: "Something went wrong",
        icon: true,
        context: context,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      initialMethod();
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
    // final auth = Provider.of<Auth>(context, listen: false);
    // final busDetailsData =
    //     Provider.of<BusDetailsProvider>(context, listen: false);
    // _location.onLocationChanged.listen((loc) async {
    //   await busDetailsData.liveLocation(
    //     conductorId: auth.userId,
    //     lat: loc.latitude,
    //     lon: loc.longitude,
    //   );
    // });
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DashboardContainer(
                            route: TakePictureScreen.route,
                            imageUrl: "assets/images/face_scan.png",
                            title: 'Customer Verification By FACEID',
                          ),
                        ),
                        Expanded(
                          child: DashboardContainer(
                            route: AllTickets.route,
                            imageUrl: 'assets/images/ticket.png',
                            title: 'Show Booked Ticket List',
                          ),
                        ),
                      ]),
                  Row(
                    children: [
                      Expanded(
                        child: DashboardContainer(
                          route: BookNewTicket.route,
                          imageUrl: 'assets/images/book_now.png',
                          title: 'Book New Ticket For Customer',
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
      floatingActionButton: _isLoading
          ? Container()
          : FloatingActionButton(
              onPressed: _showBottomSheet,
              child: Icon(
                Icons.location_history,
                color: Colors.white,
                size: 42,
              ),
            ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              CustomizedBottomSheet(),
            ],
          );
        });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
