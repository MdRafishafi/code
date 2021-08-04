import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/Auth.dart';
import 'providers/busDetails.dart';
import 'screens/MyTrips.dart';
import 'screens/ProfileScreen.dart';
import 'screens/aboutDeveloperScreen.dart';
import 'screens/aboutProjectGuide.dart';
import 'screens/aboutUsScreen.dart';
import 'screens/allTickets.dart';
import 'screens/bookNewTicket.dart';
import 'screens/changePassword.dart';
import 'screens/dashboardScreen.dart';
import 'screens/forgotPassword.dart';
import 'screens/homeScreen.dart';
import 'screens/loadingScreen.dart';
import 'screens/onboardingScreen.dart';
import 'screens/routeSelection.dart';
import 'screens/searchRouteNumber.dart';
import 'screens/splashScreen.dart';
import 'screens/takePictureScreen.dart';
import 'screens/verifyOTP.dart';

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
  final firstCamera = cameras.first;

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
      child: Consumer2<Auth, BusDetailsProvider>(
        builder: (BuildContext context, Auth auth,
                BusDetailsProvider busDetails, Widget child) =>
            MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.light),
          home: auth.isAuth // auth check
              ? busDetails.isBusRoute
                  ? DashboardScreen()
                  : FutureBuilder(
                      future: busDetails
                          .tryAutoSetBusRoute(), // checking already login or not
                      builder: (ctx, authResultSnapshot) {
                        return authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? LoadingScreen()
                            : SearchRouteNumber();
                      },
                    )
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
            ForgotPasswordScreen.route: (ctx) => ForgotPasswordScreen(),
            VerifyOTPScreen.route: (ctx) => VerifyOTPScreen(),
            ChangePasswordScreen.route: (ctx) => ChangePasswordScreen(),
            DashboardScreen.route: (ctx) => DashboardScreen(),
            AboutUs.route: (ctx) => AboutUs(),
            AboutDevelopers.route: (ctx) => AboutDevelopers(),
            AboutProjectGuide.route: (ctx) => AboutProjectGuide(),
            SearchRouteNumber.route: (ctx) => SearchRouteNumber(),
            RouteSelection.route: (ctx) => RouteSelection(),
            LoadingScreen.route: (ctx) => LoadingScreen(),
            MyTrips.route: (ctx) => MyTrips(),
            ProfileScreen.route: (ctx) => ProfileScreen(),
            BookNewTicket.route: (ctx) => BookNewTicket(),
            AllTickets.route: (ctx) => AllTickets(),
            TakePictureScreen.route: (ctx) => TakePictureScreen(
                  camera: widget.camera,
                ),
          },
        ),
      ),
    );
  }
}
