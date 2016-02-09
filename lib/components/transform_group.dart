// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [SelectionGroup] class.
@HtmlImport('transform_group.html')
library rei.components.transform_group;

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
import '../property.dart';
import '../selectable.dart';
import '../transformable.dart';

import 'layout.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-transform-group';

/// Contains a linear selectable group of elements whose position will be
/// transformed.
@PolymerRegister(_tagName)
class TransformGroup extends PolymerElement
                        with Animatable,
                             LinearSelectable,
                             TransformableElement,
                             Transformable,
                             PolymerSerialize {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Attributes
  //---------------------------------------------------------------------

  @override
  @reiProperty
  Direction direction = Direction.horizontal;
  @override
  @reiProperty
  bool canMoveBack = true;
  @override
  @reiProperty
  bool wrapStart = false;
  @override
  @reiProperty
  bool wrapEnd = false;
  @override
  @reiProperty
  num scaleX = 1.0;
  @override
  @reiProperty
  num scaleY = 1.0;
  @override
  @reiProperty
  num x = 0.0;
  @override
  @reiProperty
  num y = 0.0;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [TransformGroup] class.
  factory TransformGroup() =>
      new html.Element.tag(customTagName) as TransformGroup;

  /// Create an instance of the [TransformGroup] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  TransformGroup.created() : super.created();

  //---------------------------------------------------------------------
  // Animatable
  //---------------------------------------------------------------------

  @override
  html.Element get animatableElement => this;

  //---------------------------------------------------------------------
  // LinearSelectable
  //---------------------------------------------------------------------

  @override
  List<html.Element> get selectableElements =>
      (Polymer.dom(this) as PolymerDom).children;

  //---------------------------------------------------------------------
  // TransformableElement
  //---------------------------------------------------------------------

  @override
  html.Element get transformableElement => this;

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
