// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Animatable] mixin.
library rei.src.animatable;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/animation.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class Animatable {
  //---------------------------------------------------------------------
  // Properties
  //---------------------------------------------------------------------

  /// The element that should be animated.
  html.Element get animatableElement;

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @Listen(AnimationElement.animationElementReadyEvent)
  void onAnimationElementReady([html.CustomEvent event, _]) {
    event.stopPropagation();

    var animationElement = event.target as AnimationElement;

    animationElement.animationElement = animatableElement;
  }
}
