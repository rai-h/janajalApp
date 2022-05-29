import 'package:flutter/cupertino.dart';
import 'package:janajal/main.dart';
import 'package:janajal/services/wow_service.dart';
import 'package:janajal/ui/screens/about_us_screen/about_us.dart';
import 'package:janajal/ui/screens/delivery_screen/delivery_screen.dart';
import 'package:janajal/ui/screens/home_screen/home_screen.dart';
import 'package:janajal/ui/screens/profile_screen/profile_screen.dart';
import 'package:janajal/ui/screens/wallet_screen/wallet_screen.dart';
import 'package:janajal/ui/screens/watm_locator_screen/watm_locator_screen.dart';

class UiController extends ChangeNotifier {
  int _navbarIndex = 0;
  Widget mainWidget = const HomeScreen();
  int get navbarIndex => _navbarIndex;
  changeNavbarIndex(int index) {
    _navbarIndex = index;
    switch (_navbarIndex) {
      case 0:
        mainWidget = HomeScreen();
        break;
      case 1:
        mainWidget = DeliveryScreen();
        break;
      case 2:
        mainWidget = WalletScreen();
        break;
      case 3:
        mainWidget = ProfileScreen();
        break;
      case 4:
        mainWidget = AboutUsScreen();
        break;
      default:
        mainWidget = Container();
        break;
    }
    notifyListeners();
  }

  int _selectedDeliveryTab = 0;
  int get selectedDeliveryTab => _selectedDeliveryTab;
  changeDeliveryTab(int index, BuildContext context) async {
    _selectedDeliveryTab = index;
    switch (index) {
      case 0:
        await WOWServiece.getCurrentOrderListList(context);
        break;
      case 1:
        await WOWServiece.getPreviousOrderListList(context);
        break;
      case 2:
        await WOWServiece.getCancelOrderListList(context);
        break;

      default:
    }
    notifyListeners();
  }
}
