// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [SyncedAnimation] mixin.
library rei.src.animation.synced_animation;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'animation_update.dart';
import 'interval_animation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// A grouped animation where the animations play in sync with each other.
abstract class SyncedAnimation<T> implements AnimationUpdate {
  /// The animations that should play together.
  List<AnimationUpdate> get animations;

  void timeUpdateInternal(double dt) {
    for (var animation in animations) {
      animation.timeUpdate(dt);
    }
  }
}
