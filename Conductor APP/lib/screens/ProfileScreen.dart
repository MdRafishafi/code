import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';

import '../helper/fontCustomizer.dart';
import '../helper/http_exception.dart';
import '../helper/message.dart';
import '../providers/Auth.dart';
import '../widgets/customDrawer.dart';

class ProfileScreen extends StatefulWidget {
  static final route = 'ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FSBStatus drawerStatus;
  bool _isFirstTime = true;
  bool _isLoading = false;

  var _nameController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();

  var _mailIdController = TextEditingController();
  final FocusNode _mailIdFocus = FocusNode();

  var _phoneNoController = TextEditingController();
  final FocusNode _phoneNoFocus = FocusNode();

  bool _oldPasswordVisible = true;
  var _oldPasswordController = TextEditingController();
  final FocusNode _oldPasswordFocus = FocusNode();

  bool _newPasswordVisible = true;
  var _newPasswordController = TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();

  bool _rePasswordVisible = true;
  var _rePasswordController = TextEditingController();
  final FocusNode _rePasswordFocus = FocusNode();

  _initialMethod() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      await auth.getUserDetails();
      _nameController.text = auth.userName;
      _mailIdController.text = auth.userMail;
      _phoneNoController.text = auth.phoneNumber;
    } on HttpException catch (error) {
      Message.showErrorDialog(
        message: error.toString(),
        context: context,
      );
    } catch (e) {
      debugPrint(e.toString());
      Message.showErrorDialog(
        message: "Something went wrong",
        icon: true,
        context: context,
      );
    }
    setState(() {
      _isLoading = false;
    });
    _isFirstTime = false;
  }

  @override
  void didChangeDependencies() {
    if (_isFirstTime) {
      _initialMethod();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SwipeDetector(
      onSwipeLeft: () {
        setState(() {
          drawerStatus = FSBStatus.FSB_CLOSE;
        });
      },
      onSwipeRight: () {
        setState(() {
          drawerStatus = FSBStatus.FSB_OPEN;
        });
      },
      child: FoldableSidebarBuilder(
        status: drawerStatus,
        drawer: CustomDrawer(),
        screenContents: dashboardScreenBody(height, width),
        drawerBackgroundColor: Colors.white,
      ),
    );
  }

  Widget dashboardScreenBody(double height, double width) {
    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              drawerStatus == FSBStatus.FSB_OPEN
                  ? Icons.close
                  : Icons.sort_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                    ? FSBStatus.FSB_CLOSE
                    : FSBStatus.FSB_OPEN;
              });
            }),
        title: Text(
          'Profile',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: width - 20,
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 7),
                decoration: BoxDecoration(
                  color: Color(0xff363450),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset:
                          Offset(0.0, 0.5), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      child: Lottie.asset('assets/lottie/profile.json'),
                      height: height / 4,
                      width: width,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Colors.white,
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
                      enabled: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Colors.white,
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
                      controller: _mailIdController,
                      focusNode: _mailIdFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Phone',
                        counterText: "",
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Colors.white,
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
                      controller: _phoneNoController,
                      focusNode: _phoneNoFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: _oldPasswordVisible,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _oldPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              this._oldPasswordVisible =
                                  !this._oldPasswordVisible;
                            });
                          },
                        ),
                        hintText: 'Old Password',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Colors.white,
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
                      controller: _oldPasswordController,
                      focusNode: _oldPasswordFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      obscureText: _newPasswordVisible,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _newPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              this._newPasswordVisible =
                                  !this._newPasswordVisible;
                            });
                          },
                        ),
                        hintText: 'New Password',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Colors.white,
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
                      controller: _newPasswordController,
                      focusNode: _newPasswordFocus,
                    ),
                    SizedBox(
                      height: height * 0.0225,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: _rePasswordVisible,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          child: Icon(
                            _rePasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                          onTap: () {
                            setState(() {
                              this._rePasswordVisible =
                                  !this._rePasswordVisible;
                            });
                          },
                        ),
                        hintText: 'Renter New Password',
                        hintStyle: TextStyle(
                          fontSize: FontCustomizer.textFontSize(
                              fontSize: 16, screenWidth: width),
                          color: Colors.white,
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
                      controller: _rePasswordController,
                      focusNode: _rePasswordFocus,
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
                            "UPDATE PROFILE",
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
            ),
    );
  }

  void _signupFormSaving() async {
    String _name = _nameController.value.text,
        _userPhoneNumber = _phoneNoController.value.text,
        _oldPassword = _oldPasswordController.value.text,
        _newPassword = _newPasswordController.value.text,
        _newRePassword = _rePasswordController.value.text;
    if (_oldPassword != null && _newPassword != _newRePassword) {
      Message.showErrorDialog(
        message: "New password do not match",
        context: context,
      );
      return;
    }
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .sendUserDetails(_name, _userPhoneNumber, _oldPassword, _newPassword);
      setState(() {
        _isLoading = false;
      });
      Message.showErrorDialog(
        title: "Profile",
        message: "Updated Profile",
        context: context,
      );
    } on HttpException catch (error) {
      Message.showErrorDialog(
        message: error.toString(),
        context: context,
      );
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      Message.showErrorDialog(
        message: "Something went wrong",
        icon: true,
        context: context,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
}
