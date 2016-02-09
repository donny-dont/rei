// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.src.animation.animation_timing;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import '../../playback_direction.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// \TODO Write full docs
///
/// This interface roughly follows the AnimationEffectTiming interface from the
/// [Web Animation API](https://w3c.github.io/web-animations/#animationeffecttimingreadonly).
/// It does not contain the fillMode, as this is unsupported, and the easing is
/// not computed internally.
abstract class AnimationTiming {
  /// The number of milliseconds before the animation effect becomes active.
  num get delay;
  set delay(num value);
  /// The number of milliseconds after the animation effect completes before
  /// the animation is fully complete.
  num get endDelay;
  set endDelay(num value);
  num get iterationStart;
  set iterationStart(num value);
  /// The number of iterations for the animation.
  num get iterations;
  set iterations(num value);
  /// The duration for a single iteration of the animation in milliseconds.
  num get duration;
  set duration(num value);
  PlaybackDirection get direction;
  set direction(PlaybackDirection value);
}
