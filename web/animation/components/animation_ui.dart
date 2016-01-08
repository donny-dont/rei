// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationUI] class.
@HtmlImport('animation_ui.html')
library rei.web.animation.components.animation_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'removable.dart';

//---------------------------------------------------------------------
// Components
//---------------------------------------------------------------------

import 'package:rei/components/layout.dart';

import 'interval_animation_ui.dart';
import 'keyframe_animation_ui.dart';
import 'keyframe_ui.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-animation-ui';

@PolymerRegister(_tagName)
class AnimationUI extends PolymerElement {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// The name of the tag.
  static const String customTagName = _tagName;

  //---------------------------------------------------------------------
  // Construction
  //---------------------------------------------------------------------

  /// Creates an instance of the [AnimationUI] class.
  factory AnimationUI() =>
      new html.Element.tag(customTagName) as AnimationUI;

  /// Create an instance of the [AnimationUI] class.
  ///
  /// This constructor should not be called directly. Instead use the
  /// default constructor.
  AnimationUI.created() : super.created();

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  void attached() {
    if (Polymer.dom(this).children.length == 0) {
      _enableAdd();
    } else {
      _disableAdd();
    }
  }

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void play([html.Event event, _]) {

  }

  @reflectable
  void stop([html.Event event, _]) {

  }

  @reflectable
  void showMenu([html.Event event, _]) {
    $['menu'].classes.remove('hide');
  }

  @reflectable
  void hideMenu([html.Event event, _]) {
    $['menu'].classes.add('hide');
  }

  @reflectable
  void addIntervalAnimation([html.Event event, _]) {
    new PolymerDom(this).append(new IntervalAnimationUI());

    hideMenu();
    _disableAdd();
  }

  @reflectable
  void addKeyframeAnimation([html.Event event, _]) {
    var keyframeAnimation = new KeyframeAnimationUI();

    // Add an initial keyframe
    Polymer.dom(keyframeAnimation).append(new KeyframeUI());

    // Add the keyframe animation
    new PolymerDom(this).append(keyframeAnimation);

    hideMenu();
    _disableAdd();
  }

  @Listen(Removable.removeElementEvent)
  void onRemoveElement([html.CustomEvent event, _]) {
    event.stopPropagation();

    new PolymerDom(this).removeChild(event.target);

    // Add the button back
    _enableAdd();
  }

  /// Removes the ability to click the add button
  void _disableAdd() {
    $['add'].classes.add('disabled');
  }

  /// Enables the ability to click the add button
  void _enableAdd() {
    $['add'].classes.remove('disabled');
  }
}
