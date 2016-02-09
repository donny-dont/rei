// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [SelectionGroup] class.
@HtmlImport('selection_group.html')
library rei.components.selection_group;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../direction.dart';
import '../property.dart';
import '../selectable.dart';

import 'layout.dart' as layout;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-selection-group';

/// Contains a linear selectable group of elements.
///
/// This element uses styling from within [layout].
@PolymerRegister(_tagName)
class SelectionGroup extends PolymerElement
    with LinearSelectable, PolymerSerialize {
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

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [SelectionGroup] class.
  factory SelectionGroup() =>
      new html.Element.tag(customTagName) as SelectionGroup;

  /// Create an instance of the [SelectionGroup] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  SelectionGroup.created() : super.created();

  //---------------------------------------------------------------------
  // LinearSelectable methods
  //---------------------------------------------------------------------

  @override
  List<html.Element> get selectableElements =>
      (Polymer.dom(this) as PolymerDom).children;

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
