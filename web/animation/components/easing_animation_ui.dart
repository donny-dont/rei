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

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-keyframe-ui';

@PolymerRegister(_tagName)
class EasingAnimationUI extends PolymerElement {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  /// The value for the keyframe.
  @property String value = '0';
  /// The offset for the keyframe.
  @property String frameOffset = '';

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
}
