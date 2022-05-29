class OrderDetailsModel {
  final String? wowLong;
  final String? orderNo;
  final String? address;
  final String? wowLat;
  final String? longtitude;
  final String? latitude;
  final String? orderStatus;
  final String? driverName;
  final String? wowId;

  OrderDetailsModel({
    this.wowLong,
    this.orderNo,
    this.address,
    this.wowLat,
    this.longtitude,
    this.latitude,
    this.orderStatus,
    this.driverName,
    this.wowId,
  });

  OrderDetailsModel.fromJson(Map<String, dynamic> json)
      : wowLong = json['wowLong'] as String?,
        orderNo = json['orderNo'] as String?,
        address = json['address'] as String?,
        wowLat = json['wowLat'] as String?,
        longtitude = json['longtitude'] as String?,
        latitude = json['latitude'] as String?,
        orderStatus = json['orderStatus'] as String?,
        driverName = json['driverName'] as String?,
        wowId = json['wowId'] as String?;

  Map<String, dynamic> toJson() => {
        'wowLong': wowLong,
        'orderNo': orderNo,
        'address': address,
        'wowLat': wowLat,
        'longtitude': longtitude,
        'latitude': latitude,
        'orderStatus': orderStatus,
        'driverName': driverName,
        'wowId': wowId
      };
}
