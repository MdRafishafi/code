import 'dart:convert';

AllBookedTickets allBookedTicketsFromJson(String str) =>
    AllBookedTickets.fromJson(json.decode(str));

String allBookedTicketsToJson(AllBookedTickets data) =>
    json.encode(data.toJson());

class AllBookedTickets {
  AllBookedTickets({
    this.ticketsByConductor,
    this.ticketsByUser,
  });

  List<TicketsByConductor> ticketsByConductor;
  List<TicketsByUser> ticketsByUser;

  factory AllBookedTickets.fromJson(Map<String, dynamic> json) =>
      AllBookedTickets(
        ticketsByConductor: List<TicketsByConductor>.from(
            json["tickets_by_conductor"]
                .map((x) => TicketsByConductor.fromJson(x))),
        ticketsByUser: List<TicketsByUser>.from(
            json["tickets_by_user"].map((x) => TicketsByUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tickets_by_conductor":
            List<dynamic>.from(ticketsByConductor.map((x) => x.toJson())),
        "tickets_by_user":
            List<dynamic>.from(ticketsByUser.map((x) => x.toJson())),
      };
}

class TicketsByConductor {
  TicketsByConductor({
    this.id,
    this.numberOfTickets,
    this.startingBusId,
    this.endBusId,
    this.phoneNumber,
    this.amountPayed,
  });

  String id;
  int numberOfTickets;
  String startingBusId;
  String endBusId;
  String phoneNumber;
  int amountPayed;

  factory TicketsByConductor.fromJson(Map<String, dynamic> json) =>
      TicketsByConductor(
        id: json["id"],
        numberOfTickets: json["number_of_tickets"],
        startingBusId: json["starting_bus_id"],
        endBusId: json["end_bus_id"],
        phoneNumber: json["phone_number"],
        amountPayed: json["amount_payed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number_of_tickets": numberOfTickets,
        "starting_bus_id": startingBusId,
        "end_bus_id": endBusId,
        "phone_number": phoneNumber,
        "amount_payed": amountPayed,
      };
}

class TicketsByUser {
  TicketsByUser({
    this.id,
    this.startingBusStop,
    this.endBusStop,
    this.status,
    this.numberOfTickets,
    this.faceId,
  });

  String id;
  String startingBusStop;
  String endBusStop;
  int status;
  int numberOfTickets;
  List<String> faceId;

  factory TicketsByUser.fromJson(Map<String, dynamic> json) => TicketsByUser(
        id: json["id"],
        startingBusStop: json["starting_bus_stop"],
        endBusStop: json["end_bus_stop"],
        status: json["status"],
        numberOfTickets: json["number_of_tickets"],
        faceId: List<String>.from(json["face_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "starting_bus_stop": startingBusStop,
        "end_bus_stop": endBusStop,
        "status": status,
        "number_of_tickets": numberOfTickets,
        "face_id": List<dynamic>.from(faceId.map((x) => x)),
      };
}
