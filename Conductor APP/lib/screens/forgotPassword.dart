import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/fontCustomizer.dart';
import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../providers/Auth.dart';
import '../screens/homeScreen.dart';
import '../screens/verifyOTP.dart';

final GlobalKey<FormState> _verifyFormKey = GlobalKey<FormState>();

class ForgotPasswordScreen extends StatefulWidget {
  static final route = 'ForgotPasswordScreen';
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool isLoading = false;
  var _mailIdController = TextEditingController();
  final FocusNode _mailIdFocus = FocusNode();
  String userInput;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacementNamed(context, HomeScreen.route);
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF7F7F7),
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, HomeScreen.route);
            },
            child: Icon(
              Icons.close,
              size: 30,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Enter Your Register ID",
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
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Container(
                          height: height / 3.4,
                          child: Image.asset('assets/images/holding-phone.png'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 14, horizontal: 64),
                          child: Text(
                            "You'll receive a 4 digit code to verify next.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 18, screenWidth: width),
                              color: Color(0xFF818181),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Form(
                          key: _verifyFormKey,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: width / 12, right: width / 12),
                            child: Column(
                              children: [
                                TextFormField(
                                  onFieldSubmitted: (term) {
                                    _mailIdFocus.unfocus();
                                    _forgotForm();
                                  },
                                  textInputAction: TextInputAction.done,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter a valid data';
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    userInput = value;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter your mail id 💌/Phone Number☎',
                                    hintStyle: TextStyle(
                                      fontSize: FontCustomizer.textFontSize(
                                          fontSize: 15, screenWidth: width),
                                      color: Color(0xcc3F3C31),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFECCB45),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 0),
                                  ),
                                  controller: _mailIdController,
                                  focusNode: _mailIdFocus,
                                ),
                                SizedBox(
                                  height: height * 0.035,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    _forgotForm();
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1C1C1C),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF1C1C1C)
                                              .withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 4,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "SEND OTP",
                                        style: TextStyle(
                                          fontSize: FontCustomizer.textFontSize(
                                              fontSize: 22, screenWidth: width),
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF3D657),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }

  void _forgotForm() async {
    if (_verifyFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .forgotPassword(userInput);
        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacementNamed(context, VerifyOTPScreen.route);
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
}
