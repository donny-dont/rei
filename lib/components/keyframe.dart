// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Keyframe] class.
library rei.components.keyframe;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import '../animation.dart' as animation;
import '../easing_function.dart';
import '../property.dart';
import '../viewless.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-keyframe';

/// An element that holds keyframe information.
@PolymerRegister(_tagName)
class Keyframe extends PolymerElement with animation.EasingValue,
                                           animation.Keyframe,
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
  num value = 1.0;
  @override
  @reiProperty
  num frameOffset;
  @override
  @reiProperty
  dynamic easing;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Keyframe] class.
  factory Keyframe() =>
      new html.Element.tag(customTagName) as Keyframe;

  /// Create an instance of the [Keyframe] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  Keyframe.created() : super.created();

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
    }

    return super.deserialize(value, type);
  }

  @override
  String serialize(Object value) =>
      (value is EasingFunction)
          ? serializeEasingFunction(value) : super.serialize(value);

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @Observe('frameOffset')
  void frameOffsetChanged(num value) {
    // Notify that the animation has changed
    fire(animation.Animation.animationTimingChangedEvent);
  }
}
