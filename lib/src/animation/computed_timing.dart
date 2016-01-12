// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [ComputedTiming] mixin.
library rei.src.transform.computed_timing;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/playback_direction.dart';

import 'animation.dart';
import 'animation_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class ComputedTiming implements AnimationTiming, Animation2 {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The current time of the animation.
  double _currentTime = 0.0;
  /// The current animation time of the animation.
  double _animationTime = 0.0;
  /// The current iteration of the animation.
  int _currentIteration = 0;
  /// The active duration of the animation.
  double _activeDuration = 0.0;
  /// The last iteration.
  double _iterationEnd = 0.0;
  /// The end time of the animation.
  double _endTime = 0.0;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The active duration of the animation.
  ///
  /// This value takes into account the number of [iterations], the
  /// [iterationStart], and the [duration] of the animation. This value is
  /// computed using the following formula.
  ///
  ///     activeDuration = (iterations - iterationStart) * duration;
  ///
  /// This value goes against the current Web Animations API specification as
  /// that does not take into account the [iterationStart] value. An
  /// [issue was filed](https://github.com/w3c/web-animations/issues/137) to
  /// potentially modify the behavior according to this implementation.
  double get activeDuration => _activeDuration;

  /// The iteration the animation ends on.
  double get iterationEnd => _iterationEnd;

  /// The computed end time of the animation.
  ///
  /// The value takes into account the [delay], [endDelay], and
  /// [activeDuration] values to get when the animation is complete. This value
  /// is computed using the following formula.
  ///
  ///     endTime = max(delay + activeDuration + endDelay, 0.0);
  double get endTime => _endTime;

  /// The current time of the animation.
  ///
  /// This value is within the range \[0.0, duration\].
  double get animationTime => _animationTime;

  /// The current iteration of the animation.
  int get currentIteration => _currentIteration;

  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  double get currentTime => _currentTime;
  set currentTime(num value) {
    var lastTime = _currentTime;

    _currentTime = value.toDouble();

    var complete = false;

    // Ensure the time is bounded
    if (_currentTime < 0.0) {
      _currentTime = 0.0;
      complete = lastTime > 0.0;
    } else if (_currentTime > _endTime) {
      _currentTime = _endTime;
      complete = lastTime < _endTime;
    }

    // Compute the animation time
    if (lastTime != _currentTime) {
      var lastAnimationTime = _animationTime;

      _computeAnimationTime();

      // Notify the implementation that the value is changed
      if (lastAnimationTime != _animationTime) {
        onLocalTimeUpdate();
      }

      // \TODO Send the completion event
      if (complete) {
        print('Animation complete :)');
      }
    }
  }

  //---------------------------------------------------------------------
  // Internal methods
  //---------------------------------------------------------------------

  /// Calculates the timings of the animation.
  ///
  /// This should be called whenever any values within the [AnimationTiming]
  /// interface are changed.
  void calculateTimings() {
    var iterationsDouble = iterations.toDouble();

    // Compute the active duration
    _activeDuration = iterationsDouble * duration.toDouble();

    // Compute the last iteration
    _iterationEnd = iterationsDouble + iterationStart.toDouble();

    // Compute the end time of the animation
    var endTime = delay.toDouble() + endDelay.toDouble() + _activeDuration;

    _endTime = (endTime >= 0.0) ? endTime : 0.0;
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  void onLocalTimeUpdate();

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

  /// Computes the time of the animation.
  void _computeAnimationTime() {
    var durationDouble = duration.toDouble();
    var delayDouble = delay.toDouble();

    if (_currentTime < delayDouble) {
      // Get the start iteration
      var iterationStartDouble = iterationStart.toDouble();
      _currentIteration = iterationStartDouble.floor();
      _animationTime =
          (iterationStartDouble - _currentIteration.toDouble()) * durationDouble;
    } else {
      var offsetTime = _currentTime - delayDouble;
      var iteration = offsetTime / durationDouble;

      // See if the iteration needs to be capped
      if (iteration > _iterationEnd) {
        iteration = _iterationEnd;
      }

      _currentIteration = iteration.floor();
      _animationTime = offsetTime % durationDouble;
    }

    // Determine the direction of the animation
    var reverse;

    if (direction == PlaybackDirection.reverse) {
      reverse = true;
    } else if (direction == PlaybackDirection.alternate) {
      reverse = (_currentIteration % 2) == 1;
    } else if (direction == PlaybackDirection.alternateReverse) {
      reverse = (_currentIteration % 2) == 0;
    } else {
      reverse = false;
    }

    // Flip the animation time if necessary
    if (reverse) {
      _animationTime = duration - _animationTime;
    }
  }
}
