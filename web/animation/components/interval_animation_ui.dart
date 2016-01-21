// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [IntervalAnimationUI] class.
@HtmlImport('interval_animation_ui.html')
library rei.web.animation.components.interval_animation_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'animation_creator.dart';
import 'removable.dart';

//---------------------------------------------------------------------
// Component imports
//---------------------------------------------------------------------

import 'package:rei/components/layout.dart';
import 'package:rei/components/transition.dart';

import 'animation_timing_ui.dart';
import 'easing_animation_ui.dart';
import 'styling.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-interval-animation-ui';

@PolymerRegister(_tagName)
class IntervalAnimationUI extends PolymerElement
                             with Removable
                       implements AnimationCreator {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  /// The starting value of the animation.
  @property String start = '0';
  /// The ending value of the animation.
  @property String end = '1';

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [IntervalAnimationUI] class.
  factory IntervalAnimationUI() =>
      new html.Element.tag(customTagName) as IntervalAnimationUI;

  /// Create an instance of the [IntervalAnimationUI] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  IntervalAnimationUI.created() : super.created();

  //---------------------------------------------------------------------
  // AnimationCreator
  //---------------------------------------------------------------------

  @override
  html.Element createAnimation() {
    var animation = new Transition();

    // Get values from this
    animation.start = double.parse(start);
    animation.end = double.parse(end);

    // Get values from easing animation
    var easingUI = $['easing'] as EasingAnimationUI;
    easingUI.applyValues(animation);

    // Get timing values
    var timingUI = $['timing'] as AnimationTimingUI;
    timingUI.applyValues(animation);

    return animation;
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void changePlaybackDirection([html.Event event, _]) {
    set('playbackDirection', (event.target as html.SelectElement).value);
  }
}
