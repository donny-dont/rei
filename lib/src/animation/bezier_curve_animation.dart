// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BezierCurveAnimation] class.
library rei.src.animation.bezier_curve_animation;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/bezier_curve.dart';

import 'animation.dart';

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
