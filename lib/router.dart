import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taxverse_web/core/constants/routers.dart';
import 'package:taxverse_web/features/drawer_screen/pages/drawer_screeen.dart';
import 'package:taxverse_web/features/home/pages/homepage.dart';

class GoRouterLocal {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: Routers.homepage,
        pageBuilder: (context, state) => const MaterialPage(child: Homepage()),
      ),
      GoRoute(
        path: Routers.drawerScreen,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: DrawerScreeen(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          );
        },
      ),
    ],
  );
}
