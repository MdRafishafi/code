import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/model/busFromToDetails.dart';
import 'package:MyBMTC/screens/faceIdScreen.dart';
import 'package:flutter/material.dart';

final GlobalKey<FormState> _bookTicketFeedback = GlobalKey<FormState>();

class BookTicketScreen extends StatefulWidget {
  static final route = 'BookTicketScreen';
  @override
  _BookTicketScreenState createState() => _BookTicketScreenState();
}

class _BookTicketScreenState extends State<BookTicketScreen> {
  bool isLoading = false;
  int adult = 0, children = 0;
  double cost = 0;

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
          'BOOK TICKET',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      customiseContainer(
                        child: Column(
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
                              textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
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
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: height * 0.018,
                            ),
                            Text(
                              'TIME TAKEN:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                height: 1,
                                fontSize: FontCustomizer.textFontSize(
                                    fontSize: 18, screenWidth: width),
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: height * 0.018,
                            ),
                            Text(
                              busFromToDetails.toatalTime,
                              style: TextStyle(
                                fontSize: FontCustomizer.textFontSize(
                                    fontSize: 18, screenWidth: width),
                                color: Color(0xad1AFFD5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: height * 0.025,
                            ),
                            Text(
                              'FARE:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                height: 1,
                                fontSize: FontCustomizer.textFontSize(
                                    fontSize: 18, screenWidth: width),
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: height * 0.018,
                            ),
                            Text(
                              "Rs. ${busFromToDetails.cost}",
                              style: TextStyle(
                                fontSize: FontCustomizer.textFontSize(
                                    fontSize: 18, screenWidth: width),
                                color: Color(0xad1AFFD5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        width: width,
                      ),
                      customiseContainer(
                          child: Column(
                            children: [
                              _buildPropertyTypesWidget(
                                  title: "NUMBER OF ADULT",
                                  perperson:
                                      double.parse(busFromToDetails.cost)),
                              SizedBox(
                                height: 10,
                              ),
                              _buildPropertyTypesWidget(
                                  title: "NUMBER OF CHILDREN",
                                  perperson:
                                      double.parse(busFromToDetails.cost)),
                              SizedBox(
                                height: height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'TOTAL FARE: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2,
                                      height: 1,
                                      fontSize: FontCustomizer.textFontSize(
                                          fontSize: 18, screenWidth: width),
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "Rs. ",
                                    style: TextStyle(
                                      fontSize: FontCustomizer.textFontSize(
                                          fontSize: 18, screenWidth: width),
                                      color: Color(0xad1AFFD5),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    cost.toString(),
                                    style: TextStyle(
                                      fontSize: FontCustomizer.textFontSize(
                                          fontSize: 18, screenWidth: width),
                                      color: Color(0xad1AFFD5),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // _buildPropertyTypesWidget(title: "NUMBER OF SENIOUR CITIZEN",hint: "NUMBER OF ADULT"),
                            ],
                          ),
                          width: width),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Text(
                        'buses to board between the routes are  :',
                        style: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 15, screenWidth: width),
                          color: Colors.grey[350],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      for (BusDetail busDetail in busFromToDetails.busDetails)
                        customiseContainer(
                          width: width,
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
                        )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  if (adult != 0 || children != 0)
                    Navigator.pushNamed(context, FaceIdFetchScreen.route,
                        arguments: {
                          "busFromToDetails": mapData["busFromToDetails"],
                          "from": mapData["from"],
                          "to": mapData["to"],
                          "total_ticket": adult + children,
                          'total_cost': cost
                        });
                },
                child: Container(
                  height: 40,
                  width: width / 1.3,
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
                      "FACE ID",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1C1C1C),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  customiseContainer({Widget child, double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
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
      child: child,
    );
  }

  Widget _buildPropertyTypesWidget({String title, double perperson}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Color(0xad1AFFD5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<int>(
              value: title.endsWith("T") ? adult : children,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 42,
              underline: SizedBox(),
              onChanged: (int newValue) {
                if (title.endsWith("T")) {
                  adult = newValue;
                } else {
                  children = newValue;
                }

                cost = (perperson * adult + perperson / 2 * children);
                setState(() {});
                print(cost);
              },
              dropdownColor: Color(0xad1AFFD5),
              iconEnabledColor: Colors.white,
              items: [0, 1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    "$value",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                );
              }).toList()),
        ),
      ],
    );
  }
}
