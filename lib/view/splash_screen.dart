import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../hook/controller_for_animation.dart';
import '../hook/controller_for_offset_animation.dart';
import '../hook/timer_widget.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnimationController animationController = useControllerForAnimation();
    Animation<Offset> offset = useOffsetHook();

    useTimerToNavigate();

    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFFFFF), Color(0xffE3F3FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                FadeTransition(
                    opacity: animationController,
                    child: const Center(
                      child: FlutterLogo(
                        size: 50,
                      ),
                    )),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: SlideTransition(
                      position: offset,
                      child: Image.asset(
                        'assets/images/fyzo_logo.jpg',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}