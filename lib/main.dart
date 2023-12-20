import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_viewer/models/region_city_model.dart';
import 'package:real_estate_viewer/screens/home_screen.dart';
import 'package:real_estate_viewer/wrapper.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(GetMaterialApp(
    home: MyApp(),
    navigatorKey: navigatorKey,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router,
      // routerDelegate: _router.routerDelegate,
      // routeInformationParser: _router.routeInformationParser,
      // routeInformationProvider: _router.routeInformationProvider,
    );
  }

  final GoRouter _router = GoRouter(
    initialLocation: '/loading',
    routes: [
      GoRoute(
        path: '/loading',
        name: 'wrapper',
        builder: (BuildContext context, GoRouterState state) => const Wrapper(),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) {
          List<RegionCity> list = state.extra as List<RegionCity>;
          return HomeScreen(regionCodeList: list);
        },
      ),
    ],
  );
}
