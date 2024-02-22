import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qaz_booking_ui/model/guest_model.dart';
import 'package:qaz_booking_ui/themes/colors/app_colors.dart';
import 'package:qaz_booking_ui/ui/pages/archive_page/archive_page.dart';
import 'package:qaz_booking_ui/ui/pages/auth_page/auth_page.dart';
import 'package:qaz_booking_ui/ui/pages/booking_object_page/booking_object_page.dart';
import 'package:qaz_booking_ui/ui/pages/information_page/information_page.dart';
import 'package:qaz_booking_ui/ui/pages/main_page/main_page.dart';
import 'package:qaz_booking_ui/ui/pages/objects_for_booking_page/objects_for_booking_page.dart';
import 'package:qaz_booking_ui/ui/pages/guest_info_page/guest_info_page.dart';
import 'package:qaz_booking_ui/ui/pages/profile_page/profile_page.dart';
import 'package:qaz_booking_ui/ui/pages/splash_screen/splash_screen.dart';
import 'package:qaz_booking_ui/ui/widgets/custom_app_bar.dart';
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
            return '/auth';
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
          name: 'archive',
          path: '/archive',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: ArchivePage(routeState: state), key: state.pageKey);
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
        GoRoute(
          name: 'guest_info',
          path: '/guest_info',
          pageBuilder: (context, state) {
            final map = state.extra as Map<String, dynamic>;
            // if (map?['nav_instant_effect'] != true) {
            //  return MaterialPageRoute(builder: builder)
            // }
            return FadeTransitionPage(
                // isInstantEffect: true,
                child: GuestInfoPage(
                    guestModel: map['info'] == null
                        ? null
                        : GuestModel.fromMap(map['info']),
                    isRegisterGuest: map["is_register_guest"] ?? false),
                key: state.pageKey);
          },
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: ProfilePage(routeState: state), key: state.pageKey);
          },
        ),
        GoRoute(
          name: 'information',
          path: '/information',
          pageBuilder: (context, state) {
            return FadeTransitionPage(
                child: InformationPage(routeState: state), key: state.pageKey);
          },
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
          backgroundColor: AppColors.colorWhite,
          appBar: CustomAppBar(
              title: 'Not found page',
              leading: (null, () => context.go('/main'))),
          body: const Center(child: Text('Not found route'))));
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
