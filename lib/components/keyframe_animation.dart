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
const String _tagName = 'rei-keyframe';

/// An element that holds keyframe information.
@PolymerRegister(_tagName)
class KeyframeAnimation extends PolymerElement
                           with animation.AnimationElement,
                                animation.KeyframeAnimation<num>,
                                animation.IntervalAnimation {
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
  PlaybackDirection direction = PlaybackDirection.forward;
  @Property(reflectToAttribute: true)
  AnimationTarget animationTarget = AnimationTarget.opacity;

  // \TODO end????
  num get end => 1.0;

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
  // KeyframeAnimation
  //---------------------------------------------------------------------

  @override
  List<animation.Keyframe<num>> get keyframes =>
      Polymer.dom(this).children as List<animation.Keyframe<num>>;
}
