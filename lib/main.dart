import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked_services/stacked_services.dart';
import 'core/app/app.locator.dart';
import 'core/app/app.router.dart';
import 'core/utils/snackbar_util.dart';

Future<void> main() async {
  await setupLocator();
  setupSnackbarUi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        builder: (context , child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          debugShowCheckedModeBanner: false,
          home: child,
          navigatorKey: StackedService.navigatorKey,
          initialRoute: Routes.splashView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorObservers: [StackedService.routeObserver],
        );
      },
    );
  }
}

