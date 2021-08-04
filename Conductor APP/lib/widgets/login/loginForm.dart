import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/fontCustomizer.dart';
import '../../helper/http_exception.dart';
import '../../helper/message.dart';
import '../../providers/Auth.dart';
import '../../screens/forgotPassword.dart';
import '../../screens/searchRouteNumber.dart';

final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isLoading = false;
  bool passwordVisible = true;
  var _mailidController = TextEditingController();
  final FocusNode _mailidFocus = FocusNode();

  var _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  final Map<String, dynamic> _authData = {
    'email': String,
    'password': String,
  };

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return isLoading
        ? CircularProgressIndicator(
            backgroundColor: Color(0xFFF3D657),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome to",
                style: TextStyle(
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 16, screenWidth: width),
                  color: Color(0xFF1C1C1C),
                  height: 2,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "MY BMTC",
                    style: TextStyle(
                      fontSize: FontCustomizer.textFontSize(
                          fontSize: 36, screenWidth: width),
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                      letterSpacing: 2,
                      height: 1,
                    ),
                  ),
                ],
              ),
              Text(
                "Please login to continue",
                style: TextStyle(
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 16, screenWidth: width),
                  color: Color(0xFF1C1C1C),
                  height: 1,
                ),
              ),
              SizedBox(
                height: width * 0.05,
              ),
              Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      onFieldSubmitted: (term) {
                        FontCustomizer.fieldFocusChange(
                          context: context,
                          currentFocus: _mailidFocus,
                          nextFocus: _passwordFocus,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty ||
                            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                          return 'Please enter a valid mailId';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _authData['email'] = value;
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Email / Username',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Color(0xFFD9BC43),
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      controller: _mailidController,
                      focusNode: _mailidFocus,
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    TextFormField(
                      onFieldSubmitted: (term) {
                        _loginFormSaving();
                      },
                      textInputAction: TextInputAction.next,
                      validator: (String value) {
                        if (value.isEmpty || value.length <= 8) {
                          return 'Please enter a valid password';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _authData['password'] = value;
                      },
                      obscureText: passwordVisible,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xFF1C1C1C),
                          ),
                          onTap: () {
                            setState(() {
                              this.passwordVisible = !this.passwordVisible;
                            });
                          },
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Color(0xFFD9BC43),
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
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    GestureDetector(
                      onTap: _loginFormSaving,
                      child: Container(
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          color: Color(0xFF1C1C1C),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF1C1C1C).withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 20, screenWidth: width),
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
              SizedBox(
                height: height * 0.025,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, ForgotPasswordScreen.route);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                  child: Text(
                    "FORGOT PASSWORD?",
                    style: TextStyle(
                      fontSize: FontCustomizer.textFontSize(
                          fontSize: 15, screenWidth: width),
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C1C1C),
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  void _loginFormSaving() async {
    if (_loginFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacementNamed(context, SearchRouteNumber.route);
      } on HttpException catch (error) {
        Message.showErrorDialog(
          message: error.toString(),
          context: context,
        );
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        debugPrint(e.toString());
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
