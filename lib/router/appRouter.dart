import 'package:go_router/go_router.dart';
import 'package:restobadge/services/scannerscreen.dart';
//import 'package:restobadge/views/dashboard.dart';
//import 'package:restobadge/services/AuthService.dart';
import 'package:restobadge/views/facturation.dart';
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
          builder: (context, state) => const Facturation(),
        ),
        GoRoute(
          path: '/forgotPassword',
          builder: (context, state) => const ForgotPassword(),
        ),
        GoRoute(
          path: "/scanner",
          builder: (context, state) => const ScannerScreen(),
        ),
      ],
      
    );













}