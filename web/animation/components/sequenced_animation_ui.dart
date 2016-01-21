// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [KeyframeAnimationUI] class.
@HtmlImport('sequenced_animation_ui.html')
library rei.web.animation.components.sequenced_animation_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'addable.dart';
import 'removable.dart';

//---------------------------------------------------------------------
// Component imports
//---------------------------------------------------------------------

import 'package:rei/components/layout.dart';

import 'styling.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-sequenced-animation-ui';

@PolymerRegister(_tagName)
class SequencedAnimationUI extends PolymerElement with Addable, Removable {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [SequencedAnimationUI] class.
  factory SequencedAnimationUI() =>
      new html.Element.tag(customTagName) as SequencedAnimationUI;

  /// Create an instance of the [SequencedAnimationUI] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  SequencedAnimationUI.created() : super.created();
}
