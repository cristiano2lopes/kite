import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kite/common/services/navigation.dart';
import 'package:kite/common/views/navigation.dart';

import 'common/services/service_setup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(KiteApp(ServiceCoordinator()));
}


class KiteApp extends StatelessWidget {
  final ServiceCoordinator serviceCoordinator;

  const KiteApp(this.serviceCoordinator, {super.key});

  void bindNavServiceWithRouter(GoRouter router){
    final navService = serviceCoordinator.getService<NavigationService>();
    navService.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final router = makeRouter(serviceCoordinator);
    bindNavServiceWithRouter(router);
    final textTheme = TextTheme(
      displaySmall: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    );
    return MaterialApp.router(
      title: 'Kite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white70,
            foregroundColor: Colors.black45,
        ),
        textTheme: textTheme,
        iconTheme: IconThemeData(
          color: Colors.black45,
          weight: 700,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.black45,
            foregroundColor: Colors.white70,
        ),
        textTheme: textTheme,
        iconTheme: IconThemeData(
          color: Colors.white70,
          weight: 700,
        ),
      ),
      routerConfig: router,
    );
}
}