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

import 'package:rei/components/transform.dart';
import 'package:rei/components/transform_group.dart';
import 'package:rei/transformable.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Application entry-point.
/// [TransformGroup]
/// [Transform]
Future<Null> main() async {
  await initPolymer();

  var transformableManager = new TransformableManager();

  while (true) {
    var time = await html.window.animationFrame;

    //print(time);
    transformableManager.update();
  }
}
