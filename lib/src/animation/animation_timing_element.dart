// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationTimingElement] mixin.
library rei.src.transform.animation_timing_element;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import '../../playback_direction.dart';
import '../../property.dart';

import 'animation_timing.dart';
import 'computed_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class AnimationTimingElement implements AnimationTiming,
                                                 ComputedTiming {
  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  @override
  @reiProperty
  num delay = 0.0;
  @override
  @reiProperty
  num endDelay = 0.0;
  @override
  @reiProperty
  num iterationStart = 0.0;
  @override
  @reiProperty
  num iterations = 1;
  @reiProperty
  num duration = 1.0;
  @reiProperty
  PlaybackDirection direction = PlaybackDirection.forward;

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  /// Observer for when the timing values change.
  @Observe('delay,endDelay,iterationStart,iterations,direction')
  void timingChanged(num newDelay,
                     num newEndDelay,
                     num newIterationStart,
                     num newIterations,
                     PlaybackDirection newDirection) {
    calculateTimings();
  }
}
