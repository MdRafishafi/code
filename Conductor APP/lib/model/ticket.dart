import 'dart:convert';

Tickets ticketsFromJson(String str) => Tickets.fromJson(json.decode(str));

String ticketsToJson(Tickets data) => json.encode(data.toJson());

class Tickets {
  Tickets({
    this.id,
    this.conductorId,
    this.numberOfTickets,
    this.phoneNumber,
    this.amountPayed,
    this.busNoId,
    this.startingBusId,
    this.endBusId,
    this.bookedDateTime,
  });

  String id;
  String conductorId;
  int numberOfTickets;
  String phoneNumber;
  double amountPayed;
  String busNoId;
  String startingBusId;
  String endBusId;
  String bookedDateTime;

  factory Tickets.fromJson(Map<String, dynamic> json) => Tickets(
        id: json["id"] == null ? null : json["id"],
        conductorId: json["conductor_id"],
        numberOfTickets: json["number_of_tickets"],
        phoneNumber: json["phone_number"],
        amountPayed: json["amount_payed"].toDouble(),
        busNoId: json["bus_no_id"],
        startingBusId: json["starting_bus_id"],
        endBusId: json["end_bus_id"],
        bookedDateTime:
            json["booked_date_time"] == null ? null : json["booked_date_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "conductor_id": conductorId,
        "number_of_tickets": numberOfTickets,
        "phone_number": phoneNumber,
        "amount_payed": amountPayed,
        "bus_no_id": busNoId,
        "starting_bus_id": startingBusId,
        "end_bus_id": endBusId,
        "booked_date_time": bookedDateTime == null ? null : bookedDateTime,
      };
}
