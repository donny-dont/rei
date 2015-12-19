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

import 'package:rei/animation.dart' as animation;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-keyframe';

/// An element that holds keyframe information.
@PolymerRegister(_tagName)
class Keyframe extends PolymerElement with animation.Keyframe<num> {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  @override
  @Property(reflectToAttribute: true)
  num value = 1.0;
  @override
  @Property(reflectToAttribute: true)
  num frameOffset;

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
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    style.display = 'none';
  }
}
