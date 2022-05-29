class AddressFromLatLngModel {
  final List<AddressComponents>? addressComponents;
  final String? formattedAddress;
  final Geometry? geometry;
  final String? placeId;
  final PlusCode? plusCode;
  final List<String>? types;

  AddressFromLatLngModel({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.plusCode,
    this.types,
  });

  AddressFromLatLngModel.fromJson(Map<String, dynamic> json)
      : addressComponents = (json['address_components'] as List?)
            ?.map((dynamic e) =>
                AddressComponents.fromJson(e as Map<String, dynamic>))
            .toList(),
        formattedAddress = json['formatted_address'] as String?,
        geometry = (json['geometry'] as Map<String, dynamic>?) != null
            ? Geometry.fromJson(json['geometry'] as Map<String, dynamic>)
            : null,
        placeId = json['place_id'] as String?,
        plusCode = (json['plus_code'] as Map<String, dynamic>?) != null
            ? PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>)
            : null,
        types =
            (json['types'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {
        'address_components':
            addressComponents?.map((e) => e.toJson()).toList(),
        'formatted_address': formattedAddress,
        'geometry': geometry?.toJson(),
        'place_id': placeId,
        'plus_code': plusCode?.toJson(),
        'types': types
      };
}

class AddressComponents {
  final String? longName;
  final String? shortName;
  final List<String>? types;

  AddressComponents({
    this.longName,
    this.shortName,
    this.types,
  });

  AddressComponents.fromJson(Map<String, dynamic> json)
      : longName = json['long_name'] as String?,
        shortName = json['short_name'] as String?,
        types =
            (json['types'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() =>
      {'long_name': longName, 'short_name': shortName, 'types': types};
}

class Geometry {
  final Location? location;
  final String? locationType;
  final Viewport? viewport;

  Geometry({
    this.location,
    this.locationType,
    this.viewport,
  });

  Geometry.fromJson(Map<String, dynamic> json)
      : location = (json['location'] as Map<String, dynamic>?) != null
            ? Location.fromJson(json['location'] as Map<String, dynamic>)
            : null,
        locationType = json['location_type'] as String?,
        viewport = (json['viewport'] as Map<String, dynamic>?) != null
            ? Viewport.fromJson(json['viewport'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'location': location?.toJson(),
        'location_type': locationType,
        'viewport': viewport?.toJson()
      };
}

class Location {
  final double? lat;
  final double? lng;

  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as double?,
        lng = json['lng'] as double?;

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class Viewport {
  final Northeast? northeast;
  final Southwest? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport.fromJson(Map<String, dynamic> json)
      : northeast = (json['northeast'] as Map<String, dynamic>?) != null
            ? Northeast.fromJson(json['northeast'] as Map<String, dynamic>)
            : null,
        southwest = (json['southwest'] as Map<String, dynamic>?) != null
            ? Southwest.fromJson(json['southwest'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'northeast': northeast?.toJson(), 'southwest': southwest?.toJson()};
}

class Northeast {
  final double? lat;
  final double? lng;

  Northeast({
    this.lat,
    this.lng,
  });

  Northeast.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as double?,
        lng = json['lng'] as double?;

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class Southwest {
  final double? lat;
  final double? lng;

  Southwest({
    this.lat,
    this.lng,
  });

  Southwest.fromJson(Map<String, dynamic> json)
      : lat = json['lat'] as double?,
        lng = json['lng'] as double?;

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};
}

class PlusCode {
  final String? compoundCode;
  final String? globalCode;

  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  PlusCode.fromJson(Map<String, dynamic> json)
      : compoundCode = json['compound_code'] as String?,
        globalCode = json['global_code'] as String?;

  Map<String, dynamic> toJson() =>
      {'compound_code': compoundCode, 'global_code': globalCode};
}
