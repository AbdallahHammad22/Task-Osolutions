import 'package:osolutions_app/core/helpers/extensions/assetss_widgets.dart';
import 'package:osolutions_app/core/localization/app_localization.dart';
import 'package:osolutions_app/core/utils/app_color.dart';
import 'package:osolutions_app/core/utils/widget/main_text.dart';
import 'package:osolutions_app/providers/app_provider.dart';
import 'package:osolutions_app/main.dart';
import 'package:flutter/material.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({
    super.key,
    this.textColor = AppColors.white,
  });
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        AppProvider.getFalse.isAr
            ? await setLocale('en').then((value) async {
                MyApp.setLocale(context, value);
                AppProvider.getFalse.setLangCode('en');
              })
            : await setLocale('ar').then((value) async {
                MyApp.setLocale(context, value);
                AppProvider.getFalse.setLangCode('ar');
              });
      },
      child: Row(
        children: [
          MainText.title(
            AppProvider.getFalse.isAr ? 'En' : 'Ar',
            color: textColor,
          ),
          5.wSize,
          Icon(Icons.language, size: 20),
        ],
      ),
    );
  }
}
