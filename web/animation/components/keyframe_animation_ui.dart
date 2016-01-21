// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [KeyframeAnimationUI] class.
@HtmlImport('keyframe_animation_ui.html')
library rei.web.animation.components.keyframe_animation_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

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
import 'package:rei/components/keyframe_animation.dart';

import 'animation_timing_ui.dart';
import 'easing_animation_ui.dart';
import 'keyframe_ui.dart';
import 'styling.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-keyframe-animation-ui';

@PolymerRegister(_tagName)
class KeyframeAnimationUI extends PolymerElement
                             with Removable
                       implements AnimationCreator {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [KeyframeAnimationUI] class.
  factory KeyframeAnimationUI() =>
      new html.Element.tag(customTagName) as KeyframeAnimationUI;

  /// Create an instance of the [KeyframeAnimationUI] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  KeyframeAnimationUI.created() : super.created();

  //---------------------------------------------------------------------
  // AnimationCreator
  //---------------------------------------------------------------------

  @override
  html.Element createAnimation() {
    var keyframeUIs = Polymer.dom(this).children as List<KeyframeUI>;
    var animation = new KeyframeAnimation();
    var animationDom = Polymer.dom(animation);

    // Get values from easing animation
    var easingUI = $['easing'] as EasingAnimationUI;
    easingUI.applyValues(animation);

    // Get timing values
    var timingUI = $['timing'] as AnimationTimingUI;
    timingUI.applyValues(animation);

    for (var keyframe in keyframeUIs) {
      animationDom.append(keyframe.createKeyframe());
    }

    return animation;
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void addKeyframe([html.Event event, _]) {
    Polymer.dom(this).append(new KeyframeUI());
  }
}
