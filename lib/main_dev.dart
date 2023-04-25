import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:waylt3/app_config.dart';
import 'package:waylt3/firebase_options.dart';
import 'package:waylt3/global_providers.dart';
import 'package:waylt3/main_pre.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waylt3/spotify/spotify_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init(AppEnvironment.dev);
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
  );
  container.read(spotifyServiceProvider);
  final appConfig = AppConfig(
    appEnvironment: AppEnvironment.dev,
    appName: 'Waylt3(dev)',
    child: UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );

  runApp(
    appConfig,
  );
}
