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

import '../shared/loop.dart';

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

  // Start the update loop
  start();
}
