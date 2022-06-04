import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:janajal/models/address_from_latlng_model.dart';
import 'package:janajal/models/search_location.dart';
import 'package:janajal/services/address_service.dart';
import 'package:janajal/services/maps_service.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/helping_widget/custom_textfield.dart';
import 'package:janajal/ui/helping_widget/round_button.dart';
import 'package:janajal/utils/janajal.dart';
import 'package:location/location.dart' as loc;

import 'package:location/location.dart';

class AddressMapScreen extends StatefulWidget {
  final String address;
  final String city;
  final String state;
  final String pincode;
  final String landMark;
  final String deliveryPoint;
  final String stateId;
  final String locId;
  const AddressMapScreen(
      {Key? key,
      this.locId = "0",
      required this.address,
      required this.city,
      required this.state,
      required this.deliveryPoint,
      required this.landMark,
      required this.pincode,
      required this.stateId})
      : super(key: key);

  @override
  State<AddressMapScreen> createState() => _AddressMapScreenState();
}

class _AddressMapScreenState extends State<AddressMapScreen> {
  TextEditingController addressController = TextEditingController();

  loc.Location location = loc.Location();

  Set<Marker> _marker = Set<Marker>();
  FocusNode _focus = FocusNode();
  LatLng selectedLatLng = LatLng(0.0, 0.0);
  bool isTextFieldFocus = false;
  List<SearchLocationModel> suggetionList = [];
  AddressFromLatLngModel addressFromLatLngModel = AddressFromLatLngModel();
  Completer<GoogleMapController> _controller = Completer();
  String initialLocationText = 'India';
  CameraPosition initialCameraPosition = CameraPosition(
    zoom: 0,
    target: LatLng(0.0, 0.0),
  );

  @override
  void initState() {
    getInitialLoction();
    initialLocationText =
        '${widget.city},${widget.state}-${widget.pincode},India';
    _focus.addListener(_focusListner);
    // TODO: implement initState
    super.initState();
  }

  getInitialLoction() async {
    suggetionList = await MapsService.getLocationSuggestion(
        context, '${widget.city},${widget.state}-${widget.pincode},India');

    LatLng _initialLatLng = await MapsService.getLatLongFromLoctionId(
        context, suggetionList[0].placeId!);
    initialCameraPosition = CameraPosition(zoom: 15, target: _initialLatLng);
    addressFromLatLngModel = await MapsService.getAddressFromLatLng(
        context,
        _initialLatLng.latitude.toString(),
        _initialLatLng.longitude.toString());
    _marker.add(Marker(
      markerId: MarkerId('sourcePosition'),
      position: _initialLatLng,
    ));
    selectedLatLng = _initialLatLng;
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(initialCameraPosition));
    setState(() {});
  }

  void _focusListner() {
    isTextFieldFocus = _focus.hasFocus;
    setState(() {});
  }

  void relocateMarker(LatLng latLng) async {
    selectedLatLng = latLng;
    _marker.removeWhere((marker) => marker.mapsId.value == 'sourcePosition');
    _marker.add(Marker(
      markerId: MarkerId('sourcePosition'),
      position: latLng,
    ));
    addressFromLatLngModel = await MapsService.getAddressFromLatLng(
        context, latLng.latitude.toString(), latLng.longitude.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                if (isTextFieldFocus) {
                  _focus.unfocus();
                } else {
                  Future.delayed(Duration(milliseconds: 100), () {
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Icon(Icons.arrow_back_ios_new_sharp)),
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            'Locate Your Address',
            style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onTap: ((LatLng latLng) async {
                relocateMarker(latLng);
              }),
              markers: _marker,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 10,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                addressFromLatLngModel.addressComponents == null
                                    ? " "
                                    : addressFromLatLngModel
                                            .addressComponents![2].longName ??
                                        "",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                )),
                            subtitle: Text(
                              addressFromLatLngModel.formattedAddress ?? "",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                          MaterialButton(
                            color: Colors.blue,
                            elevation: 10,
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Text('Save',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                )),
                            onPressed: (() {
                              AddressServices.saveAddressList(context,
                                  city: widget.city,
                                  area: widget.address,
                                  landMark: widget.landMark,
                                  pincode: widget.pincode,
                                  stateId: widget.stateId,
                                  locId: widget.locId,
                                  googleName:
                                      addressFromLatLngModel.formattedAddress ??
                                          "",
                                  deliveryPoint: widget.deliveryPoint,
                                  lat: selectedLatLng.latitude.toString(),
                                  long: selectedLatLng.longitude.toString());
                            }),
                          ),
                        ],
                      ),
                      width: size.width,
                      height: 150,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Material(
                  elevation: 10,
                  color: Colors.grey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Flexible(
                            child: CustomTextField(
                              onChange: (String text) async {
                                suggetionList =
                                    await MapsService.getLocationSuggestion(
                                        context, '$text $initialLocationText');
                                setState(() {});
                              },
                              prefixIcon: Icon(
                                Icons.location_on_rounded,
                              ),
                              suffixIcon: Icon(Icons.search),
                              focus: _focus,
                              controller: addressController,
                              text: "Search Address",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              location.getLocation().then((value) async {
                                if (value.latitude != null) {
                                  initialCameraPosition = CameraPosition(
                                    zoom: 15,
                                    target: LatLng(
                                        value.latitude!, value.longitude!),
                                  );
                                  final GoogleMapController controller =
                                      await _controller.future;
                                  await controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          initialCameraPosition));
                                  relocateMarker(LatLng(
                                      value.latitude!, value.longitude!));
                                  setState(() {});
                                } else {
                                  CustomDialogs.showToast(
                                      'Please turn on your location');
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                isTextFieldFocus
                    ? Expanded(
                        child: Container(
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: suggetionList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    LatLng latLng = await MapsService
                                        .getLatLongFromLoctionId(
                                            context, suggetionList[0].placeId!);
                                    _focus.unfocus();
                                    initialCameraPosition = CameraPosition(
                                      zoom: 15,
                                      target: latLng,
                                    );
                                    relocateMarker(latLng);
                                    final GoogleMapController controller =
                                        await _controller.future;
                                    await controller.animateCamera(
                                        CameraUpdate.newCameraPosition(
                                            initialCameraPosition));
                                  },
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Janajal.primaryColor,
                                    ),
                                    title: Text(
                                      suggetionList[index]
                                          .structuredFormatting!
                                          .mainText!,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      suggetionList[index].description!,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ))
                    : Container()
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_focusListner);
    _focus.dispose();
  }
}
