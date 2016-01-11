// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Animation] interface.
library rei.src.animation.animation;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation based on time.
abstract class Animation<T> {
  //---------------------------------------------------------------------
  // Class members
  //---------------------------------------------------------------------

  /// The distance at which the animation should consider itself complete.
  ///
  /// Used to snap to the target so the animation does not loop endlessly.
  static const double threshold = 0.25;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The endpoint of the animation.
  T get end;
  /// The current value of the animation.
  ///
  /// This is computed internally by the implementing class based on the
  /// current time. It should be accessed after a call to [timeUpdate] to get
  /// the current value.
  T get value;

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Updates the animation using the given time difference, [dt].
  void timeUpdate(double dt);
}

abstract class Animation2 {
  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// The rate of playback for the animation.
  ///
  /// To increase the speed of the animation the value should be greater than
  /// 1.0. To slow down the speed of animation the value should be between
  /// \[0.0, 1.0\]. To reverse the animation a negative value can be used for
  /// cases where the animation is based on an interval.
  num get playbackRate;
  set playbackRate(num value);

  /// The current time of the animation.
  ///
  /// This value will be in the range of 0.0 to the total time of the animation
  /// based on its total effect time.
  ///
  /// Typically this value is only modified when the animation is being updated
  /// through the [AnimationManager]. However the value can be manually changed
  /// in code to perform a scrubbing operation for an animation specified by
  /// an interval. When modifying it directly the [playbackRate] is not taken
  /// into consideration. This is different behavior than the Web Animations API
  /// which applies the [playbackRate].
  double get currentTime;
  set currentTime(double value);

  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Begins the animation.
  void play();
  /// Pauses the animation.
  void pause();
}
