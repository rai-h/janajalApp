import 'package:flutter/cupertino.dart';

class ApiBody {
  static String topHeader =
      '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"'
      ' xmlns:web="http://web.ws.batch.to.ets.com/">'
      '<soapenv:Header/>';

  static String closeEnvelope = '</soapenv:Envelope>';

  static String getAuthenticationBody(String userName, String password) {
    String body = '<soapenv:Body>'
        '<web:authenticateUser>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:authenticateUser>'
        '</soapenv:Body>';
    print(body);
    return topHeader + body + closeEnvelope;
  }

  static String getUserDetails(String userName, String password) {
    String body = '<soapenv:Body>'
        '<web:getUserDetails>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:getUserDetails>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getSignupBody(
    String firstName,
    String custMobile,
    String custEmail,
    String custUserName,
    String custPassword,
    String token,
    String signIn,
    String salutation,
    String address,
    String gender,
    String pinCode,
    String country,
    String lastName,
  ) {
    String body = '<soapenv:Body>'
        '<web:customerSignup>'
        '<custName>$firstName</custName>'
        '<custMobile>$custMobile</custMobile>'
        '<custEmail>$custEmail</custEmail>'
        '<custUserName>$custUserName</custUserName>'
        '<custPassword>$custPassword</custPassword>'
        '<token>$token</token>'
        '<signIn>$signIn</signIn>'
        '<Salutation>$salutation</Salutation>'
        '<Address>$address</Address>'
        '<Pincode>$pinCode</Pincode>'
        '<gender>$gender</gender>'
        '<Country>$country</Country>'
        '<lastName>$lastName</lastName>'
        '</web:customerSignup>'
        '</soapenv:Body>';
    print(body);
    return topHeader + body + closeEnvelope;
  }

  static String getCheckEmailBody(String email) {
    String body = '<soapenv:Body>'
        '<web:checkEmail>'
        '<custEmail>$email</custEmail>'
        '</web:checkEmail>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String getCheckMobileBody(String mobile) {
    String body = '<soapenv:Body>'
        '<web:checkMobile>'
        '<custMobile>$mobile</custMobile>'
        '</web:checkMobile>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getStateBody(
      BuildContext context, String username, String password) {
    String body = '<soapenv:Body>'
        '<web:getStateList>'
        '<userName>$username</userName>'
        '<password>$password</password>'
        '</web:getStateList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getCityBody(BuildContext context, String username,
      String password, String clusterId) {
    String body = '<soapenv:Body>'
        '<web:getCityPointDetails>'
        '<userName>$username</userName>'
        '<password>$password</password>'
        '<clusterId>$clusterId</clusterId>'
        '</web:getCityPointDetails>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getStationListBody(
      String username, String password, String cityName) {
    String body = '<soapenv:Body>'
        '<web:stationList>'
        '<userName>$username</userName>'
        '<password>$password</password>'
        '<city>$cityName</city>'
        '</web:stationList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getWalletDetailsBody(String username, String password) {
    String body = '<soapenv:Body>'
        '<web:walletList>'
        '<userName>$username</userName>'
        '<password>$password</password>'
        '</web:walletList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getWalletTxnListBody(
    String username,
    String password,
    String walletNo,
  ) {
    String body = '<soapenv:Body>'
        '<web:processUsageWalletList>'
        '<userName>$username</userName>'
        '<password>$password</password>'
        '<walletNo>$walletNo</walletNo>'
        '</web:processUsageWalletList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getWalletTopUpListBody(
    String userName,
    String password,
    String walletNo,
  ) {
    String body = '<soapenv:Body>'
        '<web:processWalletRechargeList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<walletNo>$walletNo</walletNo>'
        '</web:processWalletRechargeList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getPasswordBody(
    String email,
  ) {
    String body = '<soapenv:Body>'
        '<web:getPassword>'
        '<custEmail>$email</custEmail>'
        '</web:getPassword>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getPPCardsBody(
    String userName,
    String password,
  ) {
    String body = '<soapenv:Body>'
        '<web:cardList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:cardList>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getPPCardTxnListBody(
    String userName,
    String password,
    String cardNo,
  ) {
    String body = '<soapenv:Body>'
        '<web:processUsageCardList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<rfidCardNo>$cardNo</rfidCardNo>'
        '</web:processUsageCardList>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String getPPCardPopUpListBody(
    String userName,
    String password,
    String cardNo,
  ) {
    String body = '<soapenv:Body>'
        '<web:processRechargeCardList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<rfidCardNo>$cardNo</rfidCardNo>'
        '</web:processRechargeCardList>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String getCurrentOrderListVBody(
    String userName,
    String password,
  ) {
    String body = '<soapenv:Body>'
        '<web:getCurrentOrderList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:getCurrentOrderList>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String getPreviousOrderListVBody(
    String userName,
    String password,
  ) {
    '<soapenv:Header/>';
    String body = '<soapenv:Body>'
        '<web:getPreviousOrderList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:getPreviousOrderList>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String getCancelOrderListVBody(
    String userName,
    String password,
  ) {
    '<soapenv:Header/>';
    String body = '<soapenv:Body>'
        '<web:getCancelOrderList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:getCancelOrderList>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String getAddressListVBody(
    String userName,
    String password,
  ) {
    '<soapenv:Header/>';
    String body = '<soapenv:Body>'
        '<web:locationList>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:locationList>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String saveOrderBody(
      String userName,
      String password,
      String amount,
      String locId,
      String address,
      String deliveryWindow,
      String deliveryDate,
      String pincode,
      String qty,
      String txnId) {
    '<soapenv:Header/>';
    String body = '<soapenv:Body>'
        '<web:saveConsignmentOrder>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<Amount>$amount</Amount>'
        '<locId>$locId</locId>'
        '<Address>$address</Address>'
        '<deliveryWindow>$deliveryWindow</deliveryWindow>'
        '<qty>$qty</qty>'
        '<deliveryDate>$deliveryDate</deliveryDate>'
        '<pinCode>$pincode</pinCode> '
        '<txnId>$txnId</txnId>'
        '</web:saveConsignmentOrder>'
        '</soapenv:Body>';
    print("::::::::::::::::::::::::::::::::::::::::::::::::::");
    print(body);
    print("::::::::::::::::::::::::::::::::::::::::::");

    return topHeader + body + closeEnvelope;
  }

  static String getOrderRateBody(
    String userName,
    String password,
    String pincode,
  ) {
    String body = '<soapenv:Body>'
        '<web:getOrderRate>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<pincode>$pincode</pincode>'
        '</web:getOrderRate>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getOrderDetailsBody(
    String userName,
    String password,
    String orderId,
  ) {
    String body = '<soapenv:Body>'
        '<web:getOrderDetails>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<orderId>$orderId</orderId>'
        '</web:getOrderDetails>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String updateOrderPaymentBody(
    String userName,
    String password,
    String locId,
    String consignmentNo,
    String amount,
    String qty,
    String txnId,
  ) {
    '<soapenv:Header/>';
    String body = '<soapenv:Body>'
        '<web:updateOrderPayment>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<amt>$amount</amt>'
        '<orderNo>$consignmentNo</orderNo>'
        '<qty>$qty</qty>'
        '<locId>$locId</locId>'
        '<sgstPer>0</sgstPer>'
        '<igstPer>0</igstPer>'
        '<cgstPer>0</cgstPer>'
        '<cgstAmt>0.0</cgstAmt>'
        '<sgstAmt>0.0</sgstAmt>'
        '<igstAmt>0.0</igstAmt>'
        '<txnId>$txnId</txnId>'
        '</web:updateOrderPayment>'
        '</soapenv:Body>';
    print("::::::::::::::::::::::::::::::::::::::::::::::::::");
    print(body);
    print("::::::::::::::::::::::::::::::::::::::::::");
    return topHeader + body + closeEnvelope;
  }

  static String getSaveQrBody(
      String userName, String password, String amount, String deviceId) {
    String body = '<soapenv:Body>'
        '<web:saveQRData>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        ' <txnAmt>$amount</txnAmt>'
        '<watmDisp>$deviceId</watmDisp>'
        '</web:saveQRData>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getWowLocationBody(
      String userName, String password, String wowId) {
    String body = '<soapenv:Body>'
        '<web:getWOWLatLng>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<wowId>$wowId</wowId>'
        '</web:getWOWLatLng>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String saveWalletRecharge(
    String userName,
    String password,
    String amount,
    String discountAmt,
    String promo,
    String merchantTxnId,
    String walletNo,
  ) {
    String body = '<soapenv:Body>'
        '<web:saveWalletRecharge>'
        '<walletNo>$walletNo</walletNo>'
        '<amt>$amount</amt>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<discountamt>$discountAmt</discountamt>'
        '<promo>$promo</promo>'
        '<merchantTxnId>$merchantTxnId</merchantTxnId>'
        '</web:saveWalletRecharge>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String updateWalletRechargeBody(
      String walletNo,
      String amount,
      String userName,
      String password,
      String discountAmt,
      String promo,
      String merchantTxnId) {
    String body = '<soapenv:Body>'
        '<web:updateWalletRecharge>'
        '<walletNo>$walletNo</walletNo>'
        '<amt>$amount</amt>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<discountamt>$discountAmt</discountamt>'
        '<promo>$promo</promo>'
        '<merchantTxnId>$merchantTxnId</merchantTxnId>'
        '</web:updateWalletRecharge>'
        '</soapenv:Body>';
    print(body);
    return topHeader + body + closeEnvelope;
  }

  static String savePrepaidCardRecharge(
    String userName,
    String password,
    String amount,
    String discountAmt,
    String promo,
    String merchantTxnId,
    String rfidCardNo,
  ) {
    String body = '<soapenv:Body>'
        '<web:saveCardRecharge>'
        '<rfidCardNo>$rfidCardNo</rfidCardNo>'
        '<amt>$amount</amt>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<discountamt>$discountAmt</discountamt>'
        '<promo>$promo</promo>'
        '<merchantTxnId>$merchantTxnId</merchantTxnId>'
        '</web:saveCardRecharge>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String updatPrepaidCardRechargeBody(
      String rfidCardNo,
      String amount,
      String userName,
      String password,
      String discountAmt,
      String promo,
      String merchantTxnId) {
    String body = '<soapenv:Body>'
        '<web:updateCardRecharge>'
        '<rfidCardNo>$rfidCardNo</rfidCardNo>'
        '<amt>$amount</amt>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<discountamt>$discountAmt</discountamt>'
        '<promo>$promo</promo>'
        '<merchantTxnId>$merchantTxnId</merchantTxnId>'
        '</web:updateCardRecharge>'
        '</soapenv:Body>';
    print(body);
    return topHeader + body + closeEnvelope;
  }

  static String getStatePointDetailsBody(
    String userName,
    String password,
  ) {
    String body = '<soapenv:Body>'
        '<web:getStatePointDetails>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '</web:getStatePointDetails>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String getCheckPincodeBody(
    String userName,
    String password,
    String pincode,
  ) {
    String body = '<soapenv:Body>'
        '<web:checkPincode>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<pinCode>$pincode</pinCode>'
        '</web:checkPincode>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String loginViaOTPBody(String userName) {
    String body = '<soapenv:Body>'
        '<web:loginViaOTP>'
        '<userName>$userName</userName>'
        '</web:loginViaOTP>'
        '</soapenv:Body>';

    return topHeader + body + closeEnvelope;
  }

  static String verifyOTPBody(String userName, String password, String otp) {
    String body = '<soapenv:Body>'
        '<web:mobileVerified>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<token>$otp</token>'
        '</web:mobileVerified>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String saveLocationBody(
      {required String userName,
      required String password,
      required String city,
      required String area,
      required String landMark,
      required String pincode,
      required String stateId,
      required String locId,
      required String googleName,
      required String deliveryPoint,
      required String lat,
      required String long}) {
    String body = '<soapenv:Body>'
        '<web:saveLocation>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<Area>$area</Area>'
        '<landMark>$landMark</landMark>'
        '<pincode>$pincode</pincode>'
        '<stateId>$stateId</stateId>'
        '<locId>$locId</locId>'
        '<googleName>$googleName</googleName>'
        '<deliveryPoint>$deliveryPoint</deliveryPoint>'
        '<Lat>$lat</Lat>'
        '<Long>$long</Long>'
        '<city>$city</city>'
        '</web:saveLocation>'
        '</soapenv:Body>';

    print(body);
    return topHeader + body + closeEnvelope;
  }

  static String getOtp(String userName, String password, String mobile) {
    String body = '<soapenv:Body>'
        '<web:customerUpdateOTP>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<custMobile>$mobile</custMobile>'
        '</web:customerUpdateOTP>'
        '</soapenv:Body>';
    return topHeader + body + closeEnvelope;
  }

  static String updateMobileVerification(String userName, String password,
      String mobile, String custId, String otp) {
    String body = '<soapenv:Body>'
        '<web:updateMobileVerification>'
        '<userName>$userName</userName>'
        '<password>$password</password>'
        '<custMobile>$mobile</custMobile>'
        '<custId>$custId</custId>'
        '<token>$otp</token>'
        '</web:updateMobileVerification>'
        '</soapenv:Body>';
    print(body);
    return topHeader + body + closeEnvelope;
  }
}
