import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../model/allBookedTickets.dart';
import '../providers/Auth.dart';
import '../providers/busDetails.dart';

class AllTickets extends StatefulWidget {
  static final route = 'AllTickets';

  @override
  _AllTicketsState createState() => _AllTicketsState();
}

class _AllTicketsState extends State<AllTickets> {
  bool _isLoading = false;
  String userphonenumber;
  bool _isFirstTime = true;
  AllBookedTickets allBookedTickets;
  initialMethod() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      final busDetailsData =
          Provider.of<BusDetailsProvider>(context, listen: false);
      allBookedTickets = await busDetailsData.getAllBookedTickets(auth.userId);
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
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      initialMethod();
      _isFirstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xe6363450),
        appBar: AppBar(
          backgroundColor: Color(0xff363450),
          centerTitle: true,
          title: Text(
            'All Booked Tickets',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.supervised_user_circle_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Container(
                        child: Text(
                          "Ticket Booked By Conductor!",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: allBookedTickets.ticketsByConductor.length,
                          itemBuilder: (context, index) => _creatingContainer(
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    "📞 +91-${allBookedTickets.ticketsByConductor[index].phoneNumber}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Color(0xad1AFFD5),
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.023,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Text(
                                        allBookedTickets
                                            .ticketsByConductor[index]
                                            .startingBusId,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      width: width / 3,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xad1AFFD5),
                                      size: 42,
                                    ),
                                    Container(
                                      child: Text(
                                        allBookedTickets
                                            .ticketsByConductor[index].endBusId,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      width: width / 3,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "👥 ${allBookedTickets.ticketsByConductor[index].numberOfTickets}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "💳 Rs.${allBookedTickets.ticketsByConductor[index].amountPayed}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Container(
                        child: Text(
                          "Ticket Booked By User!",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: allBookedTickets.ticketsByUser.length,
                          itemBuilder: (context, index) => _creatingContainer(
                            child: Column(
                              children: [
                                Container(
                                  height: height / 5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Carousel(
                                      dotSize: 3,
                                      dotBgColor: Colors.transparent,
                                      autoplay: false,
                                      images: [
                                        for (String image in allBookedTickets
                                            .ticketsByUser[index].faceId)
                                          Image.network(
                                              "$baseUrl/ticket/image/$image"),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.023,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Text(
                                        allBookedTickets.ticketsByUser[index]
                                            .startingBusStop,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      width: width / 3,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      color: Color(0xad1AFFD5),
                                      size: 42,
                                    ),
                                    Container(
                                      child: Text(
                                        allBookedTickets
                                            .ticketsByUser[index].endBusStop,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                      width: width / 3,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "👥 ${allBookedTickets.ticketsByUser[index].numberOfTickets}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        allBookedTickets.ticketsByUser[index]
                                                    .status ==
                                                0
                                            ? "⏰"
                                            : "🚍",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  _creatingContainer({Widget child}) {
    return Container(
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
      child: child,
    );
  }
}
