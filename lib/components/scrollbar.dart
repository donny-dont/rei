// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Scrollbar] class.
@HtmlImport('scrollbar.html')
library rei.components.scrollbar;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../animatable.dart';
import '../direction.dart';
import '../transformable.dart';
import '../property.dart';

import 'layout.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-scrollbar';

@PolymerRegister(_tagName)
class Scrollbar extends PolymerElement
                   with Animatable,
                        TransformableElement,
                        Transformable,
                        PolymerSerialize {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [Scrollbar] class.
  factory Scrollbar() =>
      new html.Element.tag(customTagName) as Scrollbar;

  /// Create an instance of the [Scrollbar] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  Scrollbar.created() : super.created();

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  @reiProperty
  Direction direction = Direction.horizontal;

  //---------------------------------------------------------------------
  // Animatable
  //---------------------------------------------------------------------

  @override
  html.Element get animatableElement => this;

  //---------------------------------------------------------------------
  // Transformable
  //---------------------------------------------------------------------

  @override
  num x = 0.0;

  @override
  num y = 0.0;

  @override
  num get scaleX => 1.0;
  set scaleX(num value) {
    throw new UnsupportedError('cannot set scaleX');
  }

  @override
  num get scaleY => 1.0;
  set scaleY(num value) {
    throw new UnsupportedError('cannot set scaleY');
  }

  @override
  bool get propagateTransformChange => false;

  //---------------------------------------------------------------------
  // TransformableElement
  //---------------------------------------------------------------------

  @override
  html.Element get transformableElement => $['thumb'];

  //---------------------------------------------------------------------
  // PolymerSerialize
  //---------------------------------------------------------------------

  @override
  dynamic deserialize(String value, Type type) =>
      (type == Direction)
          ? deserializeDirection(value)
          : super.deserialize(value, type);

  @override
  String serialize(Object value) =>
      (value is Direction)
          ? serializeDirection(value)
          : super.serialize(value);
}
