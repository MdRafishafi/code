import 'dart:convert';

BusesNearBy busesNearByFromJson(String str) =>
    BusesNearBy.fromJson(json.decode(str));

String busesNearByToJson(BusesNearBy data) => json.encode(data.toJson());

class BusesNearBy {
  BusesNearBy({
    this.id,
    this.busRouteNumber,
    this.latitude,
    this.longitude,
    this.startingStop,
    this.endingStop,
  });

  String id;
  String busRouteNumber;
  double latitude;
  double longitude;
  String startingStop;
  String endingStop;

  factory BusesNearBy.fromJson(Map<String, dynamic> json) => BusesNearBy(
        id: json["id"],
        busRouteNumber: json["bus_route_number"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        startingStop: json["starting_stop"],
        endingStop: json["ending_stop"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bus_route_number": busRouteNumber,
        "latitude": latitude,
        "longitude": longitude,
        "starting_stop": startingStop,
        "ending_stop": endingStop,
      };
}
