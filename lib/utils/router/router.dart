import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/ui/pages/auth_page/auth_page.dart';
import 'package:qaz_booking_ui/ui/pages/booking_object_page/booking_object_page.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/main_page.dart';
import 'package:qaz_booking_ui/ui/pages/objects_for_booking_page/objects_for_booking_page.dart';
import 'package:qaz_booking_ui/ui/pages/splash_screen/splah_screen.dart';
import 'package:qaz_booking_ui/utils/router/fade_transition.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final shellNavigatorKey = GlobalKey<NavigatorState>();
  static final sectionShellKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      observers: [GoRouterObserver()],
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          redirect: (_, __) {
            // if (UserPref.getUserUid != '') {
            // return '/main';
            // } else {
            // return '/splash';
            return '/objects_for_booking';
            // }
          },
        ),
        GoRoute(
          path: '/auth',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: const AuthPage(), key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/splash',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: const SplashScreen(), key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/main',
          pageBuilder: (context, state) {
            return CupertinoPage(
                child: MainPage(routeState: state), key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/objects_for_booking',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: ObjectsForBookingPage(routeState: state),
                key: state.pageKey);
          },
        ),
        GoRoute(
          name: 'booking_object',
          path: '/booking_object',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: const BookingObjectPage(), key: state.pageKey);
          },
        ),
      ],
      errorBuilder: (context, state) =>
          const Scaffold(body: Center(child: Text('Not found route'))));
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPush: $route');
    log('MyTest didPush pref: $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log('MyTest didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log('MyTest didReplace: $newRoute');
  }
}
