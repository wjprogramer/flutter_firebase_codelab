import 'package:flutter_firebase_codelab/services/avatar_service.dart';
import 'package:flutter_firebase_codelab/services/avatar_service_impl.dart';
import 'package:get_it/get_it.dart';

void dependencyInjection() {
  final sl = GetIt.instance;

  sl.registerLazySingleton<AvatarService>(() => AvatarServiceImpl());
}