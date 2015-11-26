// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.web.transform.main;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import 'package:rei/components/easing_animation.dart';
import 'package:rei/components/selection_group.dart';
import 'package:rei/components/transform.dart';
import 'package:rei/components/transform_group.dart';
import 'package:rei/components/kinetic_animation.dart';
import 'package:rei/animation.dart';
import 'package:rei/selection_visualizer.dart';
import 'package:rei/transformable.dart';
import 'package:rei/src/bounds.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Application entry-point.
/// [TransformGroup]
/// [Transform]
/// [EasingAnimation]
/// [KineticAnimation]
Future<Null> main() async {
  await initPolymer();

  html.document.body.style.opacity = '1';

  // Create the transformable manager and update the current positioning
  var transformableManager = new TransformableManager();
  transformableManager.update();

  // Get the root selection
  var root = html.querySelector(SelectionGroup.customTagName) as SelectionGroup;

  // Compute the bounds tree
  computeBoundsTree(root);

  // Create the visualizer
  var visualizer = new SelectionVisualizer('canvas');
  visualizer.root = root;

  // Create the animation manager
  var animationManager = new AnimationManager();

  var lastTime = await html.window.animationFrame;

  while (true) {
    var time = await html.window.animationFrame;

    animationManager.update(time - lastTime);
    transformableManager.update();
    visualizer.draw();

    lastTime = time;
  }
}
