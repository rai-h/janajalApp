class WalletDetailModel {
  int? custId;
  String? balance;
  String? walletId;
  String? promoBal;
  String? email;
  String? expiryDate;
  String? mobile;
  String? walletNo;
  String? custName;

  WalletDetailModel(
      {this.custId,
      this.balance,
      this.walletId,
      this.promoBal,
      this.email,
      this.expiryDate,
      this.mobile,
      this.walletNo,
      this.custName});

  WalletDetailModel.fromJson(Map<String, dynamic> json) {
    custId = json['custId'];
    balance = json['balance'];
    walletId = json['walletId'];
    promoBal = json['promoBal'];
    email = json['Email'];
    expiryDate = json['expiryDate'];
    mobile = json['Mobile'];
    walletNo = json['walletNo'];
    custName = json['custName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custId'] = this.custId;
    data['balance'] = this.balance;
    data['walletId'] = this.walletId;
    data['promoBal'] = this.promoBal;
    data['Email'] = this.email;
    data['expiryDate'] = this.expiryDate;
    data['Mobile'] = this.mobile;
    data['walletNo'] = this.walletNo;
    data['custName'] = this.custName;
    return data;
  }
}
