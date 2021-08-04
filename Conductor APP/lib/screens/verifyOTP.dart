import '../helper/fontCustomizer.dart';
import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../providers/Auth.dart';
import '../screens/changePassword.dart';
import '../screens/homeScreen.dart';
import '../widgets/numericPad.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerifyOTPScreen extends StatefulWidget {
  static final route = 'VerifyOTPScreen';
  @override
  _VerifyOTPScreenState createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  String code = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final authData = Provider.of<Auth>(context, listen: false);
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacementNamed(context, HomeScreen.route);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.route);
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 30,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Enter OTP ",
            style: TextStyle(
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 18, screenWidth: width),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          textTheme: Theme.of(context).textTheme,
        ),
        body: SafeArea(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Text(
                                  "OTP is sent to \n" + authData.sentTo,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 20, screenWidth: width),
                                    color: Color(0xFF818181),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    buildCodeNumberBox(code.length > 0
                                        ? code.substring(0, 1)
                                        : ""),
                                    buildCodeNumberBox(code.length > 1
                                        ? code.substring(1, 2)
                                        : ""),
                                    buildCodeNumberBox(code.length > 2
                                        ? code.substring(2, 3)
                                        : ""),
                                    buildCodeNumberBox(code.length > 3
                                        ? code.substring(3, 4)
                                        : ""),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Didn't recieve code? ",
                                      style: TextStyle(
                                        fontSize: FontCustomizer.textFontSize(
                                            fontSize: 16, screenWidth: width),
                                        color: Color(0xFF818181),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: _recentOtp,
                                      child: Text(
                                        "Request again",
                                        style: TextStyle(
                                          fontSize: FontCustomizer.textFontSize(
                                              fontSize: 16, screenWidth: width),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      code.length == 4
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.13,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: _verifyOtp,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFFFDC3D),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "Verify OTP",
                                              style: TextStyle(
                                                fontSize:
                                                    FontCustomizer.textFontSize(
                                                        fontSize: 16,
                                                        screenWidth: width),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      NumericPad(
                        onNumberSelected: (value) {
                          setState(() {
                            if (value != -1) {
                              if (code.length < 4) {
                                code = code + value.toString();
                              }
                            } else {
                              if (code.length != 0)
                                code = code.substring(0, code.length - 1);
                            }
                          });
                        },
                      ),
                    ],
                  )),
      ),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF6F5FA),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 25.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _recentOtp() async {
    try {
      await Provider.of<Auth>(context, listen: false).resendOTP();
    } on HttpException catch (error) {
      Message.showErrorDialog(
        message: error.toString(),
        context: context,
      );
    } catch (e) {
      Message.showErrorDialog(
        message: "Something went wrong",
        icon: true,
        context: context,
      );
    }
  }

  void _verifyOtp() async {
    try {
      await Provider.of<Auth>(context, listen: false).verifyOTP(code);
      setState(() {
        isLoading = false;
      });

      Navigator.pushReplacementNamed(context, ChangePasswordScreen.route);
    } on HttpException catch (error) {
      Message.showErrorDialog(
        message: error.toString(),
        context: context,
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      Message.showErrorDialog(
        message: "Something went wrong",
        icon: true,
        context: context,
      );
      setState(() {
        isLoading = false;
      });
    }
  }
}
