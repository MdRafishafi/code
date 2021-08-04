import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/fontCustomizer.dart';
import '../helper/message.dart';
import '../model/busDetailsClass.dart';
import '../model/ticket.dart';
import '../providers/Auth.dart';
import '../providers/busDetails.dart';

class BookNewTicket extends StatefulWidget {
  static final route = 'BookNewTicket';
  const BookNewTicket({Key key}) : super(key: key);

  @override
  _BookNewTicketState createState() => _BookNewTicketState();
}

class _BookNewTicketState extends State<BookNewTicket> {
  int adult = 0, children = 0, nextID;
  // List<String> images = [];
  // List<bool> selected = [];
  bool _isLoading = false;
  String userphonenumber;
  List<BusStop> toStops = [];
  BusStop toStop = BusStop(
    longitude: 0,
    latitude: 0,
    distance: "",
    busStop: "Select Destination",
    id: "123",
  );
  double totalCost = 0, perPerson = 0, distance = 0;
  bool _isFirstTime = true;
  var _phonenoController = TextEditingController();
  // initialMethod() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     final auth = Provider.of<Auth>(context, listen: false);
  //     final busDetailsData =
  //         Provider.of<BusDetailsProvider>(context, listen: false);
  //     images.addAll(await busDetailsData.getAllUnbookedImages(auth.userId));
  //
  //     for (String _ in images) {
  //       selected.add(false);
  //     }
  //   } on HttpException catch (error) {
  //     Message.showErrorDialog(
  //       message: error.toString(),
  //       context: context,
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //     Message.showErrorDialog(
  //       message: "Something went wrong",
  //       icon: true,
  //       context: context,
  //     );
  //   }
  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      setToStopsIDs();
      // initialMethod();
      _isFirstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color(0xe6363450),
        appBar: AppBar(
          backgroundColor: Color(0xff363450),
          centerTitle: true,
          title: Text(
            'Book New Ticket',
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
            : Column(
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
                          offset: Offset(
                              0.0, 0.5), // shadow direction: bottom right
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.phone,
                          onChanged: (String value) {
                            userphonenumber = value;
                          },
                          style: TextStyle(
                            color: Colors.white60,
                          ),
                          cursorColor: Colors.white54,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Phone',
                            hintStyle: TextStyle(
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 16, screenWidth: width),
                              color: Colors.white.withOpacity(0.4),
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.1),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 0),
                          ),
                          maxLength: 10,
                          controller: _phonenoController,
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        _buildToStopsWidget(
                          title: "To Stop",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildPersonWidget(title: "NUMBER OF ADULT"),
                        SizedBox(
                          height: 10,
                        ),
                        _buildPersonWidget(title: "NUMBER OF CHILDREN"),
                        SizedBox(
                          height: 10,
                        ),
                        totalCost != 0
                            ? Text(
                                "Total Fair: ${totalCost.round()}",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        // images.length != 0
                        //     ? ListView.builder(
                        //         scrollDirection: Axis.vertical,
                        //         shrinkWrap: true,
                        //         itemCount: images.length,
                        //         physics: ScrollPhysics(),
                        //         itemBuilder: (context, index) => Image.network(
                        //             "$baseUrl/ticket/image/${images[index]}"),
                        //       )
                        //     : Container(),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        totalCost != 0 && userphonenumber.length == 10
                            ? GestureDetector(
                                onTap: () {
                                  final busDetailsProvider =
                                      Provider.of<BusDetailsProvider>(context,
                                          listen: false);
                                  final auth =
                                      Provider.of<Auth>(context, listen: false);
                                  try {
                                    busDetailsProvider.bookTicket(
                                      new Tickets(
                                          amountPayed: totalCost,
                                          conductorId: auth.userId,
                                          phoneNumber: userphonenumber,
                                          busNoId:
                                              busDetailsProvider.busRouteId,
                                          numberOfTickets: adult + children,
                                          endBusId: toStop.id,
                                          startingBusId: busDetailsProvider
                                              .routeNoDetails
                                              .listOfBusStops[nextID]
                                              .id),
                                    );
                                    Message.toastMessage(
                                        message: "Ticket Added",
                                        context: context);
                                    toStop = toStops[0];
                                    totalCost = 0;
                                    adult = 0;
                                    children = 0;
                                    distance = 0;
                                    _phonenoController.clear();
                                    setState(() {});
                                  } catch (e) {
                                    Message.showErrorDialog(
                                        message: "Some thing went wrong!",
                                        context: context);
                                  }
                                  //   Navigator.of(context).pushNamed(
                                  //       RouteSelection.route,
                                  //       arguments: busRouteNumber);
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
                              )
                            : Container()
                      ],
                    ),
                  ),
                ],
              ));
  }

  setToStopsIDs() {
    final busDetailsProvider =
        Provider.of<BusDetailsProvider>(context, listen: false);
    nextID = busDetailsProvider.throughLocation
        ? busDetailsProvider.routeNoDetails.listOfBusStops.length -
            1 -
            busDetailsProvider.stopNo
        : busDetailsProvider.stopNo;
    int endingID = busDetailsProvider.throughLocation
        ? 0
        : busDetailsProvider.routeNoDetails.listOfBusStops.length;
    toStops.add(toStop);
    if (busDetailsProvider.throughLocation) {
      for (int i = nextID - 1; i > endingID; i--)
        toStops.add(busDetailsProvider.routeNoDetails.listOfBusStops[i]);
    } else {
      for (int i = nextID + 1; i < endingID; i++)
        toStops.add(busDetailsProvider.routeNoDetails.listOfBusStops[i]);
    }
  }

  settingCost() {
    final busDetailsProvider =
        Provider.of<BusDetailsProvider>(context, listen: false);
    distance = 0;
    nextID = busDetailsProvider.throughLocation
        ? busDetailsProvider.routeNoDetails.listOfBusStops.length -
            1 -
            busDetailsProvider.stopNo
        : busDetailsProvider.stopNo;
    int endingID =
        busDetailsProvider.routeNoDetails.listOfBusStops.indexOf(toStop);
    if (toStop.id == "123") {
      perPerson = 0;
      totalCost = 0;
      adult = 0;
      children = 0;
      setState(() {});
      return;
    }
    if (busDetailsProvider.throughLocation) {
      for (int i = nextID; i > endingID; i--) {
        distance = distance +
            double.parse(busDetailsProvider
                .routeNoDetails.listOfBusStops[i].distance
                .replaceFirst(" M", ""));
      }
    } else {
      for (int i = nextID + 1; i < endingID; i++)
        distance = distance +
            double.parse(busDetailsProvider
                .routeNoDetails.listOfBusStops[i].distance
                .replaceFirst(" M", ""));
    }
    if (distance != 0) {
      if (distance < 3000) {
        perPerson = 5;
      } else if (distance > 3000 && distance < 5000) {
        perPerson = 10;
      } else if (distance > 5000 && distance < 7000) {
        perPerson = 15;
      } else if (distance > 7000 && distance < 15000) {
        perPerson = 20;
      } else if (distance > 15000 && distance < 41000) {
        perPerson = 25;
      } else if (distance > 41000) {
        perPerson = 30;
      }
      totalCost = 0;
      adult = 0;
      children = 0;
      setState(() {});
      print(perPerson);
    }
  }

  Widget _buildPersonWidget({String title}) {
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
                totalCost = (perPerson * adult + perPerson / 2 * children);
                setState(() {});
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

  Widget _buildToStopsWidget({String title}) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.white, width: 1.0)),
        padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        child: DropdownButton<BusStop>(
            isExpanded: true,
            isDense: true,
            autofocus: true,
            value: toStop,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 42,
            underline: SizedBox(),
            onChanged: (BusStop newValue) {
              toStop = newValue;
              settingCost();
              setState(() {});
            },
            dropdownColor: Color(0xaf1AFFD5),
            iconEnabledColor: Colors.white,
            items: toStops.map<DropdownMenuItem<BusStop>>((BusStop value) {
              return DropdownMenuItem<BusStop>(
                value: value,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    value.busStop,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              );
            }).toList()));
  }
}
