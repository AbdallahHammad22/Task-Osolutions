import 'package:flutter/foundation.dart';
import 'package:osolutions_app/core/localization/app_localization.dart';
import 'package:osolutions_app/core/utils/app_routes.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  static AppProvider get get =>
      Provider.of<AppProvider>(AppNavigator.context);

  static AppProvider get getFalse =>
      Provider.of<AppProvider>(AppNavigator.context, listen: false);

  int isLoading = 0;
  void setAppLoading() {
    isLoading = isLoading + 1;
    if (kDebugMode) {
      print(isLoading);
    }
    notifyListeners();
  }

  void removeAppLoading({bool all = false}) {
    if (isLoading > 0) {
      isLoading = isLoading - 1;
    }
    if (kDebugMode) {
      print(isLoading);
    }
    notifyListeners();
  }

  void removeAllAppLoading() {
    isLoading = 0;
    notifyListeners();
  }

  bool get isAr => languageCode == 'ar';
  String languageCode = getLocale.languageCode;
  void setLangCode(String lC) {
    languageCode = lC;
    notifyListeners();
  }
}
