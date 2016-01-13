// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BezierCurveAnimation] class.
library rei.src.animation.bezier_curve_animation;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/bezier_curve.dart';

import 'animation.dart';
import 'animation_target_value.dart';
import 'computed_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation whose value is determined by a bezier curve.
abstract class BezierCurveAnimation<T> implements Animation<T> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  T _value;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The bezier curve.
  BezierCurve<T> get curve;
  /// The starting value.
  T get start;
  /// The duration of the animation.
  num get duration;

  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  @override
  T get value => _value;

  @override
  void timeUpdate(double dt) {
    currentTime += dt;

    _value = curve.solve(animationTime, duration, start, end);
  }

  //---------------------------------------------------------------------
  // IntervalAnimation
  //---------------------------------------------------------------------

  double get currentTime;
  set currentTime(double value);
  double get animationTime;
}

/// An animation whose computed value is based on a single bezier curve.
///
/// A [BezierCurveAnimation] is the simplest animation type and functions the
/// same as a CSS transition. It contains a [start] value and an [end] value
/// with which the animation is computed using over the [duration].
abstract class BezierCurveAnimation2<T> implements ComputedTiming, Animation2 {
  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The bezier curve.
  BezierCurve<T> get curve;
  /// The starting value of the animation.
  T get start;
  /// The ending value of the animation.
  T get end;

  //---------------------------------------------------------------------
  // ComputedTiming
  //---------------------------------------------------------------------

  @override
  void onLocalTimeUpdate() {
    var value = curve.solve(animationTime, duration, start, end) as num;

    applyAnimationTargetValue(animationTarget, animatedElement, value);
  }
}
