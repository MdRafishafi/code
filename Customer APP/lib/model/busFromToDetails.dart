import 'dart:convert';

BusFromToDetails busFromToDetailsFromJson(String str) =>
    BusFromToDetails.fromJson(json.decode(str));

String busFromToDetailsToJson(BusFromToDetails data) =>
    json.encode(data.toJson());

class BusFromToDetails {
  BusFromToDetails({
    this.busDetails,
    this.cost,
    this.iframe,
    this.toatalTime,
  });

  List<BusDetail> busDetails;
  String cost;
  String iframe;
  String toatalTime;

  factory BusFromToDetails.fromJson(Map<String, dynamic> json) =>
      BusFromToDetails(
        busDetails: List<BusDetail>.from(
            json["bus_details"].map((x) => BusDetail.fromJson(x))),
        cost: json["cost"],
        iframe: json["iframe"],
        toatalTime: json["toatal_time"],
      );

  Map<String, dynamic> toJson() => {
        "bus_details": List<dynamic>.from(busDetails.map((x) => x.toJson())),
        "cost": cost,
        "iframe": iframe,
        "toatal_time": toatalTime,
      };
}

class BusDetail {
  BusDetail({
    this.busNo,
    this.endBusStop,
    this.startingBusStop,
    this.startingBusTiming,
    this.timingsAndNoOfStop,
  });

  String busNo;
  String endBusStop;
  String startingBusStop;
  String startingBusTiming;
  String timingsAndNoOfStop;

  factory BusDetail.fromJson(Map<String, dynamic> json) => BusDetail(
        busNo: json["bus_no"],
        endBusStop: json["end_bus_stop"],
        startingBusStop: json["starting_bus_stop"],
        startingBusTiming: json["starting_bus_timing"],
        timingsAndNoOfStop: json["timings_and_no_of_stop"],
      );

  Map<String, dynamic> toJson() => {
        "bus_no": busNo,
        "end_bus_stop": endBusStop,
        "starting_bus_stop": startingBusStop,
        "starting_bus_timing": startingBusTiming,
        "timings_and_no_of_stop": timingsAndNoOfStop,
      };
}
