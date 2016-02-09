// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Transition] class.
library rei.components.transition;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import '../animation.dart' as animation;
import '../animation_target.dart';
import '../easing_function.dart';
import '../playback_direction.dart';
import '../property.dart';
import '../viewless.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-transition';

/// An element that performs an easing animation.
@PolymerRegister(_tagName)
class Transition extends PolymerElement
                       with animation.AnimationElement,
                            animation.AnimationTimingElement,
                            animation.ComputedTiming,
                            animation.EasingValue,
                            animation.Transition,
                            PolymerSerialize,
                            Viewless {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  @override
  @reiProperty
  num playbackRate = 1.0;
  @reiProperty
  AnimationTarget animationTarget = AnimationTarget.opacity;
  @override
  @reiProperty
  dynamic easing = EasingFunction.ease;
  @override
  @reiProperty
  num start = 0.0;
  @override
  @reiProperty
  num end = 1.0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Transition] class.
  factory Transition() =>
      new html.Element.tag(customTagName) as Transition;

  /// Create an instance of the [Transition] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  Transition.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerSerialize
  //---------------------------------------------------------------------

  @override
  dynamic deserialize(String value, Type type) {
    if (type == animation.EasingValue.easingType) {
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
}
