import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/app.locator.dart';
import 'app/app.router.dart';
import 'features/app/app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await setupLocator();

  runApp(const AppView());
}