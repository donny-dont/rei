// Copyright (c) 2015, the Rei Project Authors.
// Please see the AUTHORS file for details. All rights reserved.

/// Contains the [AnimationValue] interface.
library rei.src.animation.animation_value;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

/// An animation with a single value.
abstract class AnimationValue<T> {
  /// The value of the animation at the current time.
  T get value;
}
