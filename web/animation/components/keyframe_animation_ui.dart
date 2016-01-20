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

import 'removable.dart';

//---------------------------------------------------------------------
// Component imports
//---------------------------------------------------------------------

import 'package:rei/components/layout.dart';
import 'package:rei/components/keyframe_animation.dart';

import 'animation_creator.dart';
import 'easing_animation_ui.dart';
import 'keyframe_ui.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-keyframe-animation-ui';

@PolymerRegister(_tagName)
class KeyframeAnimationUI extends PolymerElement with Removable implements AnimationCreator {
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
  Future<html.Element> createAnimation() {
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void addKeyframe([html.Event event, _]) {
    Polymer.dom(this).append(new KeyframeUI());
  }
}
