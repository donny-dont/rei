// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationGroup] mixin.
library rei.src.transform.animation_group;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation.dart';
import 'animation_group.dart';
import 'animation_timing.dart';
import 'computed_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------


abstract class SequencedAnimation implements AnimationGroup,
                                             AnimationTiming,
                                             ComputedTiming {
  //---------------------------------------------------------------------
  // AnimationTiming
  //---------------------------------------------------------------------

  @override
  num get duration {
    var totalTime = 0.0;

    for (var animation in animations) {
      totalTime += animation.endTime;
    }

    return totalTime;
  }

  //---------------------------------------------------------------------
  // ComputedTiming
  //---------------------------------------------------------------------

  @override
  void onLocalTimeUpdate() {
    var time = animationTime;

    // Update the current time for all the animations
    for (var animation in animations) {
      animation.currentTime = time;

      // Subtract the end time to get the correct time
      time -= animation.endTime;
    }
  }
}

