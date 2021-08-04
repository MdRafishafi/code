import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/Auth.dart';
import '../screens/MyTrips.dart';
import '../screens/ProfileScreen.dart';
import '../screens/aboutUsScreen.dart';
import '../screens/dashboardScreen.dart';
import '../screens/homeScreen.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<Auth>(context, listen: false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width * 0.60;
    return Material(
      child: Container(
        color: Color(0xe6363450),
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.07,
            ),
            Container(
              child: Image.asset('assets/icon/dashboardlogo.png'),
              width: width,
              height: height / 6,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                'Hello,\n${auth.userName}',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Divider(
              indent: width * 0.1,
              endIndent: width * 0.1,
              color: Colors.white70,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          DashboardScreen.route,
                          (route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: Colors.white,
                            size: width * 0.1,
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: width * 0.1,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ProfileScreen.route,
                          (route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: width * 0.1,
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              fontSize: width * 0.1,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          MyTrips.route,
                          (route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.collections_bookmark,
                            color: Colors.white,
                            size: width * 0.1,
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Text(
                            'My Trips',
                            style: TextStyle(
                              fontSize: width * 0.1,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AboutUs.id,
                          (route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.person_sharp,
                            color: Colors.white,
                            size: width * 0.1,
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Text(
                            'About Us',
                            style: TextStyle(
                              fontSize: width * 0.1,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<Auth>(context, listen: false).logout();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          HomeScreen.route,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: width * 0.1,
                          ),
                          SizedBox(
                            width: width * 0.05,
                          ),
                          Text(
                            'Log Out',
                            style: TextStyle(
                              fontSize: width * 0.1,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
