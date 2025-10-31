import 'bootstrap/bootstrap.dart';
import 'env/app_environment.dart';

Future<void> main() async {
  await bootstrap(AppEnvironment.dev);
}
