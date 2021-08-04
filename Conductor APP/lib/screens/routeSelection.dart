import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../helper/fontCustomizer.dart';
import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../providers/Auth.dart';
import '../providers/busDetails.dart';
import 'dashboardScreen.dart';

class RouteSelection extends StatefulWidget {
  static final route = 'TimelineScreen';
  @override
  _RouteSelectionState createState() => _RouteSelectionState();
}

class _RouteSelectionState extends State<RouteSelection> {
  var _isInit = true;
  var _isLoading = false;
  bool change = false;

  onCreating() async {
    setState(() {
      _isLoading = true;
    });
    var mapData = ModalRoute.of(context).settings.arguments;
    final busDetailsData =
        Provider.of<BusDetailsProvider>(context, listen: false);
    String id = busDetailsData
        .listRouteNoDetails[busDetailsData.routeNo.indexOf(mapData)].id;
    await busDetailsData.routeNumber(id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      onCreating();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var mapData = ModalRoute.of(context).settings.arguments;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final busDetailsData =
        Provider.of<BusDetailsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        title: Text(
          '$mapData',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Color(0xe6363450),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                  decoration: BoxDecoration(
                    color: Color(0xff363450),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(0.0, 0.5), // shadow direction: bottom right
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          'BUS ROUTE',
                          style: TextStyle(
                              color: Color(0xad1AFFD5),
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 24, screenWidth: width)),
                        ),
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Lottie.asset('assets/lottie/route_map.json'),
                        height: height / 4,
                        width: width,
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                        decoration: BoxDecoration(
                          color: Color(0xff363450),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  0.0, 0.5), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.room_outlined,
                              size: 20,
                              color: Colors.white54,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Container(
                              width: width - 138,
                              child: Text(
                                !change
                                    ? busDetailsData.routeNoDetails
                                        .listOfBusStops[0].busStop
                                    : busDetailsData
                                        .routeNoDetails
                                        .listOfBusStops[busDetailsData
                                                .routeNoDetails
                                                .listOfBusStops
                                                .length -
                                            1]
                                        .busStop,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              change = !change;
                            });
                          },
                          child: Container(
                              height: height * 0.04,
                              child: Image.asset("assets/images/change.png")),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                        decoration: BoxDecoration(
                          color: Color(0xff363450),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  0.0, 0.5), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.room_outlined,
                              size: 20,
                              color: Colors.white54,
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Container(
                              width: width - 138,
                              child: Text(
                                change
                                    ? busDetailsData.routeNoDetails
                                        .listOfBusStops[0].busStop
                                    : busDetailsData
                                        .routeNoDetails
                                        .listOfBusStops[busDetailsData
                                                .routeNoDetails
                                                .listOfBusStops
                                                .length -
                                            1]
                                        .busStop,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            final auth =
                                Provider.of<Auth>(context, listen: false);
                            await Provider.of<BusDetailsProvider>(context,
                                    listen: false)
                                .currentRunningBus(auth.userId,
                                    busDetailsData.routeNoDetails.id, change);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              DashboardScreen.route,
                              (Route<dynamic> route) => false,
                            );
                          } on HttpException catch (error) {
                            Message.showErrorDialog(
                              message: error.toString(),
                              context: context,
                            );
                          } catch (e) {
                            print(e.toString());
                            Message.showErrorDialog(
                              message: "Something went wrong",
                              icon: true,
                              context: context,
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xad1AFFD5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "NEXT",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1C1C1C),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
