import 'package:MyBMTC/helper/http_exception.dart';
import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/providers/Auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'dashboardScreen.dart';

final GlobalKey<FormState> _FeedbackFormKey = GlobalKey<FormState>();

class FeedbackScreen extends StatefulWidget {
  static final route = 'FeedbackScreen';
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool isLoading = false;
  String _data;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        title: Text(
          'Feedback Screen',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Container(
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                        'Give Your Valuable Feedback ✨',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      child: Lottie.asset('assets/lottie/feedback.json'),
                      height: height / 3.5,
                      width: width / 1.2,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    isLoading
                        ? Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Form(
                            key: _FeedbackFormKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 16,
                                ),
                                TextFormField(
                                  onFieldSubmitted: (term) {
                                    _feedbackFormSaving();
                                  },
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.multiline,
                                  minLines:
                                      1, //Normal textInputField will be displayed
                                  maxLines:
                                      12, // when user presses enter it will adapt to it
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Please enter a your Feedback';
                                    }
                                    return null;
                                  },
                                  onChanged: (String value) {
                                    _data = value;
                                  },
                                  cursorColor: Colors.white38,
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter your valuable feedback here!😊',
                                    hintStyle: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white60,
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
                                    fillColor: Color(0xff33314d),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 0),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                GestureDetector(
                                  onTap: _feedbackFormSaving,
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Color(0xad1AFFD5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(25),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black54.withOpacity(0.2),
                                          spreadRadius: 3,
                                          blurRadius: 4,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "SEND FEEDBACK",
                                        style: TextStyle(
                                          fontSize: 24,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _feedbackFormSaving() async {
    if (_FeedbackFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await Provider.of<Auth>(context, listen: false).feedback(
          _data,
        );
        setState(() {
          isLoading = false;
        });
        Message.showErrorDialog(
          title: "FeedBack Submitted",
          message: "Successfully Submitted  your feedback",
          context: context,
        );
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
