class DeliveryAddressModel {
  final int? custId;
  final String? landMark;
  final String? area;
  final String? userName;
  final String? googleCity;
  final String? stateName;
  final String? city;
  final String? pincode;
  final String? custEmail;
  final String? stateId;
  final String? deliveryPoint;
  final String? longitude;
  final String? custName;
  final String? custMobile;
  final String? locId;
  final int? desingId;
  final String? lat;

  DeliveryAddressModel({
    this.custId,
    this.landMark,
    this.area,
    this.userName,
    this.googleCity,
    this.stateName,
    this.city,
    this.pincode,
    this.custEmail,
    this.stateId,
    this.deliveryPoint,
    this.longitude,
    this.custName,
    this.custMobile,
    this.locId,
    this.desingId,
    this.lat,
  });

  DeliveryAddressModel.fromJson(Map<String, dynamic> json)
      : custId = json['custId'] as int?,
        landMark = json['landMark'] as String?,
        area = json['Area'] as String?,
        userName = json['UserName'] as String?,
        googleCity = json['googleCity'] as String?,
        stateName = json['StateName'] as String?,
        city = json['city'] as String?,
        pincode = json['pincode'] as String?,
        custEmail = json['custEmail'] as String?,
        stateId = json['StateId'] as String?,
        deliveryPoint = json['deliveryPoint'] as String?,
        longitude = json['longitude'] as String?,
        custName = json['custName'] as String?,
        custMobile = json['custMobile'] as String?,
        locId = json['locId'] as String?,
        desingId = json['DesingId'] as int?,
        lat = json['lat'] as String?;

  Map<String, dynamic> toJson() => {
        'custId': custId,
        'landMark': landMark,
        'Area': area,
        'UserName': userName,
        'googleCity': googleCity,
        'StateName': stateName,
        'city': city,
        'pincode': pincode,
        'custEmail': custEmail,
        'StateId': stateId,
        'deliveryPoint': deliveryPoint,
        'longitude': longitude,
        'custName': custName,
        'custMobile': custMobile,
        'locId': locId,
        'DesingId': desingId,
        'lat': lat
      };
}
