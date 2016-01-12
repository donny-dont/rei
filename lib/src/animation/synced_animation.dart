// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [SyncedAnimation] mixin.
library rei.src.animation.synced_animation;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation_group.dart';
import 'animation_timing.dart';
import 'computed_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A grouped animation where the animations play in sync with each other.
abstract class SyncedAnimation implements AnimationGroup,
                                          AnimationTiming,
                                          ComputedTiming {
  //---------------------------------------------------------------------
  // AnimationTiming
  //---------------------------------------------------------------------

  @override
  num get duration => animations[0].duration;

  //---------------------------------------------------------------------
  // ComputedTiming
  //---------------------------------------------------------------------

  @override
  void onLocalTimeUpdate() {
    var time = animationTime;

    // Update the current time for all the animations
    for (var animation in animations) {
      animation.currentTime = time;
    }
  }
}
