import 'package:cool_app/lib/router/router.dart';
import 'package:cool_app/lib/theme/theme_data.dart';
import 'package:flutter/material.dart';

class AppCool extends StatelessWidget {
  const AppCool({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Мое крутое приложение',
      theme: AppTheme.lightTheme,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
