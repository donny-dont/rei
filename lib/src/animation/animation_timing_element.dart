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

import 'package:rei/playback_direction.dart';

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
  @Property(reflectToAttribute: true)
  num delay = 0.0;
  @override
  @Property(reflectToAttribute: true)
  num endDelay = 0.0;
  @override
  @Property(reflectToAttribute: true)
  num iterationStart = 0.0;
  @override
  @Property(reflectToAttribute: true)
  int iterations = 1;
  @Property(reflectToAttribute: true)
  num duration = 1.0;
  @Property(reflectToAttribute: true)
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
