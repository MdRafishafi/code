import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/screens/homeScreen.dart';
import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  static final route = 'OnboardingScreen';

  @override
  _OnboardingScreenState createState() => new _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //Create a list of PageModel to be set on the onBoarding Screens.
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var pageList = [
      PageModel(
          color: const Color(0xff72147e),
          heroImagePath: 'assets/images/maps.png',
          title: Text(
            'Bus Route Identification',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 40, screenWidth: width),
            ),
            textAlign: TextAlign.center,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
                'Track all the bus details related to your particular area with their curresponding timing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: FontCustomizer.textFontSize(
                      fontSize: 20, screenWidth: width),
                )),
          ),
          iconImagePath: 'assets/images/loc.png'),
      PageModel(
        color: const Color(0xfff21170),
        heroImagePath: 'assets/images/cashless.png',
        title: Text(
          'Cashless Ticket Booking',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize:
                FontCustomizer.textFontSize(fontSize: 40, screenWidth: width),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
              'The Commuter will be able to book ticket without using any cash,which is used previously ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontCustomizer.textFontSize(
                    fontSize: 20, screenWidth: width),
              )),
        ),
        icon: Icon(
          Icons.credit_card,
          color: const Color(0xfff21170),
        ),
      ),
      PageModel(
        color: const Color(0xff02475e),
        heroImagePath: 'assets/images/userfreindly.png',
        title: Text('User Freindly',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 40, screenWidth: width),
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'The app is more easy to use and to communicate with the user this help in establisment of resources more easily ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 20, screenWidth: width),
            ),
          ),
        ),
        icon: Icon(
          Icons.supervised_user_circle_sharp,
          color: const Color(0xff02475e),
        ),
      ),
      // SVG Pages Example
      PageModel(
        color: const Color(0xffff5200),
        heroImagePath: 'assets/images/time.png',
        title: Text('Time Management',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 40, screenWidth: width),
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'This app reduce the timing of the conductor for checking like whether commuter have booked the ticket or not.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize:
                  FontCustomizer.textFontSize(fontSize: 20, screenWidth: width),
            ),
          ),
        ),
        icon: Icon(
          Icons.timer,
          color: const Color(0xffff5200),
        ),
      ),
    ];
    return Scaffold(
      //Pass pageList and the mainPage route.
      body: FancyOnBoarding(
        doneButtonText: "Done",
        skipButtonText: "Skip",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Navigator.pushReplacementNamed(context, HomeScreen.route),
        onSkipButtonPressed: () =>
            Navigator.pushReplacementNamed(context, HomeScreen.route),
      ),
    );
  }
}
