import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_simple_template/screens/collection/collection.dart';
import 'package:flutter_simple_template/screens/navigator/navigator.dart';
import 'package:flutter_simple_template/screens/premium_screen.dart';
import 'package:flutter_simple_template/screens/quiz/quiz.dart';
import 'package:flutter_simple_template/screens/screens.dart';
import 'package:flutter_simple_template/screens/settings/settings.dart';
import 'package:flutter_simple_template/screens/store/store_view.dart';
import 'package:flutter_simple_template/services/preference_service.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preference = await SharedPreferences.getInstance();
  runZonedGuarded(
      () => runApp(
            ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (BuildContext context, Widget? child) => MyApp(
                preferences: preference,
              ),
            ),
          ), (error, stack) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stack);
  });
}

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.preferences}) : super(key: key);
  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    final navigatorModel = NavigatorModel();
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/premium_screen',
          builder: (BuildContext context, GoRouterState state) =>
              const PremiumScreen(),
        ),
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget widget) {
            return NavigatorView(
              navigatorModel: navigatorModel,
              child: widget,
            );
          },
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: QuizView(
                    quizModel: context.read<QuizModel>(),
                  ),
                );
              },
            ),
            GoRoute(
              path: '/store',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: StoreView(
                    storeModel: context.read<StoreModel>(),
                  ),
                );
              },
            ),
            GoRoute(
              path: '/collection',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const CollectionView(),
                );
              },
            ),
            GoRoute(
              path: '/settings',
              pageBuilder: (BuildContext context, GoRouterState state) {
                return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  child: const SettingsView(),
                );
              },
            ),
          ],
        ),
      ],
    );
    navigatorModel.goRouter = router;
    return MultiProvider(
      providers: [
        Provider(
          create: (BuildContext context) => PreferenceService(preferences),
        ),
        ChangeNotifierProvider<StoreModel>(
          create: (BuildContext context) => StoreModel(
            context.read<PreferenceService>(),
          ),
        ),
        ChangeNotifierProvider<QuizModel>(
          create: (BuildContext context) => QuizModel(
            context.read<StoreModel>(),
          ),
        ),
      ],
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
