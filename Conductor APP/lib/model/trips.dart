import 'dart:convert';

import 'package:flutter/cupertino.dart';

Trips tripsFromJson(String str) => Trips.fromJson(json.decode(str));

String tripsToJson(Trips data) => json.encode(data.toJson());

class Trips with ChangeNotifier {
  Trips({
    this.busRouteNo,
    this.endOfTrip,
    this.endingStop,
    this.id,
    this.startOfTrip,
    this.startingStop,
  });

  String busRouteNo;
  String endOfTrip;
  String endingStop;
  String id;
  String startOfTrip;
  String startingStop;

  factory Trips.fromJson(Map<String, dynamic> json) => Trips(
        busRouteNo: json["bus_route_no"],
        endOfTrip: json["end_of_trip"],
        endingStop: json["ending_stop"],
        id: json["id"],
        startOfTrip: json["start_of_trip"],
        startingStop: json["starting_stop"],
      );

  Map<String, dynamic> toJson() => {
        "bus_route_no": busRouteNo,
        "end_of_trip": endOfTrip,
        "ending_stop": endingStop,
        "id": id,
        "start_of_trip": startOfTrip,
        "starting_stop": startingStop,
      };
}
