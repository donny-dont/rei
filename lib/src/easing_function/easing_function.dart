// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.src.easing_function.easing_function;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/src/enum_serializer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An enumeration for various easing functions.
///
/// An easing function specifies the rate of change over time. They are used to
/// provide more natural looking animations.
///
/// The following values are defined in the
/// [CSS Transitions specification](http://www.w3.org/TR/css3-transitions/).
/// - [EasingFunction.linear]
/// - [EasingFunction.ease]
/// - [EasingFunction.easeIn]
/// - [EasingFunction.easeOut]
/// - [EasingFunction.easeInOut]
///
/// The behavior will be equivalent to using the CSS transition specification
/// directly.
///
/// The rest of the values correspond to additional easing functions specified
/// by Robert Penner. The actual curves were taken from the
/// [Compass Caesar](https://github.com/jhardy/compass-ceaser-easing) library,
/// and are approximations of the original equations.
enum EasingFunction {
  //---------------------------------------------------------------------
  // CSS transition defined easing functions
  //---------------------------------------------------------------------

  /// A transition effect with the same speed from start to end.
  ///
  /// Corresponds to the bezier curve (0.0, 0.0, 1.0, 1.0). The value is the
  /// same as specified in transition-timing-function: linear.
  linear,
  /// A transition effect with a slow start, then fast, then ending slowly.
  ///
  /// Corresponds to the bezier curve (0.25, 0.1, 0.25, 1.0). The value is the
  /// same as specified in transition-timing-function: ease.
  ease,
  /// A transition effect with a slow start.
  ///
  /// Corresponds to the bezier curve (0.42, 0.0, 1.0, 1.0). The value is the
  /// same as specified in transition-timing-function: ease-in.
  easeIn,
  /// A transition effect with a slow end.
  ///
  /// Corresponds to the bezier curve (0.0, 0.0, 0.58, 1.0). The value is the
  /// same as specified in transition-timing-function: ease-out.
  easeOut,
  /// A transition effect with a slow start and end.
  ///
  /// Corresponds to the bezier curve (0.42, 0.0, 0.58, 1.0). The value is the
  /// same as specified in transition-timing-function: ease-out.
  easeInOut,

  //---------------------------------------------------------------------
  // Robert Penner easing functions
  //---------------------------------------------------------------------

  /// Quadratic ease in transition.
  ///
  /// Corresponds to the bezier curve (0.550, 0.085, 0.680, 0.530).
  easeInQuadratic,
  /// Quadratic ease in transition.
  ///
  /// Corresponds to the bezier curve (0.550, 0.055, 0.675, 0.190).
  easeInCubic,
  /// Quartic ease in transition.
  ///
  /// Corresponds to the bezier curve (0.895, 0.030, 0.685, 0.220).
  easeInQuartic,
  /// Quintic ease in transition.
  ///
  /// Corresponds to the bezier curve (0.755, 0.050, 0.855, 0.060).
  easeInQuintic,
  /// Sine wave ease in transition.
  ///
  /// Corresponds to the bezier curve (0.470, 0.000, 0.745, 0.715).
  easeInSine,
  /// Exponential ease in transition.
  ///
  /// Corresponds to the bezier curve (0.950, 0.050, 0.795, 0.035).
  easeInExponential,
  /// Circular ease in transition.
  ///
  /// Corresponds to the bezier curve (0.600, 0.040, 0.980, 0.335).
  easeInCircle,
  /// Back ease in transition.
  ///
  /// Results in values below 0.0.
  ///
  /// Corresponds to the bezier curve (0.600, -0.280, 0.735, 0.045).
  easeInBack,

  /// Quadratic ease out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeOutQuadratic,
  /// Quadratic ease out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeOutCubic,
  /// Quartic ease out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeOutQuartic,
  /// Quintic ease out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeOutQuintic,
  /// Sine wave ease out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeOutSine,
  /// Exponential ease out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeOutExponential,
  /// Circular ease out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeOutCircle,
  /// Back ease out transition.
  ///
  /// Results in values above 1.0.
  ///
  /// Corresponds to the bezier curve ().
  easeOutBack,

  /// Quadratic ease in-out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutQuadratic,
  /// Quadratic ease in-out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutCubic,
  /// Quartic ease in-out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutQuartic,
  /// Quintic ease in-out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutQuintic,
  /// Sine wave ease in-out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutSine,
  /// Exponential ease in-out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutExponential,
  /// Circular ease in-out transition.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutCircle,
  /// Back ease in-out transition.
  ///
  /// Results in values below 0.0 and above 1.0.
  ///
  /// Corresponds to the bezier curve ().
  easeInOutBack,
}

//---------------------------------------------------------------------
// Serialization
//---------------------------------------------------------------------

/// Deserializes the [value] into the equivalent [EasingFunction].
///
/// If no value can be found the default is [EasingFunction.ease].
EasingFunction deserializeEasingFunction(String value) =>
    deserializeEnum(value, EasingFunction.values, EasingFunction.ease.index);

/// Serializes the [value] into a string.
String serializeEasingFunction(EasingFunction value) =>
    serializeEnum(value);
