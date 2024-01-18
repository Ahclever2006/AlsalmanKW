import 'dart:async';
import 'dart:isolate';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:requests_inspector/requests_inspector.dart';

import 'di/injector.dart';
import 'features/splash/presentation/pages/splash_page.dart';
import 'firebase_options.dart';
import 'res/style/theme.dart';
import 'routes/routes.dart';

const isRelease = false;
const inspectorEnabled = true;

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    await Firebase.initializeApp(
        name: 'AlsalmanKW', options: DefaultFirebaseOptions.currentPlatform);

    await _initCrashLytics();

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'lib/res/translations',
        fallbackLocale: const Locale('en'),
        child: RequestsInspector(
          enabled: inspectorEnabled,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => Injector().mainLayoutCubit),
              BlocProvider(
                  create: (context) => Injector().addressCubit..getAddresses()),
              BlocProvider(create: (context) => Injector().authCubit),
              BlocProvider(create: (context) => Injector().cartCubit),
              BlocProvider(create: (context) => Injector().splashCubit),
            ],
            child: const MyApp(),
          ),
        ),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

Future<void> _initCrashLytics() async {
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance
        .recordError(errorAndStacktrace.first, errorAndStacktrace.last);
  }).sendPort);
  if (kDebugMode)
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final notificationService = Injector().notificationService;
      await Future.wait([
        notificationService.cancelAll(),
        notificationService.getDeviceTokenId(),
      ]);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp(
        home: const SplashPage(),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: theme,
        title: 'ALSALMAN',
        routes: routes,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
