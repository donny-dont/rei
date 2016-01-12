// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

@TestOn('browser')
library rei.test.src.animation.computed_timing_test;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:test/test.dart';

import 'package:rei/animation.dart';
import 'package:rei/playback_direction.dart';
import 'package:rei/src/animation/animation_timing.dart';
import 'package:rei/src/animation/computed_timing.dart';

import '../common/expect_double.dart';

//---------------------------------------------------------------------
// Tests
//---------------------------------------------------------------------

/// Testing for [ComputedTiming].
class _ComputedTimingImpl extends Animation2
                             with ComputedTiming
                       implements AnimationTiming {
  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  @override
  num playbackRate = 1.0;

  @override
  void play() {}
  @override
  void pause() {}

  //---------------------------------------------------------------------
  // AnimationTiming
  //---------------------------------------------------------------------

  @override
  num delay = 0.0;
  @override
  num endDelay = 0.0;
  @override
  num iterationStart = 0.0;
  @override
  num iterations = 1.0;
  @override
  num duration = 0.0;
  @override
  PlaybackDirection direction = PlaybackDirection.forward;

  //---------------------------------------------------------------------
  // ComputedTiming
  //---------------------------------------------------------------------

  @override
  void onLocalTimeUpdate() {}
}

/// Test the endTime calculation.
void _endTime() {
  var duration = 1000.0;
  var delay = 1000.0;
  var endDelay = 1000.0;
  var iterations = 10.0;

  var computed = new _ComputedTimingImpl()
      ..duration = duration;

  computed.calculateTimings();

  expect(computed.endTime, duration);

  computed
      ..delay = delay
      ..calculateTimings();

  expect(computed.endTime, duration + delay);

  computed
      ..endDelay = endDelay
      ..calculateTimings();

  expect(computed.endTime, duration + delay + endDelay);

  computed
      ..iterations = iterations
      ..calculateTimings();

  expect(computed.endTime, iterations * duration + delay + endDelay);

  // Check a negative delay
  computed
      ..iterations = 1.0
      ..delay = -10000000.0
      ..calculateTimings();

  expect(computed.endTime, 0.0);
}

/// Test the animationTime calculation.
void _animationTime() {
  var duration = 1000.0;
  var delay = 1000.0;
  var endDelay = 1000.0;
  var iterations = 10.0;

  // Check the forward direction
  var computed = new _ComputedTimingImpl()
      ..duration = duration
      ..delay = delay
      ..endDelay = endDelay
      ..iterations = iterations;

  computed.calculateTimings();

  for (var i = 0.0; i < delay; i += 1.0) {
    computed.currentTime = i;

    expect(computed.currentIteration, 0);
    expect(computed.animationTime, 0.0);
  }

  for (var j = 0.0; j < iterations; j += 1.0) {
    var startTime = delay + duration * j;
    var iteration = j.floor();

    for (var i = 0.0; i < duration; i += 1.0) {
      computed.currentTime = startTime + i;

      expect(computed.currentIteration, iteration);
      expectDouble(computed.animationTime, i);
    }
  }

  for (var i = 0.0; i < endDelay; i += 1.0) {
    computed.currentTime = delay + duration * iterations + i;

    expect(computed.currentIteration, iterations.floor());
    expectDouble(computed.animationTime, duration);
  }
}

//---------------------------------------------------------------------
// Entry point
//---------------------------------------------------------------------

void main() {
  test('endTime', _endTime);
  test('animationTime', _animationTime);
}
