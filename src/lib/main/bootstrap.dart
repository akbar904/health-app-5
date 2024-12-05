import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gyde_app/app/app.bottomsheets.dart';
import 'package:gyde_app/app/app.dialogs.dart';
import 'package:gyde_app/app/app.locator.dart';
import 'package:gyde_app/models/enums/flavor.dart';
import 'package:gyde_app/utils/flavors/flavors.dart';

Future<void> bootstrap({
  required FutureOr<Widget> Function() builder,
  required Flavor flavor,
}) async {
  await runZonedGuarded(
    () async {
      Flavors.flavor = flavor;
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await setupLocator();
      setupDialogUi();
      setupBottomSheetUi();

      runApp(
        await builder(),
      );
    },
    (exception, stackTrace) async {},
  );
}
