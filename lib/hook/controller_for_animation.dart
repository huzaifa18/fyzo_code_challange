import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

AnimationController useControllerForAnimation() {
  return use(_AnimControllerForAnimationHook());
}

class _AnimControllerForAnimationHook extends Hook<AnimationController> {
  @override
  _AnimControllerForAnimationHookState createState() => _AnimControllerForAnimationHookState();
}

class _AnimControllerForAnimationHookState extends HookState<AnimationController, _AnimControllerForAnimationHook> {
  late AnimationController _animController;

  @override
  void initHook() {
    _animController = useAnimationController(duration: const Duration(seconds: 3), initialValue: 1);
    _animController.repeat(reverse: false);
  }

  @override
  AnimationController build(BuildContext context) => _animController;

  @override
  void dispose() {
    //dispose getting called multiple times that's why not disposing it off (debugging required here)
    //_animController.dispose();
    super.dispose();
  }
}