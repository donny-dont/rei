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

import '../../animation_target.dart';

import 'animation.dart';
import 'animation_manager.dart';
import 'animation_target_value.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@behavior
abstract class AnimationElement implements Animation {
  void play() {
    var manager = new AnimationManager();

    manager.add(this);
  }

  void pause() {
    var manager = new AnimationManager();

    manager.remove(this);
  }
}
