// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [KeyframeAnimation] class.
library rei.src.animation.keyframe_animation;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation.dart';
import 'bezier_curve.dart';
import 'keyframe.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class KeyframeAnimation<T> implements Animation {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The value of the animation at the current animation time.
  double _value;

  /// The keyframes associated with the animation.
  List<Keyframe<T>> get keyframes;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The bezier curve used to animate the value.
  BezierCurve get curve;
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

    // Get the current animation time based on percentage
    var percentDone = (animationTime * 0.01) / duration;
    var previous = keyframes[0];
    var current;

    for (var keyframe in keyframes) {
      if (keyframe.offset <= percentDone) {
        current = keyframe;
        break;
      }

      previous = keyframe;
    }

    // Compute the value
    var startTime = duration * previous.offset;
    var endTime = duration * current.offset;
    var keyframeDuration = endTime - startTime;

    var normalizedTime = animationTime - startTime;

    _value = curve.solve(
        normalizedTime,
        keyframeDuration,
        previous.value as num,
        current.value
    );
  }

  //---------------------------------------------------------------------
  // IntervalAnimation
  //---------------------------------------------------------------------

  double get currentTime;
  set currentTime(double value);
  double get animationTime;
}
