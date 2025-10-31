import 'package:get_it/get_it.dart';

import '../env/app_environment.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies(AppEnvironment environment) async {
  if (getIt.isRegistered<AppEnvironment>()) {
    getIt.unregister<AppEnvironment>();
  }

  getIt.registerSingleton<AppEnvironment>(environment);
}
