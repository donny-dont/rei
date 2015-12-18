// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [EasingAnimation] class.
library rei.components.easing_animation;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/animation.dart';
import 'package:rei/animation_target.dart';
import 'package:rei/bezier_curve.dart';
import 'package:rei/easing_function.dart';
import 'package:rei/playback_direction.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-easing-animation';

/// An element that performs an easing animation.
@PolymerRegister(_tagName)
class EasingAnimation extends PolymerElement
                         with AnimationElement,
                              BezierCurveAnimation<num>,
                              IntervalAnimation,
                              PolymerSerialize {
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
  @override
  @Property(reflectToAttribute: true)
  num delay = 0.0;
  @override
  @Property(reflectToAttribute: true)
  int iterations = 1;
  @Property(reflectToAttribute: true)
  num duration = 1.0;
  @Property(reflectToAttribute: true)
  num start = 0.0;
  @Property(reflectToAttribute: true)
  num end = 1.0;
  @Property(reflectToAttribute: true)
  PlaybackDirection direction = PlaybackDirection.forward;
  @Property(reflectToAttribute: true)
  AnimationTarget animationTarget = AnimationTarget.opacity;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [EasingAnimation] class.
  factory EasingAnimation() =>
      new html.Element.tag(customTagName) as EasingAnimation;

  /// Create an instance of the [EasingAnimation] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  EasingAnimation.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    style.display = 'none';
  }

  void attached() {
    async(attachedAnimationElement);
  }

  void detached() {
    detachedAnimationElement();
  }

  //---------------------------------------------------------------------
  // PolymerSerialize
  //---------------------------------------------------------------------

  @override
  dynamic deserialize(String value, Type type) {
    if (type == dynamic) {
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
  // Callbacks
  //---------------------------------------------------------------------

  @Observe('easing')
  void easingChanged(dynamic value) {
    var curveValues = (value is EasingFunction)
        ? getEasingCurve(value)
        : value;

    curve = new BezierCurveScalar(curveValues as List<num>);
  }
}
