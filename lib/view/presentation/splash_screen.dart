import 'package:flutter/material.dart';
import 'package:osolutions_app/core/localization/app_localization.dart';
import 'package:osolutions_app/core/utils/widget/main_text.dart';
import 'package:osolutions_app/view/task/screens/task_list_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const TaskListScreen()),
      );
    });

    return Scaffold(
      body: Center(child: MainText.pageTitle(tr(context).app_name)),
    );
  }
}
