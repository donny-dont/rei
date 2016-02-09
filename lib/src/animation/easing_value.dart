// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [EasingValue] mixin.
library rei.src.transform.easing_value;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import '../../bezier_curve.dart';
import '../../easing_function.dart';

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
  static const Type easingType = null;

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
  set easing(dynamic value);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Creates the curve associated with the easing value.
  ///
  /// This is here because the observer only seems to work when the element is
  /// already in the DOM. This seems to be needed when creating things in code
  /// and can be used as a trigger when the value is changed.
  ///
  /// \TODO Verify if needed
  void createCurve() {
    var curveValues = (easing is EasingFunction)
        ? getEasingCurve(easing)
        : easing;

    // \TODO actually base curve on the target
    _curve = new BezierCurveScalar(curveValues as List<num>);
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  /// Callback for when the value of [easing] changes.
  ///
  /// This will trigger the creation of the [curve] which will be used for the
  /// animation.
  @Observe('easing')
  void easingChanged(dynamic value) {
    createCurve();
  }
}
