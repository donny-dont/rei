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
abstract class BezierCurveAnimation {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The values for the bezier curve.
  Float32List get curve;
  /// The starting value.
  num get start;
  /// The ending value.
  num get end;
  /// The duration of the animation.
  num get duration;

  //---------------------------------------------------------------------
  // AnimationValue
  //---------------------------------------------------------------------

  double get value {
    var range = end.toDouble() - start.toDouble();
    var time = animationTime / duration.toDouble();

    return (range * calculateBezierPoint(time, curve)) + start.toDouble();
  }

  //---------------------------------------------------------------------
  // IntervalAnimation
  //---------------------------------------------------------------------

  double get animationTime;
}
