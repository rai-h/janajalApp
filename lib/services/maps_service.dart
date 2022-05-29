import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:janajal/models/address_from_latlng_model.dart';
import 'package:janajal/models/search_location.dart';
import 'package:janajal/ui/dialogs/custom_dialogs.dart';
import 'package:janajal/ui/screens/place_order_screen/widget.dart';

class MapsService {
  static Future<List<SearchLocationModel>> getLocationSuggestion(
      BuildContext context, String text) async {
    List<SearchLocationModel> suggetionList = [];
    try {
      print(text);
      http.Response response = await http.get(
          Uri.parse(
              "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$text&key=AIzaSyALn75jlbga1lrOAVtu0x0wsP4xxGWkEBo"),
          headers: <String, String>{'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        jsonDecode(response.body)['predictions'].forEach((element) {
          suggetionList.add(SearchLocationModel.fromJson(element));
        });
      }

      return suggetionList;
    } catch (e) {
      print(e);
      return suggetionList;
    }
  }

  static Future<LatLng> getLatLongFromLoctionId(
      BuildContext context, String placeId) async {
    LatLng latLng = LatLng(0.0, 0.0);
    CustomDialogs.showLoading();
    try {
      http.Response response = await http.get(
          Uri.parse(
              "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyALn75jlbga1lrOAVtu0x0wsP4xxGWkEBo&place_id=$placeId"),
          headers: <String, String>{'Content-Type': 'application/json'});
      CustomDialogs.dismissLoading();

      if (response.statusCode == 200) {
        print(jsonDecode(response.body)['results'][0]['geometry']['location']);
        if (jsonDecode(response.body)['results'].length != 0) {
          latLng = LatLng(
              jsonDecode(response.body)['results'][0]['geometry']['location']
                  ['lat'],
              jsonDecode(response.body)['results'][0]['geometry']['location']
                  ['lng']);
        }
      }

      return latLng;
    } catch (e) {
      print(e);
      return latLng;
    }
  }

  static Future<AddressFromLatLngModel> getAddressFromLatLng(
      BuildContext context, String lat, String lng) async {
    AddressFromLatLngModel addressFromLatLng = AddressFromLatLngModel();
    try {
      http.Response response = await http.get(
          Uri.parse(
              "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyALn75jlbga1lrOAVtu0x0wsP4xxGWkEBo"),
          headers: <String, String>{'Content-Type': 'application/json'});
      print(AddressFromLatLngModel.fromJson(
              jsonDecode(response.body)['results'][0])
          .formattedAddress);

      if (response.statusCode == 200) {
        addressFromLatLng = AddressFromLatLngModel.fromJson(
            jsonDecode(response.body)['results'][0]);
      }

      return addressFromLatLng;
    } catch (e) {
      print(e);
      return addressFromLatLng;
    }
  }
}
