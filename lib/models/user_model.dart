class UserModel {
  String? name;
  String? custId;
  String? lastName;
  String? email;
  String? address;
  String? mobile;
  String? salutation;
  String? country;
  String? pincode;

  UserModel(
      {this.name,
      this.custId,
      this.lastName,
      this.email,
      this.address,
      this.mobile,
      this.salutation,
      this.country,
      this.pincode});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    custId = json['custId'].toString();
    lastName = json['lastName'];
    email = json['Email'];
    address = json['Address'];
    mobile = json['Mobile'];
    salutation = json['Salutation'];
    country = json['Country'];
    pincode = json['Pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['custId'] = this.custId;
    data['lastName'] = this.lastName;
    data['Email'] = this.email;
    data['Address'] = this.address;
    data['Mobile'] = this.mobile;
    data['Salutation'] = this.salutation;
    data['Country'] = this.country;
    data['Pincode'] = this.pincode;
    return data;
  }
}
