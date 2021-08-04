import 'dart:convert';
import 'dart:io';

import 'package:MyBMTC/constants/constants.dart';
import 'package:MyBMTC/helper/http_exception.dart';
import 'package:MyBMTC/model/bookedTicket.dart';
import 'package:MyBMTC/model/busDetailsClass.dart';
import 'package:MyBMTC/model/busFromToDetails.dart';
import 'package:MyBMTC/model/busesNearBy.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BusDetailsProvider with ChangeNotifier {
  BusRouteDetails _listOfBusDetails;
  List<BusesNearBy> _allBusesNearBy = [];

  List<String> routeNo = [];
  List<BusNo> listRouteNoDetails = [];
  List<String> busStop = [];
  List<BusStop> busStopDetails = [];
  List<BookedTicket> listBookedTicket = [];

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
    listBookedTicket = [];
    final url = baseUrl + '/get/book-ticket/$userID';
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
      responseData["ticket"].forEach((element) {
        listBookedTicket.insert(0, BookedTicket.fromJson(element));
      });

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> deleteBookedTicket(String id) async {
    final url = baseUrl + '/delete/book-ticket/$id';
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
      for (BookedTicket data in listBookedTicket) {
        if (data.id == id) {
          listBookedTicket.remove(data);
          break;
        }
      }
      notifyListeners();
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

  Future<List<String>> _addNewFaceID(List<String> imagesList) async {
    List<String> image = [];
    try {
      for (int i = 0; i < imagesList.length; i++) {
        try {
          String imageUrl = await _asyncFileUpload(File(imagesList[i]));
          image.add(imageUrl);
        } catch (e) {
          throw e;
        }
      }
      return image;
    } catch (error) {
      throw error;
    }
  }

  _asyncFileUpload(File file) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("$baseUrl/book-ticket/face-id"));
    var pic = await http.MultipartFile.fromPath("images", file.path);
    request.files.add(pic);
    try {
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      if (response.statusCode != 200) {
        throw HttpException(json.decode(responseString)['message']);
      }
      return json.decode(responseString)["photos_url"];
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
      return busRouteDetailsFromJson(response.body);
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> busCurrentLoc(String dataId) async {
    final url = baseUrl + '/live-location/$dataId';
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

  Future<void> getBusesData(latitude, longitude) async {
    _allBusesNearBy = [];
    String url = "$baseUrl/location/$latitude/$longitude";
    try {
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw HttpException(json.decode(response.body)['message']);
      }
      for (Map<String, dynamic> data
          in json.decode(response.body)["list_of_buses"])
        _allBusesNearBy.add(BusesNearBy.fromJson(data));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> bookTicket(
      List<String> imagesLoc, Map<String, dynamic> ticketDetails) async {
    final url = Uri.parse('$baseUrl/book-ticket');
    try {
      List<String> images = await _addNewFaceID(imagesLoc);
      ticketDetails["images"] = images;
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
        },
        body: jsonEncode(ticketDetails),
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

  List<BusesNearBy> get allBusesNearBy => _allBusesNearBy;
  BusRouteDetails get listOfBusDetails => _listOfBusDetails;
}
