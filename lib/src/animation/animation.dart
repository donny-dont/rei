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
