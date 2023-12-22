import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:routemaster/routemaster.dart';

import '../router.dart';

bool useTimerToNavigate() {
  return use(const _NavigateTimer());
}

class _NavigateTimer extends Hook<bool> {
  const _NavigateTimer();

  @override
  ___NavigateTimerState createState() => ___NavigateTimerState();
}

class ___NavigateTimerState extends HookState<bool, _NavigateTimer> {
  late Timer _timer;
  bool isRedirect = false;

  @override
  void initHook() {
    super.initHook();
    _timer = Timer(const Duration(seconds: 3), () {
      Routemaster.of(context).push(Routes.PATIENT_PROFILE);
    });
  }

  @override
  bool build(BuildContext context) {
    return isRedirect;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}