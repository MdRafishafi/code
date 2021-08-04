import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../helper/fontCustomizer.dart';
import '../helper/message.dart';
import '../providers/busDetails.dart';
import '../screens/routeSelection.dart';

class SearchRouteNumber extends StatefulWidget {
  static final route = 'SearchRouteNumber';
  @override
  _SearchRouteNumberState createState() => _SearchRouteNumberState();
}

class _SearchRouteNumberState extends State<SearchRouteNumber> {
  String busRouteNumber = '';

  @override
  void initState() {
    super.initState();
  }

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
          'Select Bus Route',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
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
                            offset: Offset(
                                0.0, 0.5), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 13),
                              child: Container(
                                child: Text(
                                  'ROUTE NUMBER',
                                  style: TextStyle(
                                    color: Color(0xad1AFFD5),
                                    fontSize: FontCustomizer.textFontSize(
                                        fontSize: 20, screenWidth: width),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            child: Lottie.asset('assets/lottie/bus_route.json'),
                            height: height / 4,
                            width: width,
                          ),
                          GestureDetector(
                            onTap: () {
                              showSearch(
                                      context: context,
                                      delegate: SearchEngine())
                                  .then((value) {
                                if (value != null) {
                                  busRouteNumber = value;
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(20.0),
                              margin: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 7),
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
                                    offset: Offset(0.0,
                                        0.5), // shadow direction: bottom right
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.room_outlined,
                                    size: 20,
                                    color: Colors.white54,
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  Text(
                                    busRouteNumber.isEmpty
                                        ? 'Please enter route number'
                                        : busRouteNumber,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          busRouteNumber == null || busRouteNumber == ""
                              ? Container()
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        RouteSelection.route,
                                        arguments: busRouteNumber);
                                  },
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
                                        "NEXT",
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool data = true;
String previous;
List<String> list_previous = [];
var recentLocation = [];
bool isLoading = false;

class SearchEngine extends SearchDelegate<String> {
  String searchItemSelected;

  void fetchData(auth, context) async {
    if (query.length == 1 &&
        (data || (previous != query && previous.length == 1)) &&
        !list_previous.contains(query)) {
      previous = query;
      list_previous.add(query);
      isLoading = true;
      try {
        await auth.routeNumberSearch(query);
        isLoading = false;
        data = false;
      } catch (e) {
        Message.showErrorDialog(
          message: e,
          context: context,
        );
        list_previous.remove(query);
        isLoading = false;
        data = false;
      }
    }
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, searchItemSelected);
    return ListTile(
      title: Text('Not Found'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var busDetailsData = Provider.of<BusDetailsProvider>(context);
    final suggestionList = query.isEmpty
        ? recentLocation
        : busDetailsData.routeNo
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
    fetchData(busDetailsData, context);
    return Stack(children: [
      ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => !isLoading ||
                suggestionList.length != 0
            ? ListTile(
                onTap: () {
                  searchItemSelected = suggestionList[index];
                  showResults(context);
                },
                title: RichText(
                  text: TextSpan(
                      text: suggestionList[index].substring(0, query.length),
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: suggestionList[index].substring(query.length),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ]),
                ),
              )
            : ListTile(
                title: Text("No Route number found for $query!"),
              ),
      ),
      isLoading ? Center(child: CircularProgressIndicator()) : Container()
    ]);
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: theme.cardColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(
        color: Colors.black54,
      ),
      primaryColorBrightness: Brightness.light,
      appBarTheme:
          theme.appBarTheme.copyWith(color: Colors.white, elevation: 0),
    );
  }
}
