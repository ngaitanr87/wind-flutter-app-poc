import 'package:flutter/widgets.dart';

import '../app/root_app.dart';
import '../di/container.dart';
import '../env/app_environment.dart';

Future<void> bootstrap(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment);

  runApp(RootApp(environment: environment));
}
