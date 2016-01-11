// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [ComputedTiming] mixin.
library rei.src.transform.computed_timing;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation.dart';
import 'animation_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class ComputedTiming implements AnimationTiming, Animation2 {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  double _currentTime = 0.0;
  /// The active duration of the animation.
  double _activeDuration = 0.0;
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

  /// The computed end time of the animation.
  ///
  /// The value takes into account the [delay], [endDelay], and
  /// [activeDuration] values to get when the animation is complete. This value
  /// is computed using the following formula.
  ///
  ///     endTime = max(delay + activeDuration + endDelay, 0.0);
  double get endTime => _endTime;

  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  double get currentTime => _currentTime;
  set currentTime(num value) {
    _currentTime = value.toDouble();

    if (_currentTime < 0.0) {
      _currentTime = 0.0;
    }

    // Compute the local time

    // Notify the implementation that the value is changed
    onLocalTimeUpdate();
  }

  //---------------------------------------------------------------------
  // Internal methods
  //---------------------------------------------------------------------

  /// Calculates the timings of the animation.
  ///
  /// This should be called whenever any values within the [AnimationTiming]
  /// interface are changed.
  void calculateTimings() {
    // Compute the active duration
    _activeDuration = (iterations - iterationStart) * duration;

    // Compute the end time of the animation
    var endTime = delay + endDelay + _activeDuration;

    _endTime = (endTime >= 0.0) ? endTime : 0.0;
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  void onLocalTimeUpdate();

  //---------------------------------------------------------------------
  // Private methods
  //---------------------------------------------------------------------

}
