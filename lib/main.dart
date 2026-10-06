import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/splash_screen.dart';
import 'core/app_settings.dart';
import 'core/app_theme.dart';
import 'core/languages.dart';
import 'core/progress_store.dart';
import 'firebase_options.dart';
import 'l10n/l10n_helpers.dart';
import 'services/auth_service.dart';
import 'widgets/app_widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([AppSettings.instance.load(), ProgressStore.instance.load()]);

  // Accounts are optional: if Firebase can't start here, the app still works as a guest.
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    AuthService.firebaseReady = true;
  } catch (_) {
    AuthService.firebaseReady = false;
  }

  runApp(const BlueSpeakApp());
}

class BlueSpeakApp extends StatelessWidget {
  const BlueSpeakApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;
    return ListenableBuilder(
      listenable: settings,
      builder: (context, _) {
        final seed = accentFor(settings.accentId).color;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => context.l10n.appName,
          theme: buildTheme(seed, Brightness.light),
          darkTheme: buildTheme(seed, Brightness.dark),
          themeMode: settings.themeMode,
          locale: settings.locale,
          supportedLocales: supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          builder: (context, child) => AppFrame(child: child ?? const SizedBox()),
          home: const SplashScreen(),
        );
      },
    );
  }
}
