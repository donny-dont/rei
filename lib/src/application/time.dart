// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Time] class.
library rei.src.application.time;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Information on the time of the application.
class Time {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The shared instance of the [Time].
  static final Time _instance = new Time._();

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The time at the beginning of the frame.
  double _currentTime = 0.0;
  /// The time in milliseconds that it took to complete the last frame.
  double _deltaTime = 0.0;
  /// The total number of frames that have passed.
  int _frames = 0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Time] class.
  ///
  /// Only one instance of the [Time] class is available.
  factory Time() => _instance;

  /// Creates an instance of the [Time] class.
  Time._();

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The time at the beginning of the frame.
  double get currentTime => _currentTime;

  /// The time in milliseconds that it took to complete the last frame.
  double get deltaTime => _deltaTime;

  /// The total number of frames that have passed.
  int get frames => _frames;

  //---------------------------------------------------------------------
  // Class methods
  //---------------------------------------------------------------------

  /// Updates the current time.
  ///
  /// This is meant to be called at the beginning of the animation frame.
  static void update(double time) {
    var lastTime = _instance._currentTime;

    _instance._currentTime = time;
    _instance._deltaTime = time - lastTime;
    _instance._frames++;
  }
}
