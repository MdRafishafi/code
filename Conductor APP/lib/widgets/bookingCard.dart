import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/fontCustomizer.dart';
import '../model/trips.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final tickets = Provider.of<Trips>(context, listen: false);
    return Container(
      width: width - 20,
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
            offset: Offset(0.0, 0.5), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            tickets.busRouteNo,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              height: 1,
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 24, screenWidth: width),
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: height * 0.0076,
          ),
          Text(
            tickets.startingStop,
            style: TextStyle(
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 18, screenWidth: width),
              color: Color(0xad1AFFD5),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: height * 0.0056,
          ),
          Text(
            tickets.startOfTrip,
            style: TextStyle(
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 14, screenWidth: width),
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Icon(
            Icons.arrow_downward_rounded,
            size: 40,
            color: Colors.white,
          ),
          Text(
            tickets.endingStop,
            style: TextStyle(
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 18, screenWidth: width),
              color: Color(0xad1AFFD5),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: height * 0.0056,
          ),
          Text(
            tickets.endOfTrip,
            style: TextStyle(
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 15, screenWidth: width),
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
