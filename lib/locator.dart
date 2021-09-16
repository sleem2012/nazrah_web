import 'package:get_it/get_it.dart';
import 'package:nazarih/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLoactor() {
  locator.registerLazySingleton(() => NavigationService());
}
