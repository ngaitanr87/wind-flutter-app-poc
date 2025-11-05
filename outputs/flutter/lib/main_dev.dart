import 'package:base_app/bootstrap/bootstrap.dart';
import 'package:base_app/env/app_environment.dart';

Future<void> main() async {
  await bootstrap(AppEnvironment.dev);
}
