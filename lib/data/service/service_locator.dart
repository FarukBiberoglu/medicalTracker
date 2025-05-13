import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled19/data/cache/hive_cache_service.dart';
import 'package:untitled19/data/service/notification_service.dart';
import '../../firebase_options.dart';
import '../../presentation/authentication/cubit/auth/auth_cubit.dart';
import '../../presentation/authentication/cubit/chat/chat_cubit.dart';
import '../../router/app_router.dart';
import '../repositories/auth_repositories.dart';
import '../repositories/chat_repositories.dart';
import '../repositories/contact_repositories.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    await NotificationService.I.init() ;
    final cacheService = HiveCacheService();
    await cacheService.init();
  getIt.registerLazySingleton(()=>cacheService);
  getIt.registerLazySingleton(() => AppRouter());
  getIt.registerLazySingleton<FirebaseFirestore>(
          () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => AuthRepository());
  getIt.registerLazySingleton(() => ContactRepository());
  getIt.registerLazySingleton(() => ChatRepository());
  getIt.registerLazySingleton(
        () => AuthCubit(
      authRepository: AuthRepository(),
    ),
  );
  getIt.registerFactory(
        () => ChatCubit(
      chatRepository: ChatRepository(),
      currentUserId: getIt<FirebaseAuth>().currentUser!.uid,
    ),
  );
}