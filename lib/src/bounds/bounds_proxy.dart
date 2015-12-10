// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [BoundsProxy] class.
library rei.src.bounds.bounds_proxy;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Imports
//---------------------------------------------------------------------

import 'package:rei/src/bounds.dart';

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

@proxy
class BoundsProxy implements html.Element {
  final html.Element proxied;

  BoundsProxy(this.proxied);

  html.Rectangle getBoundingClientRect() {
    return getAbsoluteBounds(proxied);
  }

  Map<String, String> get attributes => proxied.attributes;

  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}
