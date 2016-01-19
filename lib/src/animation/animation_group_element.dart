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

import 'animation.dart';
import 'animation_group.dart';
import 'computed_timing.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class AnimationGroupElement implements AnimationGroup,
                                                ComputedTiming,
                                                PolymerElement {
  //---------------------------------------------------------------------
  // AnimationGroup
  //---------------------------------------------------------------------

  @override
  List<ComputedTiming> get animations =>
      Polymer.dom(this).children as List<ComputedTiming>;

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @Listen(Animation.animationTimingChangedEvent)
  void onAnimationTimingChanged([html.CustomEvent event, _]) {

  }
}
