import 'package:flutter/widgets.dart';

import 'package:base_app/app/root_app.dart';
import 'package:base_app/di/container.dart';
import 'package:base_app/env/app_environment.dart';

Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment);

  runApp(RootApp(environment: environment));
}
