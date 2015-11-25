// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationElement] mixin.
library rei.src.transform.animation_element;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'animation_manager.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class AnimationElement {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  static const String animationElementReadyEvent = 'animationelementready';

  //---------------------------------------------------------------------
  // Member variables
  //---------------------------------------------------------------------

  html.Element _animationElement;

  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The [html.Element] to apply the animation to.
  html.Element get animationElement => _animationElement;
  set animationElement(html.Element value) {
    var animationManager = new AnimationManager();

    if (_animationElement != null) {
      animationManager.remove(this);
    }

    _animationElement = value;

    if (_animationElement != null) {
      animationManager.add(this);
    }
  }

  //---------------------------------------------------------------------
  // PolymerElement
  //---------------------------------------------------------------------

  // \TODO Change to appropriate names after https://github.com/dart-lang/sdk/issues/23770

  html.CustomEvent fire(String type,
                       {detail,
                        bool canBubble: true,
                        bool cancelable: true,
                        html.Node node});

  void attachedAnimationElement() {
    fire(animationElementReadyEvent);
  }

  void detachedAnimationElement() {
    // Don't keep a reference to the animation element
    _animationElement = null;
  }

  //---------------------------------------------------------------------
  // Animation
  //---------------------------------------------------------------------

  void update(double dt);
}
