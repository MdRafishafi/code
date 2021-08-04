import 'dart:convert';

import 'package:flutter/cupertino.dart';

BusRouteDetails busRouteDetailsFromJson(String str) =>
    BusRouteDetails.fromJson(json.decode(str));

String busRouteDetailsToJson(BusRouteDetails data) =>
    json.encode(data.toJson());

class BusRouteDetails with ChangeNotifier {
  BusRouteDetails({
    this.id,
    this.busNo,
    this.distance,
    this.listOfBusStops,
  });

  String id;
  String busNo;
  String distance;
  List<BusStop> listOfBusStops;

  factory BusRouteDetails.fromJson(Map<String, dynamic> json) =>
      BusRouteDetails(
        id: json["id"] == null ? null : json["id"],
        busNo: json["bus_no"] == null ? null : json["bus_no"],
        distance: json["distance"] == null ? null : json["distance"],
        listOfBusStops: json["list_of_bus_stops"] == null
            ? null
            : List<BusStop>.from(
                json["list_of_bus_stops"].map((x) => BusStop.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "bus_no": busNo == null ? null : busNo,
        "distance": distance == null ? null : distance,
        "list_of_bus_stops": listOfBusStops == null
            ? null
            : List<dynamic>.from(listOfBusStops.map((x) => x.toJson())),
      };
}

class BusStop with ChangeNotifier {
  BusStop({
    this.id,
    this.busStop,
    this.latitude,
    this.longitude,
    this.distance,
  });

  String id;
  String busStop;
  double latitude;
  double longitude;
  String distance;

  factory BusStop.fromJson(Map<String, dynamic> json) => BusStop(
        id: json["id"],
        busStop: json["bus_stop"],
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        distance: json["distance"] == null ? null : json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bus_stop": busStop,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "distance": distance == null ? null : distance,
      };
}

class BusNo with ChangeNotifier {
  BusNo({
    this.id,
    this.busRouteNo,
  });

  String id;
  String busRouteNo;

  factory BusNo.fromJson(Map<String, dynamic> json) => BusNo(
        id: json["id"],
        busRouteNo: json["bus_route_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bus_route_no": busRouteNo,
      };
}
