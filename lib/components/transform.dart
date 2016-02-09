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

import '../animatable.dart';
import '../property.dart';
import '../transformable.dart';
import '../viewless.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-transform';

@PolymerRegister(_tagName)
class Transform extends PolymerElement
                   with Animatable,
                        Transformable,
                        Viewless {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  /// The scaling in the X direction.
  @reiProperty
  num scaleX = 1.0;
  /// The scaling in the Y direction.
  @reiProperty
  num scaleY = 1.0;
  /// The translation in the X direction.
  @reiProperty
  num x = 0.0;
  /// The translation in the Y direction
  @reiProperty
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
