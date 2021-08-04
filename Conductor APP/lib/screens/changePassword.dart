import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../helper/fontCustomizer.dart';
import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../providers/Auth.dart';
import '../screens/homeScreen.dart';

final GlobalKey<FormState> _changepasswordFormKey = GlobalKey<FormState>();

class ChangePasswordScreen extends StatefulWidget {
  static final route = 'ChangePasswordScreen';
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool passwordVisible = true;
  String password;
  String rePassword;
  bool displayContainer = false;
  bool isLoading = false;
  var _passwordController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  bool repasswordVisible = true;
  var _repasswordController = TextEditingController();
  final FocusNode _repasswordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacementNamed(context, HomeScreen.route);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Change Your Password",
            style: TextStyle(
              fontSize: 18,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          child: Lottie.asset('assets/lottie/password.json'),
                          height: height / 4,
                          width: width - 4),
                      Text(
                        'Please enter your new password!🔑',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        'Password length should be more then 8 char',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        width: double.infinity,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  0.0, 0.5), // shadow direction: bottom right
                            )
                          ],
                        ),
                        child: Form(
                          key: _changepasswordFormKey,
                          child: Column(
                            children: [
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
                                  if (value.isEmpty ||
                                      value.length <= 8 ||
                                      password != rePassword) {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                                },
                                onChanged: (String value) {
                                  if (value == rePassword &&
                                      password.length > 8 &&
                                      rePassword.length > 8) {
                                    setState(() {
                                      displayContainer = true;
                                    });
                                  } else {
                                    setState(() {
                                      displayContainer = false;
                                    });
                                  }
                                  password = value;
                                },
                                obscureText: passwordVisible,
                                style: TextStyle(
                                  color: Color(0xcc3F3C31),
                                  fontWeight: FontWeight.bold,
                                ),
                                cursorColor: Color(0xFF3F3C31),
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                      passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xFF3F3C31),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        this.passwordVisible =
                                            !this.passwordVisible;
                                      });
                                    },
                                  ),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
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
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                ),
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                onFieldSubmitted: (term) {
                                  _repasswordFocus.unfocus();
                                  _changePasswordForm();
                                },
                                textInputAction: TextInputAction.done,
                                onChanged: (value) {
                                  if (value == password &&
                                      password.length > 8 &&
                                      rePassword.length > 8) {
                                    setState(() {
                                      displayContainer = true;
                                    });
                                  } else {
                                    setState(() {
                                      displayContainer = false;
                                    });
                                  }
                                  rePassword = value;
                                },
                                validator: (String value) {
                                  if (value.isEmpty ||
                                      value.length <= 8 ||
                                      password != rePassword) {
                                    return 'Please enter a valid password';
                                  }
                                  return null;
                                },
                                obscureText: repasswordVisible,
                                style: TextStyle(
                                  color: Color(0xcc3F3C31),
                                  fontWeight: FontWeight.bold,
                                ),
                                cursorColor: Color(0xFF3F3C31),
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    child: Icon(
                                      repasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xFF3F3C31),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        this.repasswordVisible =
                                            !this.repasswordVisible;
                                      });
                                    },
                                  ),
                                  hintText: ' Renter Password',
                                  hintStyle: TextStyle(
                                    fontSize: 16,
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
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 0),
                                ),
                                controller: _repasswordController,
                                focusNode: _repasswordFocus,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      displayContainer
                          ? GestureDetector(
                              onTap: _changePasswordForm,
                              child: Container(
                                width: width / 2,
                                height: height / 17,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFDC3D),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(0.0,
                                          0.5), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "Change Password",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: height / 20,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _changePasswordForm() async {
    if (_changepasswordFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false)
            .changePassword(password);
        setState(() {
          isLoading = false;
        });
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => LoginScreen()),
        //     (Route<dynamic> route) => false);
        Navigator.pushReplacementNamed(context, HomeScreen.route);
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
