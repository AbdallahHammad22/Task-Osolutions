import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class ChangeLanguageProvider extends ChangeNotifier {
  bool isShow = false;
  void changeState() {
    isShow = !isShow;
    notifyListeners();
  }
}
