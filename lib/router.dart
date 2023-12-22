import 'package:flutter/material.dart';
import 'package:fyzo_code_challange/view/patient_profile.dart';
import 'package:fyzo_code_challange/view/splash_screen.dart';
import 'package:routemaster/routemaster.dart';

/*final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});*/

final loggedInRoute = RouteMap(
  routes: {
    Routes.SPLASH: (_) => const MaterialPage(child: SplashScreen()),
    Routes.PATIENT_PROFILE: (_) => const MaterialPage(child: PatientProfile()),
  },
);

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const PATIENT_PROFILE = _Paths.PATIENT_PROFILE;
}

abstract class _Paths {
  static const SPLASH = '/';
  static const PATIENT_PROFILE = '/patient-profile';
}
