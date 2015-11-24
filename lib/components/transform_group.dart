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

import 'package:rei/direction.dart';
import 'package:rei/selectable.dart';
import 'package:rei/transformable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-transform-group';

/// Contains a linear selectable group of elements whose position will be
/// transformed.
@PolymerRegister(_tagName)
class TransformGroup extends PolymerElement
                        with LinearSelectable,
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
  @Property(reflectToAttribute: true)
  Direction direction = Direction.horizontal;
  @override
  @Property(reflectToAttribute: true)
  bool canMoveBack = true;
  @override
  @Property(reflectToAttribute: true)
  bool wrapStart = false;
  @override
  @Property(reflectToAttribute: true)
  bool wrapEnd = false;
  @override
  @Property(reflectToAttribute: true)
  num scaleX = 1.0;
  @override
  @Property(reflectToAttribute: true)
  num scaleY = 1.0;
  @override
  @Property(reflectToAttribute: true)
  num x = 0.0;
  @override
  @Property(reflectToAttribute: true)
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
  // LinearSelectable methods
  //---------------------------------------------------------------------

  @override
  List<html.Element> get selectableElements =>
      (Polymer.dom(this) as PolymerDom).children;

  //---------------------------------------------------------------------
  // TransformableElement methods
  //---------------------------------------------------------------------

  @override
  html.Element get transformableElement => this;

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void ready() {
    readyTransformableElement();
  }

  void attached() {
    attachedTransformableElement();
  }

  void detached() {
    detachedTransformableElement();
  }

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
