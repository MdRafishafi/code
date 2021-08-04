import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/constants.dart';
import '../helper/http_exception.dart';
import '../model/allBookedTickets.dart';
import '../model/busDetailsClass.dart';
import '../model/busFromToDetails.dart';
import '../model/ticket.dart';
import '../model/trips.dart';

class BusDetailsProvider with ChangeNotifier {
  BusRouteDetails _listOfBusDetails;
  List<String> routeNo = [];
  List<BusNo> listRouteNoDetails = [];
  List<String> busStop = [];
  List<BusStop> busStopDetails = [];
  List<Trips> listTrips = [];
  final String _busDataStorageKey = "conductorBusRouteDetails";
  String _busRouteId;

  int _stopNo;
  bool _throughLocation;
  BusRouteDetails routeNoDetails;

  Future<bool> tryAutoSetBusRoute() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(_busDataStorageKey)) {
        return false;
      }
      final Map<String, dynamic> responseData =
          json.decode(prefs.getString(_busDataStorageKey));
      setBusData(responseData);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  void setBusData(Map<String, dynamic> responseData) {
    _busRouteId = responseData['busRoute'];
    _throughLocation = responseData['throughLoc'];
    _stopNo = responseData['stopNo'];
    notifyListeners();
  }

  void setBusStopNext() async {
    _stopNo = _stopNo + 1;
    setBusData({
      "busRoute": _busRouteId,
      'throughLoc': _throughLocation,
      "stopNo": _stopNo,
    });

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
        _busDataStorageKey,
        json.encode({
          "busRoute": _busRouteId,
          'throughLoc': _throughLocation,
          "stopNo": _stopNo,
        }));
  }

  Future<int> setBusStopForLive(String userID) async {
    final url = baseUrl + '/conductor/set/live-location/$userID';
    try {
      Map<String, dynamic> body = {
        'bus_route_id': _busRouteId,
        'passed_bus_stop_id': routeNoDetails
            .listOfBusStops[_throughLocation
                ? routeNoDetails.listOfBusStops.length - 2 - _stopNo + 1
                : _stopNo]
            .id,
        'next_bus_stop_id': routeNoDetails
            .listOfBusStops[_throughLocation
                ? routeNoDetails.listOfBusStops.length - 2 - _stopNo
                : _stopNo + 1]
            .id,
        "through": _throughLocation ? 1 : 0,
      };
      var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Accept": "application/json",
        },
        body: encodedBody,
      );
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(responseData['message']);
      }
      return responseData["number_of_persons"];
    } catch (error) {
      throw error;
    }
  }

  void clearBusData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_busDataStorageKey);
  }

  Future<int> clearBusStopForLive(String userID) async {
    final url = baseUrl + '/conductor/set/live-location/$userID';
    try {
      Map<String, dynamic> body = {
        "through": _throughLocation ? 1 : 0,
      };
      var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
      final response = await http.patch(url,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            "Accept": "application/json",
          },
          body: encodedBody);
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(responseData['message']);
      }
      return responseData["number_of_persons"];
    } catch (error) {
      throw error;
    }
  }

  Future<void> routeNumberSearch(String data) async {
    final url = baseUrl +
        '/bmtc/search/bus-route/by-starting-letter/${data.toLowerCase()}';
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
      responseData["list_of_bus_no"].forEach((element) {
        if (!routeNo.contains(element["bus_route_no"])) {
          routeNo.add(element["bus_route_no"]);
          listRouteNoDetails.add(BusNo.fromJson(element));
          notifyListeners();
        }
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> bookedTicketDetails(String userID) async {
    listTrips = [];
    final url = baseUrl + '/get/trip/$userID';
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
      responseData["trips"].forEach((element) {
        listTrips.insert(0, Trips.fromJson(element));
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> currentRunningBus(
      String _conductorId, String _busRoute, bool _through) async {
    final url = baseUrl + '/conductor/set/current-running-bus';
    Map<String, dynamic> body = {
      'conductor_id': _conductorId,
      'bus_route_id': _busRoute,
      'through_loc': _through ? 1 : 0,
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            "Accept": "application/json",
          },
          body: encodedBody);
      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }
      Map<String, dynamic> newBusData = {
        "busRoute": _busRoute,
        'throughLoc': _through,
        "stopNo": 0
      };
      setBusData(newBusData);
      setBusStopForLive(_conductorId);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(_busDataStorageKey, json.encode(newBusData));
    } catch (error) {
      throw error;
    }
  }

  Future<void> liveLocation({
    String conductorId,
    double lat,
    double lon,
  }) async {
    final url = baseUrl + '/conductor/set/location/' + conductorId;
    Map<String, dynamic> body = {
      'latitude': lat,
      'longitude': lon,
      'starting_stop': _throughLocation
          ? routeNoDetails
              .listOfBusStops[routeNoDetails.listOfBusStops.length - 1].busStop
          : routeNoDetails.listOfBusStops[0].busStop,
      'ending_stop': !_throughLocation
          ? routeNoDetails
              .listOfBusStops[routeNoDetails.listOfBusStops.length - 1].busStop
          : routeNoDetails.listOfBusStops[0].busStop,
      'bus_route_id': _busRouteId
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            "Accept": "application/json",
          },
          body: encodedBody);
      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<List<String>> busStopSearch(String data) async {
    final url = baseUrl +
        '/bmtc/search/bus-stop/by-starting-letter/${data.toLowerCase()}';
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
      responseData["list_of_bus_stops"].forEach((element) {
        if (!busStop.contains(element["bus_stop"])) {
          busStop.add(element["bus_stop"]);
          busStopDetails.add(BusStop.fromJson(element));
          notifyListeners();
        }
      });
    } catch (error) {
      throw error;
    }
  }

  scanner(String conductorId, File file) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("$baseUrl/scan/face-id/$conductorId"));
    var pic = await http.MultipartFile.fromPath("images", file.path);
    request.files.add(pic);
    try {
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      if (response.statusCode != 200) {
        throw HttpException(json.decode(responseString)['result']);
      }
      print("success" + json.decode(responseString)['result']);
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> getLatitudeLongitude(String id) async {
    final url = baseUrl + '/bmtc/search/bus-stop/$id';
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
      return responseData;
    } catch (error) {
      throw error;
    }
  }

  Future<BusFromToDetails> busBetweenStops(BusStop from, BusStop to) async {
    final url =
        '$baseUrl/get-bus-no-from-to/${from.latitude}/${from.longitude}/${to.latitude}/${to.longitude}';
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Accept": "application/json",
        },
      );
      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }
      return busFromToDetailsFromJson(response.body);
    } catch (error) {
      throw error;
    }
  }

  Future<BusRouteDetails> routeNumber(String dataId) async {
    final url = baseUrl + '/bmtc/search/bus-route-no/$dataId';
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Accept": "application/json",
        },
      );
      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }
      routeNoDetails = busRouteDetailsFromJson(response.body);
    } catch (error) {
      throw error;
    }
  }

  // Future<List<String>> getAllUnbookedImages(String dataId) async {
  //   final url = baseUrl + '/get/all-unbooked-users/$dataId';
  //   try {
  //     final response = await http.get(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //         "Accept": "application/json",
  //       },
  //     );
  //     Map<String, dynamic> responseData = json.decode(response.body);
  //     if (response.statusCode != 200) {
  //       throw HttpException(responseData['message']);
  //     }
  //     List<String> result = [];
  //     for (String i in responseData["images"]) result.add(i);
  //     return result;
  //   } catch (error) {
  //     throw error;
  //   }
  // }

  Future<AllBookedTickets> getAllBookedTickets(String userID) async {
    final url = baseUrl + '/get/all-booked-tickets/$userID';
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
      return AllBookedTickets.fromJson(responseData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> getMarkerData(latitude, longitude) async {
    String url = "$baseUrl/bmtc/$latitude/$longitude";
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }
      _listOfBusDetails = busRouteDetailsFromJson(response.body);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> bookTicket(Tickets newTickets) async {
    final url = Uri.parse('$baseUrl/conductor/book-ticket');
    try {
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
        },
        body: ticketsToJson(newTickets),
      );
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode != 200) {
        throw HttpException(responseData['message']);
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  bool get isBusRoute {
    return _busRouteId != null;
  }

  String get busRouteId => _busRouteId;

  BusRouteDetails get listOfBusDetails => _listOfBusDetails;

  int get stopNo => _stopNo;

  bool get throughLocation => _throughLocation;
}
