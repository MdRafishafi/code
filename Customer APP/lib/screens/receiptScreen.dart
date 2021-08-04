import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/model/busFromToDetails.dart';
import 'package:flutter/material.dart';

class ReceiptScreen extends StatelessWidget {
  static final route = 'ReceiptScreen';
  const ReceiptScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map<String, dynamic> mapData = ModalRoute.of(context).settings.arguments;
    BusFromToDetails busFromToDetails =
        busFromToDetailsFromJson(mapData["busFromToDetails"]);
    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        title: Text(
          'Over View of Booking',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 5);
          },
          alignment: Alignment.centerRight,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: WillPopScope(
          onWillPop: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 5);
            return;
          },
          child: Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' FROM:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    height: 1,
                    fontSize: FontCustomizer.textFontSize(
                        fontSize: 18, screenWidth: width),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height * 0.018,
                ),
                Text(
                  mapData["from"],
                  style: TextStyle(
                    fontSize: FontCustomizer.textFontSize(
                        fontSize: 18, screenWidth: width),
                    color: Color(0xad1AFFD5),
                  ),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                Text(
                  ' TO:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    height: 1,
                    fontSize: FontCustomizer.textFontSize(
                        fontSize: 18, screenWidth: width),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height * 0.018,
                ),
                Text(
                  mapData["to"],
                  style: TextStyle(
                    fontSize: FontCustomizer.textFontSize(
                        fontSize: 18, screenWidth: width),
                    color: Color(0xad1AFFD5),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Row(
                  children: [
                    Text(
                      'FARE: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        height: 1,
                        fontSize: FontCustomizer.textFontSize(
                            fontSize: 18, screenWidth: width),
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Rs. ${mapData['total_cost']}",
                      style: TextStyle(
                        fontSize: FontCustomizer.textFontSize(
                            fontSize: 18, screenWidth: width),
                        color: Color(0xad1AFFD5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.018,
                ),
                Row(
                  children: [
                    Text(
                      'TICKETS: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        height: 1,
                        fontSize: FontCustomizer.textFontSize(
                            fontSize: 18, screenWidth: width),
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${mapData['total_ticket']}",
                      style: TextStyle(
                        fontSize: FontCustomizer.textFontSize(
                            fontSize: 18, screenWidth: width),
                        color: Color(0xad1AFFD5),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.018,
                ),
                Text(
                  ' Bus Details:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    height: 1,
                    fontSize: FontCustomizer.textFontSize(
                        fontSize: 18, screenWidth: width),
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: height * 0.018,
                ),
                for (BusDetail busDetail in busFromToDetails.busDetails)
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * 0.155,
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  'assets/images/bookticketbusicon.png',
                                  width: width * 0.16,
                                ),
                              ),
                              Text(
                                busDetail.busNo,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 20, screenWidth: width),
                                    fontWeight: FontWeight.bold,
                                    height: 2),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.038,
                        ),
                        Container(
                          width: width * 0.55,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'SOURCE STATION:',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                              ),
                              Text(
                                busDetail.startingBusStop,
                                style: TextStyle(
                                    color: Color(0xad1AFFD5),
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                'DESTINATION STATION:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                              ),
                              Text(
                                busDetail.endBusStop,
                                style: TextStyle(
                                    color: Color(0xad1AFFD5),
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                'BUS ROUTE TIMING:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                              ),
                              Text(
                                busDetail.startingBusTiming,
                                style: TextStyle(
                                    color: Color(0xad1AFFD5),
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                'TIME TAKEN:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                              ),
                              Text(
                                busDetail.timingsAndNoOfStop,
                                style: TextStyle(
                                    color: Color(0xad1AFFD5),
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 15, screenWidth: width),
                                    height: 2),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
