// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [EasingAnimationUI] class.
@HtmlImport('easing_animation_ui.html')
library rei.web.animation.components.easing_animation_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:rei/animation.dart';
import 'package:rei/animation_target.dart';
import 'package:rei/easing_function.dart';

import 'enum_option.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-easing-animation-ui';

@PolymerRegister(_tagName)
class EasingAnimationUI extends PolymerElement with EnumOption {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  /// The value for the keyframe.
  @property String easingFunction;
  /// The offset for the keyframe.
  @property String animationTarget;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [KeyframeUI] class.
  factory EasingAnimationUI() =>
      new html.Element.tag(customTagName) as EasingAnimationUI;

  /// Create an instance of the [EasingAnimationUI] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  EasingAnimationUI.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void attached() {
    addOptions(
        $['easing'] as html.SelectElement,
        'easingFunction',
        EasingFunction.values,
        serializeEasingFunction
    );

    addOptions(
        $['target'] as html.SelectElement,
        'animationTarget',
        AnimationTarget.values,
        serializeAnimationTarget
    );
  }

  void applyValues(Animation animation) {
    if (animation is EasingValue) {
      var easingValue = animation as EasingValue;
      print('adding easing function');
      easingValue.easing = deserializeEasingFunction(easingFunction);
      easingValue.createCurve();
      print(easingValue.easing);
    }
    animation.animationTarget = deserializeAnimationTarget(animationTarget);
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void changeEasingFunction([html.Event event, _]) {
    set('easingFunction', (event.target as html.SelectElement).value);
  }

  @reflectable
  void changeAnimationTarget([html.Event event, _]) {
    set('animationTarget', (event.target as html.SelectElement).value);
  }
}
