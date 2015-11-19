//  SONY CONFIDENTIAL MATERIAL. DO NOT DISTRIBUTE.
//  SNEI REI (Really Elegant Interface)
//  Copyright (C) 2014-2015 Sony Network Entertainment Inc
//  All Rights Reserved

/// Contains the [LinearSelectableTestElement] class.
@HtmlImport('linear_selectable_test_element.html')
library rei_linear_selectable_test_element;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Package libraries
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:rei/direction.dart';
import 'package:rei/src/selection/linear_selectable.dart';
import 'package:web_components/web_components.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-linear-selectable-test-element';

/// Test element for a [LinearSelectable] Polymer element.
@PolymerRegister(_tagName)
class LinearSelectableTestElement extends PolymerElement with LinearSelectable {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static String get customTagName => _tagName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [LinearSelectableTestElement] class.
  factory LinearSelectableTestElement() =>
      new html.Element.tag(customTagName) as LinearSelectableTestElement;

  /// Create an instance of the [LinearSelectableTestElement] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  LinearSelectableTestElement.created()
      : super.created();

  //---------------------------------------------------------------------
  // LinearSelectable methods
  //---------------------------------------------------------------------

  Direction direction = Direction.horizontal;
  List<html.Element> get selectableElements => children;
  bool canMoveBack = false;
  bool wrapStart = false;
  bool wrapEnd = false;
}
