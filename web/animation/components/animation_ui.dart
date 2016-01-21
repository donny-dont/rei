// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationUI] class.
@HtmlImport('animation_ui.html')
library rei.web.animation.components.animation_ui;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:rei/animation.dart';

import 'addable.dart';
import 'animation_creator.dart';
import 'removable.dart';

//---------------------------------------------------------------------
// Components
//---------------------------------------------------------------------

import 'package:rei/components/layout.dart';

import 'styling.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Tag name for the class.
const String _tagName = 'rei-animation-ui';

@PolymerRegister(_tagName)
class AnimationUI extends PolymerElement with Addable {
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
  // Properties
  //---------------------------------------------------------------------

  html.Element animatedElement;

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
    var animationUI = new PolymerDom(this).children[0] as AnimationCreator;

    var elementDom = new PolymerDom(animatedElement);

    elementDom.children.clear();

    var animation = animationUI.createAnimation() as Animation;
    animation.animatedElement = animatedElement;

    elementDom.append(animation);

    async(() {
      if (animation is ComputedTiming) {
        animation.calculateTimings();
      }
      animation.play();
    });
  }

  @reflectable
  void stop([html.Event event, _]) {

  }

  @Listen(Removable.removeElementEvent)
  void onRemoveElement([html.CustomEvent event, _]) {
    event.stopPropagation();

    new PolymerDom(this).removeChild(event.target);

    // Add the button back
    _enableAdd();
  }

  void onElementAdded() {
    super.onElementAdded();

    _disableAdd();
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
