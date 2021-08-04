import 'package:MyBMTC/constants/colors.dart';
import 'package:MyBMTC/screens/aboutDeveloperScreen.dart';
import 'package:MyBMTC/screens/aboutProjectGuide.dart';
import 'package:MyBMTC/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:swipedetector/swipedetector.dart';

class AboutUs extends StatefulWidget {
  static final String id = 'AboutUs';
  static final route = 'AboutUs';
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  FSBStatus drawerStatus;
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
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
        screenContents: aboutUsBody(height, width),
        drawerBackgroundColor: kBackgroundWhiteColor,
      ),
    );
  }

  Widget aboutUsBody(double height, double width) {
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: kAccentColor2,
            ),
            clipper: GetClipper(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.07,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                              ? FSBStatus.FSB_CLOSE
                              : FSBStatus.FSB_OPEN;
                        });
                      },
                      child: IconButton(
                          icon: Icon(
                            drawerStatus == FSBStatus.FSB_OPEN
                                ? Icons.close
                                : Icons.menu_rounded,
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
                    ),
                    SizedBox(
                      width: width * 0.4,
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.125,
                ),
                Container(
                    width: width * 0.4,
                    height: width * 0.4,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage('assets/images/svce.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 7.0,
                            color: Colors.black,
                          )
                        ])),
                SizedBox(height: height * 0.05),
                Text(
                  'About Us',
                  style: TextStyle(
                    fontSize: height * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.025),
                Text(
                  '"This app was generally developed as a final year project from CSE department of SRI VENKATESHWARA COLLEGE OF ENGINEERING BANGALORE. The main aim of this project is to modify the previously present BMTC app.  "',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: height * 0.0225,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: height * 0.03),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AboutDevelopers.id);
                  },
                  child: Container(
                      height: height * 0.06,
                      width: width * 0.6,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.black.withOpacity(0.8),
                        color: kAccentColor2,
                        elevation: 8.0,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'About Developers',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.05,
                                    fontFamily: 'Montserrat'),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: width * 0.09,
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(height: height * 0.03),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AboutProjectGuide.route);
                  },
                  child: Container(
                      height: height * 0.06,
                      width: width * 0.6,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.black.withOpacity(0.8),
                        color: kAccentColor2,
                        elevation: 8.0,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'About Project Guide',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.05,
                                    fontFamily: 'Montserrat'),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.white,
                                size: width * 0.09,
                              )
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
