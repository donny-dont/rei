// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [IntervalAnimation] interface.
library rei.src.animation.interval_animation;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/playback_direction.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation whose value is determined based on an interval.
abstract class IntervalAnimation {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The current total time of the animation.
  double _currentTime = 0.0;
  /// The current animation time.
  double _animationTime = 0.0;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The number of iterations the animation should go through before stopping.
  int get iterations;

  /// The rate at which the animation progresses.
  ///
  /// This value can be used to speed up, when greater than 1.0, or slow down,
  /// when less than 1.0, the playback of the animation.
  num get playbackRate;

  /// The direction to playback in.
  PlaybackDirection get direction;
  /// The duration of a single iteration of the animation.
  num get duration;

  /// The current time of the animation.
  ///
  /// Setting this value will update the [animationTime] to a time reflecting
  /// the values of the animation.
  double get currentTime => _currentTime;
  set currentTime(double value) {
    _currentTime = value;

    _computeAnimationTime();
  }

  /// The time of the animation.
  ///
  /// This value takes into account the [direction] and [iterations] specified.
  ///
  /// It is only updated when [currentTime] is modified.
  double get animationTime => _animationTime;

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Computes the animation time.
  void _computeAnimationTime() {
    var durationDouble = duration.toDouble();

    // Compute the animation time
    _animationTime = _currentTime % durationDouble;

    // Get the current iteration
    var currentIteration = (_currentTime / durationDouble).floor();

    // Check to see if the time should be clamped
    if (currentIteration >= iterations) {
      _currentTime = iterations * durationDouble;
      _animationTime = durationDouble;

      currentIteration = iterations - 1;
    }

    // Determine the direction of the animation
    var reverse;

    if (direction == PlaybackDirection.reverse) {
      reverse = true;
    } else if (direction == PlaybackDirection.alternate) {
      reverse = (currentIteration % 2) == 1;
    } else if (direction == PlaybackDirection.alternateReverse) {
      reverse = (currentIteration % 2) == 0;
    } else {
      reverse = false;
    }

    // Flip the animation time if necessary
    if (reverse) {
      _animationTime = duration - _animationTime;
    }
  }
}
