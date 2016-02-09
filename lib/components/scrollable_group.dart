// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [SelectionGroup] class.
@HtmlImport('scrollable_group.html')
library rei.components.scrollable_group;

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
import '../animation_target.dart';
import '../direction.dart';
import '../property.dart';
import '../selectable.dart';
import '../transformable.dart';

import 'kinetic_animation.dart';
import 'layout.dart' as layout;
import 'scrollbar.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-scrollable-group';

///
/// A [ScrollableGroup] uses [KineticAnimation] to animate the scrolling
/// behavior.
///
/// A [Scrollbar] is visible if [scrollbar] is true. Otherwise it will not be
/// displayed. This is only useful if the size of the scrollable area is
/// finite.
///
/// This element uses styling from within [layout].
@PolymerRegister(_tagName)
class ScrollableGroup extends PolymerElement
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
  /// Whether the scrollbar should be visible.
  @reiProperty
  bool scrollbar = false;
  @Property(computed: 'computeTarget(direction)')
  AnimationTarget animationTarget = AnimationTarget.translateX;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [ScrollableGroup] class.
  factory ScrollableGroup() =>
      new html.Element.tag(customTagName) as ScrollableGroup;

  /// Create an instance of the [ScrollableGroup] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  ScrollableGroup.created() : super.created();

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
  html.Element get transformableElement => $['content-wrapper'];

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void scrollTo(num value) {
    var animation = $['animation'] as KineticAnimation;

    animation.end = -value;
  }

  //---------------------------------------------------------------------
  // Computed properties
  //---------------------------------------------------------------------

  @reflectable
  AnimationTarget computeTarget(Direction value) =>
      (direction == Direction.horizontal)
          ? AnimationTarget.translateX
          : AnimationTarget.translateY;

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
