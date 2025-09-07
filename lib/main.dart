import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sol_replace_revamp/src/core/globals/system_overlay.dart';
import 'package:sol_replace_revamp/src/core/globals/variables.dart';
import 'package:sol_replace_revamp/src/core/di/service_locator.dart';
import 'package:sol_replace_revamp/src/features/splash/splash_library.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await _initMethod();
  runApp(
    // DevicePreview(
    //   enabled: kDebugMode,
    //   builder: (context) =>
    MyApp(),

    // ),
  );
}

Future<void> _initMethod() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables
  await dotenv.load(fileName: "assets/.env");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];

  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw Exception(
      'Supabase URL and/or Anon Key not found in environment variables.'
      'Please check your .env file.',
    );
  }

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
    authOptions: FlutterAuthClientOptions(authFlowType: AuthFlowType.implicit),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set global dark mode overlay style
    SystemChrome.setSystemUIOverlayStyle(
      getSystemOverlayStyle(isDarkMode: false),
    );
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: false,
      builder: (_, child) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: BlocProvider(
            create: (context) => SplashBloc(
              splashRepository: ServiceLocator.instance.splashRepository,
            ),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: materialAppKey,
              title: 'SolReplace',
              home: const SplashView(),
            ),
          ),
        );
      },
    );
  }
}
