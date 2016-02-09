// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [EasingAnimation] class.
library rei.components.kinetic_animation;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import '../animation.dart';
import '../animation_target.dart';
import '../property.dart';
import '../viewless.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-kinetic-animation';

/// An element that performs an easing animation.
@PolymerRegister(_tagName)
class KineticAnimation extends PolymerElement
                          with AnimationElement,
                               SpringAnimation,
                               PolymerSerialize,
                               Viewless {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [KineticAnimation] class.
  factory KineticAnimation() =>
      new html.Element.tag(customTagName) as KineticAnimation;

  /// Create an instance of the [KineticAnimation] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  KineticAnimation.created() : super.created();

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  @override
  @reiProperty
  num constant = 250.0;
  @override
  @reiProperty
  num friction = 50.0;
  @override
  @reiProperty
  num end = 0.0;
  @reiProperty
  AnimationTarget animationTarget = AnimationTarget.opacity;
  num get playbackRate => 1.0;

  //---------------------------------------------------------------------
  // PolymerSerialize
  //---------------------------------------------------------------------

  @override
  dynamic deserialize(String value, Type type) =>
      (type == AnimationTarget)
          ? deserializeAnimationTarget(value)
          : super.deserialize(value, type);

  @override
  String serialize(Object value) =>
      (value is AnimationTarget)
          ? serializeAnimationTarget(value)
          : super.serialize(value);
}
