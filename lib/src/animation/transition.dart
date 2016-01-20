// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Transition] mixin.
library rei.src.animation.transition;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/bezier_curve.dart';

import 'animation.dart';
import 'animation_value.dart';
import 'computed_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation which transitions between two values, [start] and [end], using
/// a bezier [curve] to compute the frames between.
///
/// A [Transition] should be used for simple animations that do not require
/// multiple keyframes. It functions similarly to a CSS transition. It is also
/// functionally equivalent to a keyframe animation with two frames.
abstract class Transition implements Animation,
                                     AnimationValue,
                                     ComputedTiming {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The animated element.
  html.Element _animatedElement;
  /// The value of the animation.
  dynamic _value;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The bezier curve.
  BezierCurve get curve;
  /// The starting value of the animation.
  dynamic get start;
  /// The ending value of the animation.
  dynamic get end;

  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  html.Element get animatedElement => _animatedElement;
  set animatedElement(html.Element value) {
    _animatedElement = value;
  }

  //---------------------------------------------------------------------
  // AnimationValue
  //---------------------------------------------------------------------

  @override
  dynamic get value => _value;

  //---------------------------------------------------------------------
  // ComputedTiming
  //---------------------------------------------------------------------

  @override
  void onLocalTimeUpdate() {
    _value = curve.solve(animationTime, duration, start, end);
  }
}
