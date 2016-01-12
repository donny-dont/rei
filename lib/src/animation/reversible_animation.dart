// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [KeyframeAnimation] class.
library rei.src.animation.keyframe_animation;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation whose playback can be reversed.
///
/// This is not included in [Animation] as any non-interval based animation
/// cannot be reversed.
abstract class ReversibleAnimation implements Animation2 {
  //---------------------------------------------------------------------
  // Public methods
  //---------------------------------------------------------------------

  /// Reverses the playback of the animation.
  ///
  /// If the animation was running forward and had reached the end then it will
  /// begin playback at the end running backwards. The animation will end up
  /// triggering a finished event once it reaches a time of 0.0.
  ///
  /// This method can be called multiple times in succession and will toggle
  /// the animation from running forward to backwards. The finished event will
  /// only trigger when it has completed in either of the direction though.
  ///
  /// This will just multiply the [playbackRate] by -1 to trigger the playback
  /// to go in the opposite direction.
  void reverse() {
    playbackRate *= -1.0;
  }
}
