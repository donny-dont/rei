// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Removable] mixin.
library rei.web.animation.removable;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class Removable implements PolymerElement {
  //---------------------------------------------------------------------
  // Class variables
  //---------------------------------------------------------------------

  /// Event for removing an element.
  static const removeElementEvent = 'remove-element';

  //---------------------------------------------------------------------
  // Callbacks
  //---------------------------------------------------------------------

  @reflectable
  void removeSelf([html.Event event, _]) {
    fire(removeElementEvent);
  }

  @Listen(removeElementEvent)
  void onRemoveElement([html.CustomEvent event, _]) {
    var target = event.target;

    if (target != this) {
      event.stopPropagation();

      new PolymerDom(this).removeChild(event.target);
    }
  }
}
