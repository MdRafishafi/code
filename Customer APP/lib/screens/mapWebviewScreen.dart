import 'package:MyBMTC/constants/colors.dart';
import 'package:MyBMTC/helper/fontCustomizer.dart';
import 'package:MyBMTC/model/busFromToDetails.dart';
import 'package:MyBMTC/providers/busDetails.dart';
import 'package:MyBMTC/screens/bookTicketScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapWebViewScreen extends StatefulWidget {
  static final route = 'MapWebViewScreen';
  @override
  _MapWebViewScreenState createState() => _MapWebViewScreenState();
}

class _MapWebViewScreenState extends State<MapWebViewScreen> {
  var _isInit = true;
  var _isLoading = false;
  BusFromToDetails _busFromToDetails;
  Map<String, dynamic> mapData;
  void initialChanges() async {
    setState(() {
      _isLoading = true;
    });
    mapData = ModalRoute.of(context).settings.arguments;
    final busDetailsData =
        Provider.of<BusDetailsProvider>(context, listen: false);
    _busFromToDetails = await busDetailsData.busBetweenStops(
        busDetailsData
            .busStopDetails[busDetailsData.busStop.indexOf(mapData["from"])],
        busDetailsData
            .busStopDetails[busDetailsData.busStop.indexOf(mapData["to"])]);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      initialChanges();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: Uri.dataFromString(
                          '<html><body>${_busFromToDetails.iframe.replaceFirst("width='600' height='450'", "width='$width' height='$height' gestureHandling='greedy'")}</body></html>',
                          mimeType: 'text/html')
                      .toString(),
                ),
          _isLoading
              ? Container()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    // onTap: _loginFormSaving,
                    onTap: () {
                      mapData["busFromToDetails"] =
                          busFromToDetailsToJson(_busFromToDetails);
                      Navigator.pushNamed(
                        context,
                        BookTicketScreen.route,
                        arguments: mapData,
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: height * 0.025,
                          left: width * 0.23,
                          right: width * 0.23),
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
                            "BOOK A TICKET",
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
                  ),
                ),
          Container(
            width: width,
            decoration: BoxDecoration(
              color: kAccentColor2,
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 2.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 0.5), // shadow direction: bottom right
                )
              ],
            ),
            height: height * 0.117,
            child: Row(
              children: [
                SizedBox(
                  width: width * 0.07,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                      onTap: () => Navigator.pop(context),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    )
                  ],
                ),
                SizedBox(
                  width: width * 0.3,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'MY BMTC',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
