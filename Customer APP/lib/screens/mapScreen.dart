import 'package:MyBMTC/helper/message.dart';
import 'package:MyBMTC/model/busDetailsClass.dart';
import 'package:MyBMTC/providers/busDetails.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  static final route = 'MapScreen';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapScreen> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();
  int zoomNumber = 10;

  Set<Marker> _marker = {};
  BitmapDescriptor mapMarker;
  @override
  void initState() {
    super.initState();
    setCustomMarker();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Position position = await Geolocator().getCurrentPosition();
    try {
      final busDetailsData =
          Provider.of<BusDetailsProvider>(context, listen: false);
      await busDetailsData.getMarkerData(
        position.latitude,
        position.longitude,
      );
      for (BusStop data in busDetailsData.listOfBusDetails.listOfBusStops) {
        _marker.add(
          Marker(
            markerId: MarkerId(data.id),
            position: LatLng(data.latitude, data.longitude),
            icon: mapMarker,
            infoWindow: InfoWindow(
              title: data.busStop,
            ),
          ),
        );
      }
      setState(() {});
    } catch (error) {
      Message.showErrorDialog(
        message: "Unable to load nearby bus stops!",
        icon: true,
        context: context,
      );
    }
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/images/marker2.png");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialcameraposition),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                markers: _marker,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
