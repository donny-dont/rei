// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Transform] class.
library rei.components.transform;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/transformable.dart';
import 'package:rei/animatable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-transform';

@PolymerRegister(_tagName)
class Transform extends PolymerElement with Animatable, Transformable {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  /// The scaling in the X direction.
  @Property(reflectToAttribute: true)
  num scaleX = 1.0;
  /// The scaling in the Y direction.
  @Property(reflectToAttribute: true)
  num scaleY = 1.0;
  /// The translation in the X direction.
  @Property(reflectToAttribute: true)
  num x = 0.0;
  /// The translation in the Y direction
  @Property(reflectToAttribute: true)
  num y = 0.0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Transform] class.
  factory Transform() =>
      new html.Element.tag(customTagName) as Transform;

  /// Create an instance of the [Transform] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  Transform.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    style.display = 'none';
  }

  //---------------------------------------------------------------------
  // Animatable
  //---------------------------------------------------------------------

  @override
  html.Element get animatableElement => this;

  //---------------------------------------------------------------------
  // Transformable
  //---------------------------------------------------------------------

  @override
  bool get propagateTransformChange => true;
}
