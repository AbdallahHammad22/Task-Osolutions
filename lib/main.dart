import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:osolutions_app/core/localization/l10n/app_localizations.dart';
import 'package:osolutions_app/core/services/api_service.dart';
import 'package:osolutions_app/core/utils/app_routes.dart';
import 'package:osolutions_app/core/di/injections.dart';
import 'package:osolutions_app/providers/app_provider.dart';
import 'package:osolutions_app/providers/category_provider.dart';
import 'package:osolutions_app/providers/task_provider.dart';
import 'package:osolutions_app/view/presentation/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInj();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        ChangeNotifierProvider(
          create: (_) =>
              TaskProvider(GetIt.I<ApiService>())..fetchTasks(),
        ),
        ChangeNotifierProvider(
          create: (_) =>
              CategoryProvider(GetIt.I<ApiService>())
                ..fetchCategories(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context
        .findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    setLocale(
      context.read<AppProvider>().isAr
          ? const Locale('ar')
          : const Locale('en'),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppNavigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: AppLocalizations.of(context)?.app_name ?? 'TODO List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        return context.read<AppProvider>().isAr
            ? const Locale('ar')
            : const Locale('en');
      },
      builder: (context, child) {
        return Directionality(
          textDirection:
              AppLocalizations.of(context)?.localeName == 'ar'
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}
