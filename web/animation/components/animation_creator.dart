// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationCreator] interface.
library rei.web.animation.components.animation_creator;

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class AnimationCreator {
  html.Element createAnimation();
}
