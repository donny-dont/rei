// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BezierCurveAnimation] class.
library rei.src.animation.bezier_curve_animation;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:typed_data';

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation.dart';
import 'bezier_curve.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation whose value is determined by a bezier curve.
abstract class BezierCurveAnimation implements Animation<num> {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  double _value;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The bezier curve.
  BezierCurve get curve;
  /// The starting value.
  num get start;
  /// The duration of the animation.
  num get duration;

  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  @override
  double get value => _value;

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
