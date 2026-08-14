import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled4/data/api_service.dart';
import 'package:untitled4/features/auth/user_cubit.dart';
import 'package:untitled4/presentation/login_screen.dart';
import 'package:untitled4/presentation/splash_screen.dart';

import 'features/home_screen.dart';
import 'features/profile_screen.dart';

GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext, state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext, state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext, state) {
        return ProfileScreen();
      },
    ),
  ],
);

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(ApiService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
