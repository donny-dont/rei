//  SONY CONFIDENTIAL MATERIAL. DO NOT DISTRIBUTE.
//  SNEI REI (Really Elegant Interface)
//  Copyright (C) 2014-2015 Sony Network Entertainment Inc
//  All Rights Reserved

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

  /// The values for the bezier curve.
  Float32List get curve;
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

    var range = end.toDouble() - start.toDouble();
    var time = animationTime / duration.toDouble();

    _value = (range * calculateBezierPoint(time, curve)) + start.toDouble();
  }

  //---------------------------------------------------------------------
  // IntervalAnimation
  //---------------------------------------------------------------------

  double get currentTime;
  set currentTime(double value);
  double get animationTime;
}
