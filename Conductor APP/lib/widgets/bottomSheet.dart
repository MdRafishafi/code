import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/fontCustomizer.dart';
import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../providers/Auth.dart';
import '../providers/busDetails.dart';
import '../screens/searchRouteNumber.dart';

class CustomizedBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(right: 24, left: 24, top: 32, bottom: 24),
      child: Consumer<BusDetailsProvider>(
        builder: (context, busRouteDetails, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              color: Color(0x551AFFD5),
              thickness: 3,
              indent: 80,
              endIndent: 80,
            ),
            Text(
              busRouteDetails.routeNoDetails.busNo,
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: FontCustomizer.textFontSize(
                    fontSize: 30, screenWidth: width),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Divider(
              color: Color(0x551AFFD5),
              thickness: 3,
              indent: 80,
              endIndent: 80,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Previous Stop: " +
                  busRouteDetails
                      .routeNoDetails
                      .listOfBusStops[busRouteDetails.throughLocation
                          ? busRouteDetails
                                  .routeNoDetails.listOfBusStops.length -
                              2 -
                              busRouteDetails.stopNo +
                              1
                          : busRouteDetails.stopNo]
                      .busStop,
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: FontCustomizer.textFontSize(
                    fontSize: 17, screenWidth: width),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Color(0x551AFFD5),
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Next Stop:" +
                  busRouteDetails
                      .routeNoDetails
                      .listOfBusStops[busRouteDetails.throughLocation
                          ? busRouteDetails
                                  .routeNoDetails.listOfBusStops.length -
                              2 -
                              busRouteDetails.stopNo
                          : busRouteDetails.stopNo + 1]
                      .busStop,
              textAlign: TextAlign.center,
              style: TextStyle(
                // color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: FontCustomizer.textFontSize(
                    fontSize: 17, screenWidth: width),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  if (busRouteDetails.stopNo ==
                      busRouteDetails.routeNoDetails.listOfBusStops.length -
                          2) {
                    busRouteDetails.clearBusData();
                    busRouteDetails.clearBusStopForLive(auth.userId);
                    Message.toastMessage(
                        message: "Select next trip", context: context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      SearchRouteNumber.route,
                      (Route<dynamic> route) => false,
                    );
                  } else {
                    busRouteDetails.setBusStopNext();
                    int result =
                        await busRouteDetails.setBusStopForLive(auth.userId);
                    Message.toastMessage(
                        message: "Number of Persons to get down is $result",
                        context: context);
                  }
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
                margin: EdgeInsets.symmetric(horizontal: 20),
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
                    busRouteDetails.stopNo ==
                            busRouteDetails
                                    .routeNoDetails.listOfBusStops.length -
                                2
                        ? "ARRIVED TO LAST STOP"
                        : "ARRIVED TO NEXT STOP",
                    style: TextStyle(
                      fontSize: 18,
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
    );
  }
}
