import 'package:get_it/get_it.dart';

import 'package:base_app/env/app_environment.dart';
import 'package:base_app/presentation/pages/welcome/cubit/welcome_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies(AppEnvironment environment) async {
  if (getIt.isRegistered<AppEnvironment>()) {
    getIt.unregister<AppEnvironment>();
  }

  getIt.registerSingleton<AppEnvironment>(environment);

  if (getIt.isRegistered<WelcomeCubit>()) {
    getIt.unregister<WelcomeCubit>();
  }
  getIt.registerFactory<WelcomeCubit>(WelcomeCubit.new);
}
