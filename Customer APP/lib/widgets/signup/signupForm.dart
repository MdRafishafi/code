import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/helper/http_exception.dart';
import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/providers/Auth.dart';
import 'package:MyBMTC/screens/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool passwordVisible = true;
  bool isLoading = false;
  final Map<String, dynamic> _authData = {
    'name': String,
    'email': String,
    'password': String,
    'userphonenumber': String,
  };
  var _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();

  bool repasswordVisible = true;
  var _repasswordController = TextEditingController();
  final FocusNode _repasswordFocus = FocusNode();

  var _mailidController = TextEditingController();
  final FocusNode _mailidFocus = FocusNode();

  var _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();

  var _phonenoController = TextEditingController();
  final FocusNode _phonenoFocus = FocusNode();
  @override
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
                "sign up with",
                style: TextStyle(
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 22, screenWidth: width),
                  color: Color(0xFFF3D657),
                  height: 2,
                ),
              ),
              Text(
                "MYBMTC",
                style: TextStyle(
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 36, screenWidth: width),
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF3D657),
                  letterSpacing: 2,
                  height: 1.1,
                ),
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Form(
                key: _signupFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      onFieldSubmitted: (term) {
                        FontCustomizer.fieldFocusChange(
                          context: context,
                          currentFocus: _nameFocus,
                          nextFocus: _mailidFocus,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a valid name';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _authData['name'] = value;
                      },
                      style: TextStyle(
                        color: Color(0xCCF3D657),
                      ),
                      cursorColor: Color(0xFFF3D657),
                      decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Color(0xFF3F3C31),
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
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      controller: _nameController,
                      focusNode: _nameFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      onFieldSubmitted: (term) {
                        FontCustomizer.fieldFocusChange(
                          context: context,
                          currentFocus: _mailidFocus,
                          nextFocus: _phonenoFocus,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty ||
                            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _authData['email'] = value;
                      },
                      style: TextStyle(
                        color: Color(0xCCF3D657),
                      ),
                      cursorColor: Color(0xFFF3D657),
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Color(0xFF3F3C31),
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
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      controller: _mailidController,
                      focusNode: _mailidFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      onFieldSubmitted: (term) {
                        FontCustomizer.fieldFocusChange(
                          context: context,
                          currentFocus: _phonenoFocus,
                          nextFocus: _passwordFocus,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      validator: (String value) {
                        if (value.isEmpty || value.length != 10) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      onChanged: (String value) {
                        _authData['userphonenumber'] = value;
                      },
                      style: TextStyle(
                        color: Color(0xCCF3D657),
                      ),
                      cursorColor: Color(0xFFF3D657),
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        counterText: "",
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Color(0xFF3F3C31),
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
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      maxLength: 10,
                      controller: _phonenoController,
                      focusNode: _phonenoFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      onFieldSubmitted: (term) {
                        FontCustomizer.fieldFocusChange(
                          context: context,
                          currentFocus: _passwordFocus,
                          nextFocus: _repasswordFocus,
                        );
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
                      style: TextStyle(
                        color: Color(0xCCF3D657),
                      ),
                      cursorColor: Color(0xFFF3D657),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(
                            passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xCCF3D657),
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
                          color: Color(0xFF3F3C31),
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
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      onFieldSubmitted: (term) {
                        _repasswordFocus.unfocus();
                        _signupFormSaving();
                      },
                      textInputAction: TextInputAction.done,
                      validator: (String value) {
                        if (value.isEmpty || _authData['password'] != value) {
                          return 'Check re-entered password';
                        }
                        return null;
                      },
                      obscureText: repasswordVisible,
                      style: TextStyle(
                        color: Color(0xCCF3D657),
                      ),
                      cursorColor: Color(0xFFF3D657),
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(
                            repasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Color(0xCCF3D657),
                          ),
                          onTap: () {
                            setState(() {
                              this.repasswordVisible = !this.repasswordVisible;
                            });
                          },
                        ),
                        hintText: ' Renter Password',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Color(0xFF3F3C31),
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
                        fillColor: Colors.grey.withOpacity(0.1),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      ),
                      controller: _repasswordController,
                      focusNode: _repasswordFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    GestureDetector(
                      onTap: _signupFormSaving,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xFFF3D657),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFF3D657).withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: FontCustomizer.textFontSize(
                                  fontSize: 24, screenWidth: width),
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C1C1C),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 24,
              // ),
              // Text(
              //   "Or Signup with",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     fontSize: 16,
              //     color: Color(0xFFF3D657),
              //     height: 1,
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Icon(
              //       Entypo.facebook_with_circle,
              //       size: 32,
              //       color: Color(0xFFF3D657),
              //     ),
              //     SizedBox(
              //       width: 24,
              //     ),
              //     Icon(
              //       Entypo.google__with_circle,
              //       size: 32,
              //       color: Color(0xFFF3D657),
              //     ),
              //   ],
              // )
            ],
          );
  }

  void _signupFormSaving() async {
    if (_signupFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).signUp(
          _authData['name'],
          _authData['email'],
          _authData['password'],
          _authData['userphonenumber'],
        );
        setState(() {
          isLoading = false;
        });

        Navigator.pushReplacementNamed(context, DashboardScreen.route);
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
