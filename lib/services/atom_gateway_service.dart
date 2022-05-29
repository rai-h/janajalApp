import 'package:crypto/crypto.dart';
import 'dart:convert';

class AtomPaynetz {
  final String login;
  final String pass;
  final String ttype = "NBFundTransfer";
  final String prodid;
  final String amt;
  final String txnid;
  final String txncurr = "INR";
  final String txnscamt = "0";
  final String clientcode = "NAVIN";
  final String date;
  final String custacc;
  final String responsehashKey;
  final String requesthashKey;
  final String mode;

  AtomPaynetz({
    required this.login,
    required this.pass,
    required this.prodid,
    required this.amt,
    required this.date,
    required this.txnid,
    required this.custacc,
    required this.requesthashKey,
    required this.responsehashKey,
    required this.mode,
  });

  getUrl() {
    var signature = this.createSignature();
    var bytes = utf8.encode(this.clientcode);
    var clientcodeEncoded = base64.encode(bytes);
    var url = "";
    if (this.mode == "live") {
      url = "https://payments.atomtech.in/paynetz/epi/fts?login=" +
          this.login +
          "&pass=" +
          this.pass +
          "&ttype=" +
          this.ttype +
          "&prodid=" +
          this.prodid +
          "&amt=" +
          this.amt +
          "&txncurr=" +
          this.txncurr +
          "&txnscamt=" +
          this.txnscamt +
          "&clientcode=" +
          clientcodeEncoded +
          "=&txnid=" +
          this.txnid +
          "&date=" +
          this.date +
          "&custacc=" +
          this.custacc +
          "&ru=https://atomtech.in/atomfluttersdk/index.php&signature=" +
          signature;
    } else {
      url = "https://paynetzuat.atomtech.in/paynetz/epi/fts?login=" +
          this.login +
          "&pass=" +
          this.pass +
          "&ttype=" +
          this.ttype +
          "&prodid=" +
          this.prodid +
          "&amt=" +
          this.amt +
          "&txncurr=" +
          this.txncurr +
          "&txnscamt=" +
          this.txnscamt +
          "&clientcode=" +
          clientcodeEncoded +
          "=&txnid=" +
          this.txnid +
          "&date=" +
          this.date +
          "&custacc=" +
          this.custacc +
          "&ru=https://atomtech.in/atomfluttersdk/index.php&signature=" +
          signature;
    }
    return (url);
  }

  createSignature() {
    String signatureString = this.login +
        this.pass +
        this.ttype +
        this.prodid +
        this.txnid +
        this.amt +
        this.txncurr;
    var bytes = utf8.encode(signatureString);
    var key = utf8.encode(this.requesthashKey);
    var hmacSha512 = new Hmac(sha512, key); // HMAC-SHA256
    var digest = hmacSha512.convert(bytes);
    return (digest.toString());
  }

  validateSignature(
      {mmp_txn,
      mer_txn,
      f_code,
      prod,
      discriminator,
      amt,
      bank_txn,
      signature}) {
    String signatureString =
        mmp_txn + mer_txn + f_code + prod + discriminator + amt + bank_txn;
    var bytes = utf8.encode(signatureString);
    var key = utf8.encode(this.responsehashKey);
    var hmacSha512 = new Hmac(sha512, key); // HMAC-SHA256
    var digest = hmacSha512.convert(bytes);
    var genSig = digest.toString();
    if (signature == genSig) {
      return true;
    } else {
      return false;
    }
  }
}
