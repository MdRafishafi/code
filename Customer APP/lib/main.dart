import 'package:MyBMTC/providers/busDetails.dart';
import 'package:MyBMTC/screens/MyBookings.dart';
import 'package:MyBMTC/screens/ProfileScreen.dart';
import 'package:MyBMTC/screens/aboutDeveloperScreen.dart';
import 'package:MyBMTC/screens/aboutProjectGuide.dart';
import 'package:MyBMTC/screens/aboutUsScreen.dart';
import 'package:MyBMTC/screens/bookTicketScreen.dart';
import 'package:MyBMTC/screens/bookedTicketDetails.dart';
import 'package:MyBMTC/screens/busBetweenStops.dart';
import 'package:MyBMTC/screens/changePassword.dart';
import 'package:MyBMTC/screens/dashboardScreen.dart';
import 'package:MyBMTC/screens/faceIdScreen.dart';
import 'package:MyBMTC/screens/feedbackScreen.dart';
import 'package:MyBMTC/screens/forgotPassword.dart';
import 'package:MyBMTC/screens/homeScreen.dart';
import 'package:MyBMTC/screens/loadingScreen.dart';
import 'package:MyBMTC/screens/mapScreen.dart';
import 'package:MyBMTC/screens/mapWebviewScreen.dart';
import 'package:MyBMTC/screens/nearByBuses.dart';
import 'package:MyBMTC/screens/receiptScreen.dart';
import 'package:MyBMTC/screens/searchRouteNumber.dart';
import 'package:MyBMTC/screens/splashScreen.dart';
import 'package:MyBMTC/screens/timelineScreen.dart';
import 'package:MyBMTC/screens/verifyOTP.dart';
import 'package:MyBMTC/screens/walletScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './providers/Auth.dart';
import 'screens/onboardingScreen.dart';
import 'screens/takePictureScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.top,
    SystemUiOverlay.bottom,
  ]);
  final cameras = await availableCameras();
  final firstCamera = cameras.last;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatefulWidget {
  final CameraDescription camera;
  const MyApp({
    Key key,
    this.camera,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: BusDetailsProvider(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (BuildContext context, auth, Widget child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.light),
          home: auth.isAuth // auth check
              ? DashboardScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(), // checking already login or not
                  builder: (ctx, authResultSnapshot) {
                    return authResultSnapshot.connectionState ==
                            ConnectionState.waiting
                        ? LoadingScreen()
                        : SplashScreen();
                  },
                ),
          routes: {
            OnboardingScreen.route: (ctx) => OnboardingScreen(),
            HomeScreen.route: (ctx) => HomeScreen(),
            MapWebViewScreen.route: (ctx) => MapWebViewScreen(),
            ForgotPasswordScreen.route: (ctx) => ForgotPasswordScreen(),
            VerifyOTPScreen.route: (ctx) => VerifyOTPScreen(),
            ChangePasswordScreen.route: (ctx) => ChangePasswordScreen(),
            DashboardScreen.route: (ctx) => DashboardScreen(),
            MapScreen.route: (ctx) => MapScreen(),
            BusBetweenStops.route: (ctx) => BusBetweenStops(),
            FeedbackScreen.route: (ctx) => FeedbackScreen(),
            AboutUs.route: (ctx) => AboutUs(),
            AboutDevelopers.route: (ctx) => AboutDevelopers(),
            AboutProjectGuide.route: (ctx) => AboutProjectGuide(),
            SearchRouteNumber.route: (ctx) => SearchRouteNumber(),
            TimelineScreen.route: (ctx) => TimelineScreen(),
            LoadingScreen.route: (ctx) => LoadingScreen(),
            BookTicketScreen.route: (ctx) => BookTicketScreen(),
            FaceIdFetchScreen.route: (ctx) => FaceIdFetchScreen(),
            WalletScreen.route: (ctx) => WalletScreen(),
            ReceiptScreen.route: (ctx) => ReceiptScreen(),
            MyBookings.route: (ctx) => MyBookings(),
            ProfileScreen.route: (ctx) => ProfileScreen(),
            BookedTicketDetails.route: (ctx) => BookedTicketDetails(),
            NearByBuses.route: (ctx) => NearByBuses(),
            TakePictureScreen.route: (ctx) => TakePictureScreen(
                  camera: widget.camera,
                ),
          },
        ),
      ),
    );
  }
}
