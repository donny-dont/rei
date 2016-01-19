// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Keyframe] class.
library rei.components.keyframe_animation;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/animation.dart' as animation;
import 'package:rei/animation_target.dart';
import 'package:rei/bezier_curve.dart';
import 'package:rei/easing_function.dart';
import 'package:rei/playback_direction.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-keyframe-animation';

/// An element that holds keyframe information.
@PolymerRegister(_tagName)
class KeyframeAnimation extends PolymerElement
                           with animation.AnimationElement,
                                animation.AnimationTimingElement,
                                animation.ComputedTiming,
                                animation.KeyframeAnimation<num>,
                                PolymerSerialize
                     implements animation.Animation,
                                animation.AnimationTiming {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  BezierCurve<num> curve;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  /// The easing function or bezier curve to use when computing the animation
  /// value.
  @Property(reflectToAttribute: true)
  dynamic easing = EasingFunction.ease;

  @override
  @Property(reflectToAttribute: true)
  num playbackRate = 1.0;
  @Property(reflectToAttribute: true)
  AnimationTarget animationTarget = AnimationTarget.opacity;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [KeyframeAnimation] class.
  factory KeyframeAnimation() =>
      new html.Element.tag(customTagName) as KeyframeAnimation;

  /// Create an instance of the [KeyframeAnimation] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  KeyframeAnimation.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    style.display = 'none';
  }

  //---------------------------------------------------------------------
  // PolymerSerialize
  //---------------------------------------------------------------------

  @override
  dynamic deserialize(String value, Type type) {
    if (type == null) {
      if (value.startsWith('[')) {
        type = List;
      } else {
        return deserializeEasingFunction(value);
      }
    } else if (type == PlaybackDirection) {
      return deserializePlaybackDirection(value);
    } else if (type == AnimationTarget) {
      return deserializeAnimationTarget(value);
    }

    return super.deserialize(value, type);
  }

  @override
  String serialize(Object value) {
    if (value is EasingFunction) {
      return serializeEasingFunction(value);
    } else if (value is PlaybackDirection) {
      return serializePlaybackDirection(value);
    } else if (value is AnimationTarget) {
      return serializeAnimationTarget(value);
    } else {
      return super.serialize(value);
    }
  }

  //---------------------------------------------------------------------
  // KeyframeAnimation
  //---------------------------------------------------------------------

  @override
  List<animation.Keyframe<num>> get keyframes =>
      Polymer.dom(this).children as List<animation.Keyframe<num>>;

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @Observe('easing')
  void easingChanged(dynamic value) {
    var curveValues = (value is EasingFunction)
        ? getEasingCurve(value)
        : value;

    curve = new BezierCurveScalar(curveValues as List<num>);
  }

  @Listen(animation.Animation.animationTimingChangedEvent)
  void onAnimationTimingChanged([html.CustomEvent event, _]) {
    var animationElement = event.detail;

    if (animationElement == animation.Keyframe) {
      // Stop propagation as keyframe changes do not affect the overall timing
      // of this animation. They just affect the computed keyframes
      event.stopPropagation();

      // Recompute the keyframes
      computeKeyframes();
    }
  }
}
