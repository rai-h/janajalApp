import 'package:flutter/cupertino.dart';
import 'package:janajal/models/offer_model.dart';
import 'package:janajal/models/user_model.dart';
import 'package:janajal/models/wallet_details_model.dart';

class AuthController extends ChangeNotifier {
  String? _username;
  String? get getUserName => _username;

  String? _password;
  String? get getPassword => _password;

  changeUserNamePass(String username, String password) {
    _username = username;
    _password = password;
    notifyListeners();
  }

  UserModel? _userModel;
  UserModel? get getUserModel => _userModel;

  changeUserModel(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  String _gender = '';
  String? get getGender => _gender;
  changeGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  WalletDetailModel? _walletDetailModel;
  WalletDetailModel? get getWalletDetails => _walletDetailModel;
  changeWalletDetailsModel(WalletDetailModel? walletDetailModel) {
    _walletDetailModel = walletDetailModel;
    notifyListeners();
  }

  List<OffersModel> _offerModelList = [];
  List<OffersModel> get getOfferModelList => _offerModelList;

  changeOfferModelList(List<OffersModel> offerModelList) {
    _offerModelList = offerModelList;
    notifyListeners();
  }
}
