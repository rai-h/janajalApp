import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:janajal/services/watm_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

class WatmLocatorScree extends StatefulWidget {
  const WatmLocatorScree({Key? key}) : super(key: key);

  @override
  State<WatmLocatorScree> createState() => _WatmLocatorScreeState();
}

class _WatmLocatorScreeState extends State<WatmLocatorScree> {
  List<dynamic> stateList = [];
  List<dynamic> cityList = [];
  List<dynamic> stationList = [];
  Map<String, dynamic>? selectedState;
  Map<String, dynamic>? selectedCity;

  @override
  void initState() {
    callGetStateApi();
    // TODO: implement initState
    super.initState();
  }

  callGetStateApi() async {
    stateList = await WatmServices.getStateList(context);
    setState(() {});
  }

  void _launchUrl(url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Future.delayed(Duration(milliseconds: 100), () {
                Navigator.of(context).pop();
              });
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          'home_screen.locate_watm'.tr(),
          style: TextStyle(
              fontSize: 24,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'watm_locator_screnn.select_state'.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<Map<String, dynamic>>(
                    isExpanded: true,
                    hint: Text(
                      'watm_locator_screnn.select_state'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.grey.shade400),
                    ),
                    items: stateList
                        .map((item) => DropdownMenuItem<Map<String, dynamic>>(
                              value: item,
                              child: Text(
                                item['statename'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey.shade500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedState,
                    onChanged: (value) async {
                      selectedState = value as Map<String, dynamic>;
                      selectedCity = null;
                      stationList = [];
                      cityList = await WatmServices.getCityList(
                          context, selectedState!['clusterId']);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    buttonPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade50),
                    buttonElevation: 4,
                    itemHeight: 35,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 250,
                    dropdownPadding: null,
                    dropdownFullScreen: true,
                    selectedItemHighlightColor: Colors.blue.shade100,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.shade100,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text(
                    'watm_locator_screnn.select_city'.tr(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<Map<String, dynamic>>(
                    isExpanded: true,
                    hint: Text(
                      'watm_locator_screnn.select_city'.tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.grey.shade400),
                    ),
                    items: cityList
                        .map((item) => DropdownMenuItem<Map<String, dynamic>>(
                              value: item,
                              child: Text(
                                item['cityName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                    color: Colors.grey.shade500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedCity,
                    onChanged: (value) async {
                      selectedCity = value as Map<String, dynamic>;
                      stationList = [];
                      stationList = await WatmServices.getStationList(
                          context, selectedCity!['cityName']);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                    ),
                    buttonPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    buttonDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade50),
                    buttonElevation: 4,
                    itemHeight: 35,
                    itemPadding: const EdgeInsets.only(left: 14, right: 14),
                    dropdownMaxHeight: 250,
                    dropdownPadding: null,
                    dropdownFullScreen: true,
                    selectedItemHighlightColor: Colors.blue.shade100,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.grey.shade100,
                    ),
                    dropdownElevation: 8,
                    scrollbarRadius: const Radius.circular(40),
                    scrollbarThickness: 6,
                    scrollbarAlwaysShow: true,
                    offset: const Offset(0, 0),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: stationList.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            MapsLauncher.launchCoordinates(
                                double.parse(stationList[index]["latitude"]),
                                double.parse(stationList[index]["longitude"]));
                          },
                          child: Material(
                            color: Colors.blueGrey.shade50,
                            borderRadius: BorderRadius.circular(10),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    stationList[index]['address'],
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue.shade800,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'watm_locator_screnn.location'.tr() +
                                            " : ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        stationList[index]['platform'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        'watm_locator_screnn.locate'.tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.red.shade900,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
