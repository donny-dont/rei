// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [Viewless] mixin.
library rei.src.transform.transformable;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class Viewless implements PolymerElement {
  //---------------------------------------------------------------------
  // Polymer lifecycle
  //---------------------------------------------------------------------

  static void ready(Viewless element) {
    element.style.display = 'none';
  }
}
