import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_friends_app/pages/auth/auth_checker.dart';
import 'package:make_friends_app/pages/home/home.dart';
import 'package:make_friends_app/pages/review/review_page.dart';
import 'package:make_friends_app/pages/setting/setting_page.dart';

import '../widget/btm_navigation_bar.dart';

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/Home',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return BtmNavigationBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: '/AuthCheker',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: AuthChecker());
          },
        ),
        GoRoute(
          path: '/Home',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: HomePage());
          },
        ),
        GoRoute(
          path: '/Settings',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: ProfilePage());
          },
        ),
        GoRoute(
          path: '/Review',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return const NoTransitionPage(child: ReviewPage());
          },
        ),
        // GoRoute(
        //     path: '/NotificationPage',
        //     pageBuilder: (BuildContext context, GoRouterState state) {
        //       return NoTransitionPage(child: NotificationPage());
        //     },
        //     routes: <RouteBase>[
        //       GoRoute(
        //         path: 'Auth_checker',
        //         pageBuilder: (BuildContext context, GoRouterState state) =>
        //             NoTransitionPage(
        //           child: const AuthChecker(),
        //         ),
        //       ),
        // ]),
      ],
    ),
  ],
);

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
