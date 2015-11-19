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
import 'package:rei/direction.dart';
import 'package:rei/src/selection/linear_selectable.dart';
import 'package:web_components/web_components.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-selection-group';

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

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [SelectionGroup] class.
  factory SelectionGroup() =>
      new html.Element.tag(SelectionGroup.customTagName) as SelectionGroup;

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
  dynamic deserialize(String value, Type type) {
    return (type == Direction)
        ? deserializeDirection(value)
        : super.deserialize(value, type);
  }

  @override
  String serialize(Object value) {
    return (value is Direction)
        ? serializeDirection(value)
        : super.serialize(value);
  }
}
