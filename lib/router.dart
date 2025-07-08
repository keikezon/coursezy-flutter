import 'package:coursezy/features/auth/presentation/pages/login_page.dart';
import 'package:coursezy/features/auth/presentation/pages/sign_in_page.dart';
import 'package:coursezy/features/general/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LoginPage()),
    GoRoute(path: '/home', builder: (context, state) => HomePage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/sign-in', builder: (context, state) => SignInPage()),
  ],
  initialLocation: '/sign-in',
);
