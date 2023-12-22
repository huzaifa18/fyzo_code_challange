import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Animation<Offset> useOffsetHook() {
  return use(_AnimOffsetForAnimationHook());
}

class _AnimOffsetForAnimationHook extends Hook<Animation<Offset>> {
  @override
  _AnimOffsetForAnimationHookState createState() => _AnimOffsetForAnimationHookState();
}

class _AnimOffsetForAnimationHookState extends HookState<Animation<Offset>, _AnimOffsetForAnimationHook> {
  late AnimationController _controller;
  late Animation<Offset> offset;

  @override
  void initHook() {
    _controller = useAnimationController(duration: const Duration(seconds: 2), initialValue: 1);
    _controller.repeat(reverse: false, period: const Duration(seconds: 3));

    offset = Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero).animate(_controller);
    _controller.forward();
  }

  @override
  Animation<Offset> build(BuildContext context) => offset;

  @override
  void dispose(){
    //dispose getting called multiple times that's why not disposing it off (debugging required here)
    //_controller.dispose();
    super.dispose();
  }
}