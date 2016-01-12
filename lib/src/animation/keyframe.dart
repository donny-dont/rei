// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Keyframe] mixin.
library rei.src.animation.keyframe;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/bezier_curve.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Represents a keyframe within an animation.
abstract class Keyframe<T> {
  /// The offset of the start of the keyframe.
  ///
  /// This needs to be a value in the range \[0, 1\]. The actual duration of
  /// the keyframe is determined by the offset which is a percentage of the
  /// animation's duration.
  num get frameOffset;
  set frameOffset(num value);

  /// The bezier curve to use when computing the animation value.
  ///
  /// If no curve is specified then the enclosing animation's keyframe will be
  /// used instead.
  BezierCurve get curve;
  set curve(BezierCurve value);

  /// The value of the keyframe.
  T get value;
}
