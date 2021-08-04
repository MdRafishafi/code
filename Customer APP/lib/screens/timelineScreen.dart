import 'package:MyBMTC/model/busDetailsClass.dart';
import 'package:MyBMTC/providers/busDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineScreen extends StatefulWidget {
  static final route = 'TimelineScreen';
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  var _isInit = true;
  var _isLoading = false;
  BusRouteDetails routeNoDetails;
  Map<String, dynamic> current;
  onCreating() async {
    setState(() {
      _isLoading = true;
    });
    var mapData = ModalRoute.of(context).settings.arguments;
    final busDetailsData =
        Provider.of<BusDetailsProvider>(context, listen: false);
    String id = busDetailsData
        .listRouteNoDetails[busDetailsData.routeNo.indexOf(mapData)].id;
    routeNoDetails = await busDetailsData.routeNumber(id);
    current = await busDetailsData.busCurrentLoc(id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      onCreating();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var mapData = ModalRoute.of(context).settings.arguments;

    const List<Color> colourForBackground = [
      Color(0xffF78A37),
      Color(0xffE9C43B),
      Color(0xff9E9C51),
      Color(0xffE5567F),
      Color(0xffB87731),
      Color(0xff2397D3)
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        title: Text(
          '$mapData Timeline',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      backgroundColor: Color(0xe6363450),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                final busDetailsData =
                    Provider.of<BusDetailsProvider>(context, listen: false);
                String id = busDetailsData
                    .listRouteNoDetails[busDetailsData.routeNo.indexOf(mapData)]
                    .id;
                routeNoDetails = await busDetailsData.routeNumber(id);
                current = await busDetailsData.busCurrentLoc(id);
              },
              child: ListView.builder(
                itemCount: routeNoDetails.listOfBusStops.length,
                itemBuilder: (context, index) {
                  Color c = colourForBackground[index % 6];
                  return TimelineTile(
                    alignment: TimelineAlign.center,
                    isFirst: index == 0 ? true : false,
                    isLast: index == routeNoDetails.listOfBusStops.length - 1
                        ? true
                        : false,
                    indicatorStyle: IndicatorStyle(
                      width: 20,
                      indicatorXY: 0.3, //i-((i/6)*6)
                      padding: EdgeInsets.all(8),
                      color: colourForBackground[index % 6],
                    ),
                    startChild: index % 2 == 0
                        ? startOrEndChild(
                            routeNoDetails.listOfBusStops[index], index)
                        : Container(),
                    endChild: index % 2 == 1
                        ? startOrEndChild(
                            routeNoDetails.listOfBusStops[index], index)
                        : Container(),
                  );
                },
              ),
            ),
    );
  }

  Widget startOrEndChild(BusStop busDetailsData, int index) {
    return Container(
      padding: EdgeInsets.all(15.0),
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
            offset: Offset(0.0, 0.5), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        children: [
          //SvgPicture.asset(order_processed, height: 50, width: 50,),
          SizedBox(
            height: 5,
          ),
          Text(
            busDetailsData.busStop,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xad1AFFD5),
            ),
            textAlign: index % 2 == 1 ? TextAlign.start : TextAlign.end,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            busDetailsData.distance != null
                ? "Distance : ${busDetailsData.distance}"
                : index == 0
                    ? "Staring Bus stop"
                    : "",
            style: TextStyle(fontSize: 12, color: Colors.white),
            textAlign: index % 2 == 1 ? TextAlign.start : TextAlign.end,
          ),
          for (int i = 0; i < current["active"].length; i++)
            current["active"][i]["passed"] ==
                    routeNoDetails.listOfBusStops[index].id
                ? current["active"][i]["next"] ==
                        routeNoDetails.listOfBusStops[index + 1].id
                    ? Row(
                        children: [
                          Text(
                            "Active",
                            style: TextStyle(
                                fontSize: 20, color: Colors.greenAccent),
                          ),
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.greenAccent,
                            size: 40,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            "Active",
                            style: TextStyle(
                                fontSize: 20, color: Colors.greenAccent),
                          ),
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.greenAccent,
                            size: 40,
                          ),
                        ],
                      )
                : Container()
        ],
      ),
    );
  }
}
