import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fyzo_code_challange/router.dart';
import 'package:routemaster/routemaster.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In most cases it's unnecessary to write own hooks for simple animations.
    // I've rewritten this code to use just a single animation controller hook
    // and coupled the offset, fade and navigation to it.
    // This has the benefit that this widget/file is the single source of truth
    // for the entire animation and the navigation behavior.
    // Complex animations or repeating naviation patterns could however be
    // extracted into their own hooks.

    // Setup the animation controller and duration
    final controller = useAnimationController(duration: const Duration(seconds: 3));

    // Define the slide transition tween offsets
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(controller);

    // Start the animation and register a onComplete callback to navigate to
    // the next page
    final router = Routemaster.of(context);
    controller.forward().whenComplete(() => router.push(Routes.PATIENT_PROFILE));

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
                // TODO The animation is now from 0.0 to 1.0, we need to reverse it to get the previous effect
                opacity: controller,
                child: const Center(
                  child: FlutterLogo(size: 50),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: Image.asset(
                    'assets/images/fyzo_logo.jpg',
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}