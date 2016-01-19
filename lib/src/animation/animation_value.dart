// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

library rei.src.animation.animation_value;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

abstract class AnimationValue<T> {
  /// The value of the animation at it's current time.
  T get value;
}
