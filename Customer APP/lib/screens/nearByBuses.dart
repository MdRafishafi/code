import 'dart:async';

import 'package:MyBMTC/model/busesNearBy.dart';
import 'package:MyBMTC/providers/busDetails.dart';
import 'package:MyBMTC/widgets/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class NearByBuses extends StatefulWidget {
  static final route = 'NearByBuses';
  @override
  _NearByBusesState createState() => _NearByBusesState();
}

class _NearByBusesState extends State<NearByBuses> {
  FSBStatus drawerStatus;
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  Timer timer;
  int zoomNumber = 10;

  Set<Marker> _marker = {};
  BitmapDescriptor mapMarker;
  @override
  void initState() {
    super.initState();

    setCustomMarker();
    getCurrentLocation();
    timer = Timer.periodic(Duration(seconds: 10), (Timer t) async {
      print("rafi");
      await getCurrentLocation();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FoldableSidebarBuilder(
      status: drawerStatus,
      drawer: CustomDrawer(),
      screenContents: dashboardScreenBody(height, width),
      drawerBackgroundColor: Colors.white,
    );
  }

  Widget dashboardScreenBody(double height, double width) {
    return Scaffold(
      backgroundColor: Color(0xe6363450),
      appBar: AppBar(
        backgroundColor: Color(0xff363450),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              drawerStatus == FSBStatus.FSB_OPEN
                  ? Icons.close
                  : Icons.sort_rounded,
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
        title: Text(
          'Near By Buses',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        markers: _marker,
        myLocationEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }

  void getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition();
    try {
      final busDetailsData =
          Provider.of<BusDetailsProvider>(context, listen: false);
      await busDetailsData.getBusesData(
        position.latitude,
        position.longitude,
      );
      for (BusesNearBy data in busDetailsData.allBusesNearBy) {
        _marker.add(
          Marker(
            markerId: MarkerId(data.id),
            position: LatLng(data.latitude, data.longitude),
            icon: mapMarker,
            infoWindow: InfoWindow(
                title: data.busRouteNumber,
                snippet:
                    "${data.startingStop.split(" ").sublist(0, 3).join(" ")} > ${data.endingStop.split(" ").sublist(0, 3).join(" ")}"),
          ),
        );
      }
      setState(() {});
    } catch (error) {
      // Message.showErrorDialog(
      //   message: "Unable to load nearby bus stops!",
      //   icon: true,
      //   context: context,
      // );
      print("Unable to load nearby bus stops!");
    }
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/bus.png");
  }

  void _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
    LocationData locationData = await _location.getLocation();
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(locationData.latitude, locationData.longitude),
          zoom: 15,
        ),
      ),
    );
    // _location.onLocationChanged.listen((l) {});
  }
}
