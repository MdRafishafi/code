import 'dart:convert';

import 'package:MyBMTC/constants/constants.dart';
import 'package:MyBMTC/helper/http_exception.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

BookedTicket bookedTicketFromJson(String str) =>
    BookedTicket.fromJson(json.decode(str));

String bookedTicketToJson(BookedTicket data) => json.encode(data.toJson());

class BookedTicket with ChangeNotifier {
  BookedTicket({
    this.amountPayed,
    this.bookedDateTime,
    this.id,
    this.numberOfTickets,
    this.tickets,
    this.toatalTime,
    this.status,
  });

  int amountPayed;
  String bookedDateTime;
  String id;
  int numberOfTickets;
  List<Ticket> tickets;
  String toatalTime;
  bool status;

  factory BookedTicket.fromJson(Map<String, dynamic> json) => BookedTicket(
        amountPayed: json["amount_payed"],
        bookedDateTime: json["booked_date_time"],
        id: json["id"],
        numberOfTickets: json["number_of_tickets"],
        status: json["status"],
        tickets:
            List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
        toatalTime: json["toatal_time"],
      );

  Map<String, dynamic> toJson() => {
        "amount_payed": amountPayed,
        "booked_date_time": bookedDateTime,
        "id": id,
        "status": status,
        "number_of_tickets": numberOfTickets,
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
        "toatal_time": toatalTime,
      };
  Future<void> cancelBookedTicket() async {
    final url = baseUrl + '/cancel/book-ticket/$id';
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Accept": "application/json",
        },
      );
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(responseData['message']);
      }
      status = !status;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}

class Ticket {
  Ticket({
    this.busNo,
    this.endBusStop,
    this.startingTime,
    this.id,
    this.startingBusStop,
    this.timingsAndNoOfStop,
  });

  String busNo;
  String endBusStop;
  String id;
  String startingBusStop;
  String timingsAndNoOfStop;
  String startingTime;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        busNo: json["bus_no"],
        endBusStop: json["end_bus_stop"],
        startingTime: json["staring_time"],
        id: json["id"],
        startingBusStop: json["starting_bus_stop"],
        timingsAndNoOfStop: json["timings_and_no_of_stop"],
      );

  Map<String, dynamic> toJson() => {
        "bus_no": busNo,
        "end_bus_stop": endBusStop,
        "staring_time": startingTime,
        "id": id,
        "starting_bus_stop": startingBusStop,
        "timings_and_no_of_stop": timingsAndNoOfStop,
      };
}
