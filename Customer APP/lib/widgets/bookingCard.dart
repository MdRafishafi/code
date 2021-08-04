import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/model/bookedTicket.dart';
import 'package:MyBMTC/providers/busDetails.dart';
import 'package:MyBMTC/screens/bookedTicketDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String date = DateFormat("dd MMM yyyy").format(DateTime.now());
    String time = DateFormat("hh:mm a").format(DateTime.now());
    final tickets = Provider.of<BookedTicket>(context, listen: false);
    final busDetailsProvider =
        Provider.of<BusDetailsProvider>(context, listen: false);
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
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
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: height * 0.0076,
              ),
              Container(
                height: height / 15,
                width: width / 1.8,
                child: Text(
                  tickets.tickets[0].startingBusStop,
                  style: TextStyle(
                    fontSize: FontCustomizer.textFontSize(
                        fontSize: 18, screenWidth: width),
                    color: Color(0xad1AFFD5),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: height * 0.016,
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
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: height * 0.0076,
              ),
              Container(
                height: height / 15,
                width: width / 1.8,
                child: Text(
                  tickets.tickets[tickets.tickets.length - 1].endBusStop,
                  style: TextStyle(
                    fontSize: FontCustomizer.textFontSize(
                        fontSize: 18, screenWidth: width),
                    color: Color(0xad1AFFD5),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: height * 0.016,
              ),
              Text(
                ' FARE:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  height: 1,
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 18, screenWidth: width),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: height * 0.0076,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Container(
                  height: height / 23,
                  width: width / 1.8,
                  child: Text(
                    "RS ${tickets.amountPayed}",
                    style: TextStyle(
                      fontSize: FontCustomizer.textFontSize(
                          fontSize: 18, screenWidth: width),
                      color: Color(0xad1AFFD5),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Consumer<BookedTicket>(
                builder: (ctx, tick, child) => tick.status
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.016,
                          ),
                          Text(
                            'Ticket Canceled',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              height: 1,
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 18, screenWidth: width),
                              color: Colors.redAccent,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: height * 0.016,
                          ),
                        ],
                      )
                    : Container(),
              ),
              SizedBox(
                height: height * 0.016,
              ),
              Text(
                ' DATE AND TIME:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  height: 1,
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 18, screenWidth: width),
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: height * 0.0076,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Container(
                  height: height / 14,
                  width: width / 1.8,
                  child: Text(
                    tickets.bookedDateTime
                        .substring(0, tickets.bookedDateTime.length - 7),
                    style: TextStyle(
                      fontSize: FontCustomizer.textFontSize(
                          fontSize: 18, screenWidth: width),
                      color: Color(0xad1AFFD5),
                    ),
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Consumer<BookedTicket>(
            builder: (ctx, tick, child) => Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  child,
                  tickets.bookedDateTime.contains(date) &&
                          time.compareTo(tickets.tickets[0].startingTime) !=
                              1 &&
                          !tick.status
                      ? GestureDetector(
                          onTap: () {
                            tickets.cancelBookedTicket();
                          },
                          child: Container(
                            height: height / 13,
                            width: width / 6,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(-1, 0),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: FontCustomizer.textFontSize(
                                    fontSize: 27, screenWidth: width),
                              ),
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            busDetailsProvider.deleteBookedTicket(tickets.id);
                          },
                          child: Container(
                            height: height / 13,
                            width: width / 6,
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.all(
                                Radius.circular(45),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  offset: Offset(-1, 0),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: FontCustomizer.textFontSize(
                                    fontSize: 27, screenWidth: width),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, BookedTicketDetails.route,
                        arguments: bookedTicketToJson(tickets));
                  },
                  child: Container(
                    height: height / 13,
                    width: width / 6,
                    decoration: BoxDecoration(
                      color: Color(0xad1AFFD5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(45),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: Offset(-1, 0),
                        ),
                      ],
                    ),
                    child: Center(
                        child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: FontCustomizer.textFontSize(
                          fontSize: 27, screenWidth: width),
                    )),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
