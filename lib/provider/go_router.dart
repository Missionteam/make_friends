import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:make_friends_app/pages/auth_page/auth_checker.dart';
import 'package:make_friends_app/pages/home_page/home.dart';

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
        )
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
