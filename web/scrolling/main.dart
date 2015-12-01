// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.web.scrolling.main;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/components/kinetic_animation.dart';
import 'package:rei/components/scrollbar.dart';
import 'package:rei/components/scrollable_group.dart';
import 'package:rei/animation.dart';
import 'package:rei/transformable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Application entry-point.
/// [Scrollbar]
/// [KineticAnimation]
/// [ScrollableGroup]
Future<Null> main() async {
  await initPolymer();

  html.document.body.style.opacity = '1';

  // Create the transformable manager and update the current positioning
  var transformableManager = new TransformableManager();
  transformableManager.update();

  // Create the animation manager
  var animationManager = new AnimationManager();

  var lastTime = await html.window.animationFrame;

  while (true) {
    var time = await html.window.animationFrame;

    animationManager.update(time - lastTime);
    transformableManager.update();

    lastTime = time;
  }
}
