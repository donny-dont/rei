// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.web.animation.main;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:async';
import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:polymer/polymer.dart';

import '../shared/loop.dart';
import 'components/interval_animation_ui.dart';
import 'components/keyframe_animation_ui.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// Application entry-point.
/// [KeyframeUI]
Future<Null> main() async {
  print('STARTING');
  await initPolymer();
  print('THE POLYMERS THEY ARE INITED');

  html.document.body.style.opacity = '1';

  // Start the update loop
  start();
}
