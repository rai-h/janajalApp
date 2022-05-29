import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:location/location.dart';

class GoogleMapApi {
  String _url = "AIzaSyALn75jlbga1lrOAVtu0x0wsP4xxGWkEBo";

  String get url => _url;
}

class LocationTracking extends StatefulWidget {
  final LatLng destinationLatLng;
  final String wowId;
  LatLng wowLatLng;
  LocationTracking(
      {Key? key,
      required this.destinationLatLng,
      required this.wowId,
      required this.wowLatLng})
      : super(key: key);

  @override
  _LocationTrackingState createState() => _LocationTrackingState();
}

class _LocationTrackingState extends State<LocationTracking> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _marker = Set<Marker>();

  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  Timer? _timer;
  LocationData? currentLocation;
  LatLng? sourcePosition;
  late Location location;
  Uint8List? _imageData;
  CameraPosition? initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = CameraPosition(
      zoom: 20,
      tilt: 80,
      bearing: 30,
      target: widget.wowLatLng,
    );

    location = Location();
    polylinePoints = PolylinePoints();

    setInitialMarkers();
    super.initState();
  }

  setInitialMarkers() async {
    _imageData = await getMarker();
    sourcePosition =
        LatLng(widget.wowLatLng.latitude, widget.wowLatLng.longitude);

    LatLng destinationPosition = LatLng(
        widget.destinationLatLng.latitude, widget.destinationLatLng.longitude);

    _marker.add(
      Marker(
        markerId: MarkerId('sourcePosition'),
        position: sourcePosition!,
        icon: BitmapDescriptor.fromBytes(_imageData!),
      ),
    );

    _marker.add(
      Marker(
        markerId: MarkerId('destinationPosition'),
        position: destinationPosition,
      ),
    );

    setPolylinesInMap();
    startLocationTimer();
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load(
      "assets/images/icons/wow.png",
    );
    return byteData.buffer.asUint8List();
  }

  getSourceLocation() async {
    LatLng? _sourceLoc =
        await WOWServiece.getWowLocation(context, widget.wowId);

    if (_sourceLoc != null) {
      currentLocation = LocationData.fromMap(
          {'latitude': _sourceLoc.latitude, 'longitude': _sourceLoc.longitude});
      updatePinsOnMap();
    }
  }

  void startLocationTimer() async {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getSourceLocation();
    });
  }

  void setPolylinesInMap() async {
    var result = await polylinePoints.getRouteBetweenCoordinates(
      GoogleMapApi().url,
      PointLatLng(widget.wowLatLng.latitude, widget.wowLatLng.longitude),
      PointLatLng(widget.destinationLatLng.latitude,
          widget.destinationLatLng.longitude),
    );
    polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((pointLatLng) {
        polylineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    setState(() {
      _polylines.add(Polyline(
        width: 5,
        polylineId: PolylineId('polyline'),
        color: Colors.blueAccent,
        points: polylineCoordinates,
      ));
    });
  }

  void updatePinsOnMap() async {
    sourcePosition = LatLng(
        currentLocation!.latitude ?? 0.0, currentLocation!.longitude ?? 0.0);
    setPolylinesInMap();
    setState(() {
      _marker.removeWhere((marker) => marker.mapsId.value == 'sourcePosition');

      _marker.add(Marker(
          markerId: MarkerId('sourcePosition'),
          position: sourcePosition!,
          icon: BitmapDescriptor.fromBytes(_imageData!)));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return initialCameraPosition == null
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new_sharp)),
                backgroundColor: Colors.white,
                elevation: 10,
                centerTitle: true,
                title: const Text(
                  '',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w700),
                ),
              ),
              body: Stack(
                children: [
                  GoogleMap(
                    onCameraMove: (position) {
                      initialCameraPosition = position;
                    },
                    myLocationButtonEnabled: true,
                    compassEnabled: true,
                    markers: _marker,
                    polylines: _polylines,
                    mapType: MapType.normal,
                    initialCameraPosition: initialCameraPosition!,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: SizedBox(
                        width: 150,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          elevation: 10,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.navigation_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                'Re-center',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          onPressed: (() async {
                            print("object");
                            initialCameraPosition = CameraPosition(
                              zoom: 20,
                              tilt: 80,
                              bearing: 30,
                              target: sourcePosition!,
                            );
                            final GoogleMapController controller =
                                await _controller.future;
                            await controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    initialCameraPosition!));
                            setState(() {});
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
