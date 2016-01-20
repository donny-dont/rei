// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [EasingValue] mixin.
library rei.src.transform.easing_value;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/bezier_curve.dart';
import 'package:rei/easing_function.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A behavior that takes an easing value and exposes the equivalent bezier
/// curve to be used by an animation.
@behavior
abstract class EasingValue {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The type to check for when serializing the easing curve.
  ///
  /// Unfortunately the serialization needs to be done in the defining class so
  /// this value can be used there to determine if the easing value is the one
  /// being serialized.
  static const Type easingType = dynamic;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The bezier curve to use when computing the animation value.
  BezierCurve _curve;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The bezier curve to use when computing the animation value.
  BezierCurve get curve => _curve;

  /// The easing function or bezier curve to use when computing the animation
  /// value.
  dynamic get easing;

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @Observe('easing')
  void easingChanged(dynamic value) {
    var curveValues = (value is EasingFunction)
        ? getEasingCurve(value)
        : value;

    // \TODO actually base curve on <T>
    _curve = new BezierCurveScalar(curveValues as List<num>);
  }
}
