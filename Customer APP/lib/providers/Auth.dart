import 'dart:async';
import 'dart:convert';

import 'package:MyBMTC/constants/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/http_exception.dart';

class Auth with ChangeNotifier {
  String _otpId;
  String _sentTo;
  String _through;
  String _userDataStorageKey = 'user_Data';
  String _userId;
  String _userMail;
  String _userOTPId;
  String _userName;
  String _phoneNumber;
  int _amount;
  bool _isAmount = false;

  int _session;

  bool get isAuth {
    return _userId != null;
  }

  Future<void> logout() async {
    try {
      _userId = null;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey(_userDataStorageKey)) {
        return false;
      }
      final Map<String, dynamic> responseData =
          json.decode(prefs.getString(_userDataStorageKey));
      setUserData(responseData);
      notifyListeners();
      return true;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  void setUserData(Map<String, dynamic> responseData) {
    _userId = responseData['user_id'];
    _userName = responseData['name'];
    _userMail = responseData['email'];
    _phoneNumber = responseData['phone_number'];
    _session = responseData['session_time'];
  }

  void setOTPDetails(Map<String, dynamic> responseData) {
    _otpId = responseData['otp_id'];
    _sentTo = responseData['sent_to'];
    _through = responseData['through'];
  }

  void setUserOTPDetails(Map<String, dynamic> responseData) {
    _userOTPId = responseData['user_id'];
    _userName = responseData['user_name'];
  }

  Future<void> getWalletAmount() async {
    final url = baseUrl + '/user/wallet-amount/$_userId';
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
      _amount = responseData["amount"];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> isUserInDatabase() async {
    final url = baseUrl + '/user/is-user/$_userId';
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          "Accept": "application/json",
        },
      );
      Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 409) {
        throw HttpException(responseData['message']);
      } else if (response.statusCode != 200) {
        throw "";
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addAmountToWallet(int newAmount) async {
    final url = baseUrl + '/user/add/wallet-amount';
    Map<String, dynamic> body = {
      'user_id': _userId,
      'amount': newAmount,
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      _amount += newAmount;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    final url = baseUrl + '/user/login';
    Map<String, String> body = {
      'email': email.trim(),
      'password': password.trim(),
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      setUserData(responseData);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(responseData);
      prefs.setString(_userDataStorageKey, userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> feedback(String data) async {
    final url = baseUrl + '/user/feedback';
    Map<String, String> body = {
      'user_id': _userId,
      'feedback': data.trim(),
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> forgotPassword(String data) async {
    final url = baseUrl + '/user/send-otp';
    Map<String, String> body = {
      'user_data': data.trim(),
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      notifyListeners();
      setOTPDetails(responseData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> verifyOTP(String otp) async {
    final url = baseUrl + '/user/verify-otp';
    Map<String, String> body = {
      'otp_id': _otpId,
      'otp': otp.trim(),
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      notifyListeners();
      setUserOTPDetails(responseData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> resendOTP() async {
    final url = baseUrl + '/user/resend-otp';
    Map<String, String> body = {
      'otp_id': _otpId,
      'through': _through,
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      notifyListeners();
      setOTPDetails(responseData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> changePassword(String password) async {
    final url = baseUrl + '/user/change-password';
    Map<String, String> body = {
      'user_id': _userOTPId,
      'password': password,
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signUp(String name, String email, String password,
      String userphonenumber) async {
    final url = baseUrl + '/user/register';
    Map<String, String> body = {
      'email': email.trim(),
      'password': password.trim(),
      'name': name.trim(),
      'phone_number': userphonenumber.trim(),
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");

    try {
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
      setUserData(responseData);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(responseData);
      prefs.setString(_userDataStorageKey, userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> getUserDetails() async {
    final url = baseUrl + '/user/get-user-details/' + _userId;

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
      setUserData(responseData);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(responseData);
      prefs.setString(_userDataStorageKey, userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> sendUserDetails(String name, String userPhoneNumber,
      String oldPassword, String newPassword) async {
    final url = baseUrl + '/user/set-user-details/' + _userId;
    Map<String, String> body = {
      'name': name.trim(),
      'phone_number': userPhoneNumber.trim(),
      'new_password': newPassword.trim(),
      'old_password': oldPassword.trim(),
    };
    var encodedBody = body.keys.map((key) => "$key=${body[key]}").join("&");
    try {
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
      setUserData(responseData);
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(responseData);
      prefs.setString(_userDataStorageKey, userData);
    } catch (error) {
      throw error;
    }
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get userMail => _userMail;

  set userMail(String value) {
    _userMail = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get phoneNumber => _phoneNumber;

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  int get session => _session;

  set session(int value) {
    _session = value;
  }

  String get sentTo => _sentTo;

  set sentTo(String value) {
    _sentTo = value;
  }

  String get through => _through;

  set through(String value) {
    _through = value;
  }

  bool get isAmount => _isAmount;

  set isAmount(bool value) {
    _isAmount = value;
    notifyListeners();
  }

  int get amount => _amount;

  set amount(int value) {
    _amount = value;
    notifyListeners();
  }
}
