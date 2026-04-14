import 'package:go_router/go_router.dart';
import 'package:restobadge/services/Scanner/NoPermissionScreen.dart';
import 'package:restobadge/services/Scanner/scannerscreen.dart';
import 'package:restobadge/views/Layout.dart';
import 'package:restobadge/views/dashboard.dart';
//import 'package:restobadge/views/dashboard.dart';
//import 'package:restobadge/services/AuthService.dart';
//import 'package:restobadge/views/refactor/facturationRefactor.dart';
import 'package:restobadge/views/login.dart';
import 'package:restobadge/views/forgotPassword.dart';


class Approuter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: '/',
    /*redirect: (context, state) {
      final isLoggedIn = Authservice.isLoggedIn;
      final isOnLogin = state.matchedLocation == '/login';
      if (!isLoggedIn && !isOnLogin) return '/login'; // non connecté  login
      if (isLoggedIn && isOnLogin) return '/';         // déjà connecté  accueil
      return null;                                      // rien à faire
    },*/
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const Layout(),
        ),
        GoRoute(
          path: '/forgotPassword',
          builder: (context, state) => const ForgotPassword(),
        ),
        GoRoute(
          path: "/scanner",
          builder: (context, state) => const ScannerScreen(),
        ),
        GoRoute(
          path: "/PermissionDenied",
          builder: (context, state) => const NoPermissionScreen(),
        ),
        
        GoRoute(
          path: "/Dashboard",
          builder: (context, state) => const Dashboard(),
        )
      ],      
    );













}