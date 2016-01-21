// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [KeyframeAnimation] class.
library rei.src.animation.keyframe_animation;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/bezier_curve.dart';

import 'animation.dart';
import 'animation_value.dart';
import 'computed_timing.dart';
import 'keyframe.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class KeyframeAnimation implements Animation,
                                            AnimationValue,
                                            ComputedTiming {
  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  /// The animated element.
  html.Element _animatedElement;
  /// The current value of the animation.
  dynamic _value;
  /// The computed keyframes.
  final List<Keyframe> _computedKeyframes = <Keyframe>[];

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The keyframes associated with the animation.
  List<Keyframe> get keyframes;

  /// The bezier curve used to animate the value.
  BezierCurve get curve;

  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  @override
  html.Element get animatedElement => _animatedElement;
  set animatedElement(html.Element value) {
    // Determine if keyframes should be computed
    if (_computedKeyframes.length == 0) {
      computeKeyframes();
    }

    _animatedElement = value;
  }

  //---------------------------------------------------------------------
  // AnimationValue
  //---------------------------------------------------------------------

  @override
  dynamic get value => _value;

  //---------------------------------------------------------------------
  // AnimationValue
  //---------------------------------------------------------------------

  @override
  void onLocalTimeUpdate() {
    var animationOffset = animationTime / duration;

    var currentFrame = _computedKeyframes[0];
    var currentOffset = currentFrame.frameOffset;
    var nextFrame = _computedKeyframes[1];
    var nextOffset = nextFrame.frameOffset;
    var i = 1;

    while (nextOffset < animationOffset) {
      currentFrame = nextFrame;
      currentOffset = nextOffset;

      ++i;
      nextFrame = _computedKeyframes[i];
      nextOffset = nextFrame.frameOffset;
    }

    _value = currentFrame.curve.solve(
        animationOffset - currentOffset,
        nextOffset - currentOffset,
        currentFrame.value,
        nextFrame.value
    );
  }

  //---------------------------------------------------------------------
  // Protected methods
  //---------------------------------------------------------------------

  void computeKeyframes() {
    // Store off the keyframes in case they're computed
    var frames = keyframes;
    var frameCount = frames.length;
    var lastFrame = frameCount - 1;

    // Frame count should always be at least 2
    assert(frameCount >= 2);

    // Do a pass over the keyframes to get the offsets.
    var offsets = new List<num>(frameCount);

    // Get all the frame offsets
    offsets[0] = frames[0].frameOffset ?? 0.0;

    for (var i = 1; i < lastFrame - 1; ++i) {
      offsets[i] = frames[i].frameOffset;
    }

    offsets[lastFrame] = frames[lastFrame].frameOffset ?? 1.0;

    // Compute any unknown values
    for (var i = 1; i < lastFrame - 1; ++i) {
      var currentOffset = offsets[i];

      // See if the offset needs to be computed
      if (currentOffset == null) {
        var previousOffset = offsets[i - 1];
        var nextKnownIndex = i + 1;
        var nextOffset;

        // Find the next known offset
        while (nextKnownIndex < frameCount) {
          nextOffset = offsets[nextKnownIndex];

          if (nextOffset != null) {
            break;
          }

          ++nextKnownIndex;
        }

        // Compute the range and step for the computed offsets
        var range = nextOffset - previousOffset;
        var step = range / (nextKnownIndex - (i - 1));

        // Set the offset values
        for (var j = i; j < nextKnownIndex; ++j) {
          previousOffset += step;
          offsets[j] = previousOffset;
        }

        // Move i along to the next known index
        i = nextKnownIndex;
      }
    }

    // Create the computed keyframes
    _computedKeyframes.length = frameCount;

    for (var i = 0; i < frameCount; ++i) {
      var frame = frames[i];
      var offset = offsets[i].toDouble();
      var frameCurve = frame.curve ?? curve;

      _computedKeyframes[i] =
          new _ComputedKeyframe(offset, frameCurve, frame.value);
    }
  }
}

/// Contains the computed values of [Keyframe]s contained within a
/// [KeyframeAnimation].
///
/// The [curve] and [frameOffset] of a [Keyframe] are optional. If they are not
/// provided then those values are computed based on the keyframes present in
/// the animation.
///
/// If the [frameOffset] is not provided by the [KeyframeAnimation] it is
/// computed based on the offset for the previous and next keyframe in the set.
/// If the keyframe is the first in the set then it's offset will be 0.0. If
/// the keyframe is the last in the set then it's offset will be 1.0. If the
/// previous keyframe's offset was 0.0 and the next keyframe's offset was 1.0
/// then the computed value will be the halfway point between the two which in
/// this case is 0.5.
///
/// If the [curve] is not provided then its value is set to the value of the
/// [KeyframeAnimation]'s curve.
class _ComputedKeyframe implements Keyframe {
  //---------------------------------------------------------------------
  // Keyframe
  //---------------------------------------------------------------------

  @override
  final double frameOffset;
  @override
  final BezierCurve curve;
  @override
  final dynamic value;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of [_ComputedKeyframe] with the given [frameOffset],
  /// [curve] and [value].
  _ComputedKeyframe(this.frameOffset, this.curve, this.value);
}
