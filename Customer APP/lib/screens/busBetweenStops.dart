import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/providers/busDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mapWebviewScreen.dart';

class BusBetweenStops extends StatefulWidget {
  static final route = 'BusBetweenStops';
  @override
  _BusBetweenStopsState createState() => _BusBetweenStopsState();
}

class _BusBetweenStopsState extends State<BusBetweenStops> {
  String fromData = '';
  String toData = '';

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
          ' Search Routes Between Stops',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
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
                        Container(
                          child: Text(
                            'Get the best routes to travel between two bus station 🚌',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Container(
                              child: Text(
                                'SOURCE',
                                style: TextStyle(
                                  color: Color(0xad1AFFD5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showSearch(
                                    context: context, delegate: SearchEngine())
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  fromData = value;
                                });
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
                                  Icons.my_location_rounded,
                                  size: 20,
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Container(
                                  width: width / 1.55,
                                  child: Text(
                                    fromData.isEmpty
                                        ? 'Please enter your source location'
                                        : fromData,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.005,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 13),
                            child: Container(
                              child: Text(
                                'DESTINATION',
                                style: TextStyle(
                                  color: Color(0xad1AFFD5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showSearch(
                                    context: context, delegate: SearchEngine())
                                .then((value) {
                              if (value != null) {
                                setState(() {
                                  toData = value;
                                });
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
                                  Icons.location_on_rounded,
                                  size: 20,
                                  color: Colors.white54,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Container(
                                  width: width / 1.55,
                                  child: Text(
                                    toData.isEmpty
                                        ? 'Please enter your destination location'
                                        : toData,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        toData.isNotEmpty &&
                                fromData.isNotEmpty &&
                                toData != fromData
                            ? GestureDetector(
                                //   onTap: _loginFormSaving,
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, MapWebViewScreen.route,
                                      arguments: {
                                        "from": fromData,
                                        "to": toData
                                      });
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
                                        color: Colors.black54.withOpacity(0.2),
                                        spreadRadius: 3,
                                        blurRadius: 4,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "SHOW ROUTE",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1C1C1C),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
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
        await auth.busStopSearch(query);
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
        : busDetailsData.busStop
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
