class OffersModel {
  final String? amount;
  final String? promoId;
  final String? promoCode;
  final String? discount;

  OffersModel({
    this.amount,
    this.promoId,
    this.promoCode,
    this.discount,
  });

  OffersModel.fromJson(Map<String, dynamic> json)
      : amount = json['amount'] as String?,
        promoId = json['promoId'] as String?,
        promoCode = json['promoCode'] as String?,
        discount = json['discount'] as String?;

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'promoId': promoId,
        'promoCode': promoCode,
        'discount': discount
      };
}
